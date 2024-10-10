// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';

FirebaseDatabase get database => SuperLibrary.instance.database;
fs.FirebaseFirestore get firestore => fs.FirebaseFirestore.instance;

const String joinSeparator = '---';

/// [currentUserUid] returns the current user's UID. It returns null if the user is not signed in.
String? get currentUserUid => fa.FirebaseAuth.instance.currentUser!.uid;

/// [myUid] returns the current user's UID. It throws an exception if the user is not signed in.
String get myUid {
  if (fa.FirebaseAuth.instance.currentUser == null) {
    throw Exception('[myUid] is called but the user is not signed in');
  }
  return fa.FirebaseAuth.instance.currentUser!.uid;
}

class SuperLibrary {
  static SuperLibrary? _instance;
  static SuperLibrary get instance => _instance ??= SuperLibrary._();

  SuperLibrary._();

  String? databaseURL;
  late final Function getDatabaseUrl;
  FirebaseDatabase? _database;

  bool initialized = false;

  bool debug = false;

  init({
    required Function getDatabaseUrl,
    debug = true,
  }) {
    this.getDatabaseUrl = getDatabaseUrl;
    this.debug = debug;

    initialized = true;
    UserService.instance.init();
  }

  FirebaseDatabase get database {
    if (initialized == false) {
      throw Exception('SuperLibrary is not initialized');
    }

    databaseURL ??= getDatabaseUrl();

    if (databaseURL == null) {
      throw Exception('SuperLibrary.databaseURL is null');
    }

    _database ??= FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: databaseURL!,
    );

    dog('databaseURL: $databaseURL');
    return _database!;
  }
}

class SuperLibraryException implements Exception {
  final String code;
  final String message;

  SuperLibraryException(
    this.code,
    this.message,
  );

  @override
  String toString() {
    return 'SuperLibraryException: ($code) $message';
  }
}

class ChatService {
  static ChatService? _instance;
  static ChatService get instance => _instance ??= ChatService._();

  ChatService._();

  DatabaseReference messagesRef(String roomId) =>
      database.ref('chat/messages').child(roomId);

  DatabaseReference get joinsRef => database.ref('chat/joins').child(myUid);

  DatabaseReference get roomsRef => database.ref('chat/rooms');

  DatabaseReference roomRef(String roomId) =>
      database.ref('chat/rooms').child(roomId);

  Future sendMessage({
    required String senderUid,
    String? receiverUid,
    String? roomId,
    String? message,
  }) async {
    // Add your function code here!
    assert(
      receiverUid != null || roomId != null,
      "receiverUid or roomId must be provided",
    );
    final data = {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'roomId': roomId,
      'message': message,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };

    roomId = roomId ?? makeSingleChatRoomId(senderUid, receiverUid!);
    await messagesRef(roomId).push().set(data);
  }

  /// TODO should it be make? or get
  String makeSingleChatRoomId(String? loginUid, String? otherUid) {
    if (loginUid == null) {
      throw SuperLibraryException('makeSingleChatRoomId', 'loginUid is null');
    }
    if (otherUid == null) {
      throw SuperLibraryException('makeSingleChatRoomId', 'otherUid is null');
    }
    final arr = [loginUid, otherUid];
    arr.sort();
    return arr.join(joinSeparator);
  }

  // TODO where to put this
  Future<int> getServerTimestamp() async {
    final ref = FirebaseDatabase.instance
        .ref()
        .child('chat')
        .child('-info')
        .child('timestamp');
    await ref.set(ServerValue.timestamp);
    final snapshot = await ref.get();
    return snapshot.value as int;
  }

  /// Join a chat room
  ///
  /// This method is used to join a chat room.
  ///
  ///
  /// Where:
  /// - It is called after the chat room created.
  /// - It is called after the user accepted the invitation.
  ///
  /// Logic:
  /// - It update the room.users with current user's uid. It's called as
  /// call-by-reference. So, the parent can use the updated room.users which
  /// includes the current user's uid.
  Future<void> join(
    ChatRoom room, {
    String? protocol,
  }) async {
    dog("Joining");

    if (room.joined) return;

    final timestamp = await getServerTimestamp();
    final negativeTimestamp = -1 * timestamp;

    // int timestamp = await getServerTimestamp();
    // final order = timestamp * -1; // int.parse("-1$timestamp");
    final joinValues = {
      // Incase there is an invitation, remove the invitation
      // TODO reimplement
      // invitedUserRef(myUid!).child(room.id).path: null,
      // In case, invitation was mistakenly rejected
      // TODO reimplement
      // rejectedUserRef(myUid!).child(room.id).path: null,
      // Add uid in users
      room.ref.child('users').child(myUid).path: true,
      // Add in chat joins
      'chat/joins/$myUid/${room.id}/joinedAt': ServerValue.timestamp,
      // Should be in top in order
      // This will make the newly joined room at top.
      'chat/joins/$myUid/${room.id}/order': negativeTimestamp,
      if (room.single)
        'chat/joins/$myUid/${room.id}/singleOrder': negativeTimestamp,
      if (room.group)
        'chat/joins/$myUid/${room.id}/groupOrder': negativeTimestamp,
      if (room.open)
        'chat/joins/$myUid/${room.id}/openOrder': negativeTimestamp,
    };

    /// Add your uid into the user list of the chat room instead of reading from database.
    /// * This must be here before await. So it can return fast.
    room.users[myUid] = true;
    await FirebaseDatabase.instance.ref().update(joinValues);

    // TODO how do we do report things
    // await sendMessage(
    //   room,
    // protocol: protocol ?? ChatProtocol.join,
    // );
  }
}

class ChatRoom {
  /// Field names used for the Firestore document
  static const field = (
    name: 'name',
    description: 'description',
    iconUrl: 'iconUrl',
    users: 'users',
    invitedUsers: 'invitedUsers',
    rejectedUsers: 'rejectedUsers',
    blockedUsers: 'blockedUsers',
    masterUsers: 'masterUsers',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    open: 'open',
    single: 'single',
    group: 'group',
    lastMessageAt: 'lastMessageAt',
    allMembersCanInvite: 'allMembersCanInvite',
    gender: 'gender',
    domain: 'domain',
  );

  /// [id] is the chat room id. This is the key of the chat room data.
  String id;

  /// [ref] is the data reference of the chat room.
  DatabaseReference get ref => ChatService.instance.roomsRef.child(id);

  /// [name] is the chat room name. If it does not exist, it is empty.
  String name;

  /// [description] is the chat room description. If it does not exist, it is empty.
  String description;

  /// The icon url of the chat room. optinal.
  String? iconUrl;

  /// [users] is the uid list of users who are join the room
  // Map<String, ChatRoomUser> users;
  Map<String, bool> users;

  /// Returns list of uids of members
  List<String> get userUids => users.keys.toList();

  /// [noOfUsers] is the number of users in the chat room.
  int get noOfUsers => users.length;

  bool get joined => userUids.contains(myUid);

  /// Map of `blocked-user-uid: true`.
  Map<String, bool> blockedUsers;
  List<String> get blockedUids => blockedUsers.keys.toList();

  List<String> masterUsers;

  DateTime createdAt;
  DateTime updatedAt;

  /// [open] is true if the chat room is open chat
  bool open;

  /// [single] is true if the chat room is single chat or 1:1.
  bool single;

  /// [group] is true if the chat room is group chat.
  bool group;

  /// [lastMessageAt] is the time when last message was sent to chat room.
  DateTime? lastMessageAt;

  /// [gender] to filter the chat room by user's gender.
  /// If it's M, then only male can enter the chat room. And if it's F,
  /// only female can enter the chat room.
  ///
  /// Note that, [gender] is not supported at this time.
  String gender;

  /// [domain] is the domain of the chat room. It can be the name of the app.
  ///
  String domain;

  bool allMembersCanInvite = false;

  /// Uids for single chat is combination of both users' uids separated by "---"
  /// Returns list of uids based on the room id.
  List<String> get uidsFromRoomId => id.contains("---") ? id.split("---") : [];

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    required this.open,
    required this.single,
    required this.group,
    required this.users,
    required this.masterUsers,
    this.blockedUsers = const {},
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    this.allMembersCanInvite = false,
    required this.gender,
    required this.domain,
  });

  /// Return the chat room object from the snapshot.
  factory ChatRoom.fromSnapshot(DataSnapshot data) {
    if (data.value is int) {
      dog("data.value is int");
    }
    return ChatRoom.fromJson(
        (Map<String, dynamic>.from(data.value as Map)), data.key!);
  }

  /// Return the chat room object from the json.
  factory ChatRoom.fromJson(Map<String, dynamic> json, String id) {
    return ChatRoom(
      id: id,
      name: json[field.name] ?? '',
      description: json[field.description] ?? '',
      iconUrl: json[field.iconUrl],
      open: json[field.open],
      single: json[field.single],
      group: json[field.group],
      users: json[field.users] is Map
          ? Map<String, bool>.from(json[field.users])
          : {},
      masterUsers: List<String>.from(json[field.masterUsers]),
      blockedUsers: Map<String, bool>.from(json[field.blockedUsers] ?? {}),
      createdAt: json[field.createdAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.createdAt])
          : DateTime.now(),
      updatedAt: json[field.updatedAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.updatedAt])
          : DateTime.now(),
      lastMessageAt: json[field.lastMessageAt] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json[field.lastMessageAt]),
      allMembersCanInvite: json[field.allMembersCanInvite] ?? false,
      gender: json[field.gender],
      domain: json[field.domain],
    );
  }

  /// Converts the model into Map<String, dynamic>
  ///
  /// * Use it only for debug purpose !!
  Map<String, dynamic> toJson() {
    return {
      field.name: name,
      field.description: description,
      field.iconUrl: iconUrl,
      field.open: open,
      field.single: single,
      field.group: group,
      field.users: users,
      field.masterUsers: masterUsers,
      field.blockedUsers: blockedUsers,
      field.createdAt: createdAt.millisecondsSinceEpoch,
      field.updatedAt: updatedAt.millisecondsSinceEpoch,
      field.lastMessageAt: lastMessageAt?.millisecondsSinceEpoch,
      field.allMembersCanInvite: allMembersCanInvite,
      field.gender: gender,
      field.domain: domain,
    };
  }

  @Deprecated(
      'DO NOT USE THIS: Why do we need this? Use it if it saved time and money')
  copyFromSnapshot(DataSnapshot doc) {
    copyFrom(ChatRoom.fromSnapshot(doc));
  }

  @Deprecated(
      'DO NOT USE THIS: Why do we need this? Use it if it saved time and money')
  copyFrom(ChatRoom room) {
    // copy all the fields from the room
    id = room.id;
    name = room.name;
    description = room.description;
    iconUrl = room.iconUrl;
    open = room.open;
    single = room.single;
    group = room.group;
    users = room.users;
    masterUsers = room.masterUsers;
    blockedUsers = room.blockedUsers;
    createdAt = room.createdAt;
    updatedAt = room.updatedAt;
    lastMessageAt = room.lastMessageAt;
    allMembersCanInvite = room.allMembersCanInvite;
    gender = room.gender;
    domain = room.domain;
  }

  /// toString
  @override
  String toString() {
    return 'ChatRoom(${toJson()})';
  }

  /// [create] creates a new chat room.
  ///
  /// Returns the database reference of the chat room.
  ///
  /// If [id] is null, this will make new room id (preferred for group chat)
  static Future<DatabaseReference> create({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    bool open = false,
    // Group == false means the chat room is single chat
    bool group = true,
    bool single = false,
    // String? password, (NOT IMPLEMENTED YET)
    required Map<String, bool>? users,
    List<String>? masterUsers,
    bool allMembersCanInvite = false,
    String gender = '',
    String domain = '',
  }) async {
    // TODO: Should (create and join) be one write upon create?
    if (single == true && (group == true || open == true)) {
      throw 'chat-room-create/single-cannot-be-group-or-open Single chat room cannot be group or open';
    }
    if (single == false && group == false) {
      throw 'chat-room-create/single-or-group Single or group chat room must be selected';
    }

    final newRoom = {
      if (name != null) field.name: name,
      if (description != null) field.description: description,
      if (iconUrl != null) field.iconUrl: iconUrl,
      field.open: open,
      field.single: single,
      field.group: group,
      // if (invitedUsers != null) field.invitedUsers: invitedUsers,
      field.users: [],
      field.masterUsers: [myUid],
      field.allMembersCanInvite: allMembersCanInvite,
      field.gender: gender,
      field.domain: domain,
      field.createdAt: ServerValue.timestamp,
      field.updatedAt: ServerValue.timestamp,
    };

    DatabaseReference newChatRoomRef;
    if (id == null) {
      newChatRoomRef = ChatService.instance.roomsRef.push();
    } else {
      newChatRoomRef = ChatService.instance.roomsRef.child(id);
    }

    /// Create the chat room. It's update method but it's creating a new chat room.
    await newChatRoomRef.update(newRoom);
    return newChatRoomRef;
  }

  /// [createSingle] creates a new single chat room.
  static Future<DatabaseReference> createSingle(
    String otherUid, {
    String domain = '',
  }) async {
    ///
    final ref = await create(
      group: false,
      open: false,
      single: true,
      id: singleChatRoomId(otherUid),
      users: {myUid: true},
      masterUsers: [myUid],
      domain: domain,
    );

    return ref;
  }

  // TODO review where to put this
  static const String chatRoomDivider = '---';

  // TODO review where to put this
  static String singleChatRoomId(String otherUserUid) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      // throw 'chat/auth-required Loign to get the sing chat room id';
      throw 'login to get the single chat room id';
    }
    final uids = [FirebaseAuth.instance.currentUser!.uid, otherUserUid];
    uids.sort();
    return uids.join(chatRoomDivider);
  }

  /// [get] gets the chat room by id.
  static Future<ChatRoom?> get(String id) async {
    final snapshot = await ChatService.instance.roomRef(id).get();
    if (snapshot.exists == false) return null;
    return ChatRoom.fromSnapshot(snapshot);
  }

  /// [update] updates the chat room.
  Future<void> update({
    String? name,
    String? description,
    String? iconUrl,
    bool? open,
    bool? single,
    bool? group,
    // bool? verifiedUserOnly,
    // bool? urlForVerifiedUserOnly,
    // bool? uploadForVerifiedUserOnly,
    bool? allMembersCanInvite,
    // String? gender,
    // String? domain,
    // Object? lastMessageAt,
  }) async {
    if (single == true && (group == true || open == true)) {
      throw 'chat-room-update/single-cannot-be-group-or-open Single chat room cannot be group or open';
    }
    if (single == false && group == false) {
      throw 'chat-room-update/single-or-group Single or group chat room must be selected';
    }
    final updateData = {
      if (name != null) field.name: name,
      if (description != null) field.description: description,
      if (iconUrl != null) field.iconUrl: iconUrl,
      if (open != null) field.open: open,
      if (single != null) field.single: single,
      if (group != null) field.group: group,
      if (allMembersCanInvite != null)
        field.allMembersCanInvite: allMembersCanInvite,
      field.updatedAt: ServerValue.timestamp,
    };

    await ref.update(updateData);
  }
}

class Value<T> extends StatelessWidget {
  const Value({
    super.key,
    required this.ref,
    required this.builder,
    this.initialData,
    this.onLoading,
    this.sync = true,
  });

  final DatabaseReference ref;

  final dynamic initialData;

  /// [dynamic] is the value of the node.
  /// [String] is the path of the node.
  final Widget Function(dynamic value, DatabaseReference ref) builder;
  final Widget? onLoading;

  final bool sync;

  @override
  Widget build(BuildContext context) {
    if (sync) {
      return StreamBuilder<dynamic>(
        initialData: initialData,
        stream: ref.onValue.map((event) {
          return event.snapshot.value;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // log('Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text('Error; path: ${ref.path}, message: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            // log('--> Value() -> Waiting; path: ${ref.path} connectionState: ${snapshot.connectionState}, hasData: ${snapshot.hasData}');
            return onLoading ?? const SizedBox.shrink();
          }

          // value may be null.
          return builder(snapshot.data as T, ref);
        },
      );
    } else {
      return FutureBuilder<dynamic>(
        initialData: initialData,
        future: ref.once().then((event) => event.snapshot.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            return onLoading ?? const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            // log('---> Value.once() -> Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text('Error; ${snapshot.error}');
          }

          return builder(snapshot.data as T, ref);
        },
      );
    }
  }
}

/// ValueListView
///
///
class ValueListView extends StatelessWidget {
  const ValueListView({
    super.key,
    required this.query,
    required this.builder,
    this.pageSize = 20,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.reverseQuery = false,
  });
  final Query query;
  final Widget Function(
    FirebaseQueryBuilderSnapshot snapshot,
    void Function(int index) fetchMore,
  ) builder;

  final int pageSize;
  final Widget Function()? loadingBuilder;
  final Widget Function(String)? errorBuilder;
  final Widget Function()? emptyBuilder;
  final bool reverseQuery;
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
      query: query,
      pageSize: pageSize,
      reverseQuery: reverseQuery,
      builder: (context, snapshot, _) {
        if (snapshot.hasError) {
          return errorBuilder?.call(snapshot.error.toString()) ??
              Center(child: Text('Something went wrong! ${snapshot.error}'));
        }

        if (snapshot.isFetching && snapshot.hasData == false) {
          return loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData && snapshot.docs.isEmpty && !snapshot.hasMore) {
          return emptyBuilder?.call() ??
              const Center(child: Text('Value list is empty'));
        }

        return builder(snapshot, (index) {
          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            snapshot.fetchMore();
          }
        });
      },
    );
  }
}

/// Memory
///
/// A static memory class to store data in memory
///
/// Note that any data that might be re-used must be stored in the memory (like
/// user data, chat room data, etc) with this Memeory class to not fetch the
/// data again and again. And this will help to reduce flickering and improve
/// the performance.
///
/// Usage:
/// ```dart
/// Memory.set('key', 'value);
/// final value = Memory.get<String>('key');
/// ```
class Memory {
  static final Map<String, dynamic> _data = {};

  static T? get<T>(String key) => _data[key] as T?;

  static void set<T>(String key, T value) {
    _data[key] = value;
  }
}

/// AuthStateChanges
///
/// Use this widget to listen to the login user's authentication state changes
/// and rebuild the UI accordingly. It simply wraps
/// [FirebaseAuth.instance.authStateChanges] insdie a [StreamBuilder].
///
/// [builder] is the UI builder callback that will be called when the user's
/// authentication state changes.
///
class AuthStateChanges extends StatelessWidget {
  const AuthStateChanges({super.key, required this.builder});

  final Widget Function(fa.User?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // To reduce the flickering
      initialData: fa.FirebaseAuth.instance.currentUser,
      stream: fa.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final user = snapshot.data;
        return builder(user);
      },
    );
  }
}

/// Realtime database chat join model
class ChatJoin {
  /// For field names
  static const field = (
    joinedAt: 'joinedAt',
    singleOrder: 'singleOrder',
    groupOrder: 'groupOrder',
    openOrder: 'openOrder',
    order: 'order',
    lastMessageUid: 'lastMessageUid',
    lastMessageAt: 'lastMessageAt',
    lastMessageDeleted: 'lastMessageDeleted',
    lastText: 'lastText',
    lastUrl: 'lastUrl',
    lastProtocol: 'lastProtocol',
    unreadMessageCount: 'unreadMessageCount',
    name: 'name',
    iconUrl: 'iconUrl',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
  );

  final String roomId;
  final int joinedAt;
  final int? singleOrder;
  final int? groupOrder;
  final int? openOrder;
  final int order;
  final String? lastMessageUid;
  final DateTime? lastMessageAt;
  final bool? lastMessageDeleted;
  final String? lastText;
  final String? lastUrl;
  final String? lastProtocol;

  final int unreadMessageCount;

  final String? name;
  final String? iconUrl;
  final String? displayName;
  final String? photoUrl;

  bool get group => groupOrder != null;
  bool get single => singleOrder != null;
  bool get open => openOrder != null;

  ChatJoin({
    required this.roomId,
    required this.joinedAt,
    required this.singleOrder,
    required this.groupOrder,
    required this.openOrder,
    required this.order,
    required this.lastMessageUid,
    required this.lastMessageAt,
    required this.lastMessageDeleted,
    required this.lastText,
    required this.lastUrl,
    required this.lastProtocol,
    this.unreadMessageCount = 0,
    this.name,
    this.iconUrl,
    this.displayName,
    this.photoUrl,
  });

  factory ChatJoin.fromSnapshot(DataSnapshot snapshot) {
    return ChatJoin.fromJson(snapshot.value as Map, snapshot.key!);
  }

  factory ChatJoin.fromJson(Map<dynamic, dynamic> json, String roomId) {
    return ChatJoin(
      roomId: roomId,
      joinedAt: json[field.joinedAt] is ServerValue
          ? DateTime.now().millisecondsSinceEpoch
          : json[field.joinedAt],
      singleOrder: json[field.singleOrder],
      groupOrder: json[field.groupOrder],
      openOrder: json[field.openOrder],
      order: json[field.order] is ServerValue
          ? DateTime.now().millisecondsSinceEpoch
          : json[field.order],
      lastMessageUid: json[field.lastMessageUid],
      lastMessageAt:
          DateTime.fromMillisecondsSinceEpoch(json[field.lastMessageAt] ?? 0),
      lastMessageDeleted: json[field.lastMessageDeleted],
      lastUrl: json[field.lastUrl],
      lastText: json[field.lastText],
      lastProtocol: json[field.lastProtocol],
      unreadMessageCount: json[field.unreadMessageCount] ?? 0,
      name: json[field.name],
      iconUrl: json[field.iconUrl],
      displayName: json[field.displayName],
      photoUrl: json[field.photoUrl],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      field.joinedAt: joinedAt,
      field.singleOrder: singleOrder,
      field.groupOrder: groupOrder,
      field.openOrder: openOrder,
      field.order: order,
      field.lastMessageUid: lastMessageUid,
      field.lastMessageAt: lastMessageAt,
      field.lastMessageDeleted: lastMessageDeleted,
      field.lastText: lastText,
      field.lastUrl: lastUrl,
      field.lastProtocol: lastProtocol,
      field.unreadMessageCount: unreadMessageCount,
      field.name: name,
      field.iconUrl: iconUrl,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
    };
  }
}

/// Realtime database user modeling class
class UserData {
  ///
  /// Field names used for the Firestore document
  static const field = (
    creatAt: 'createdAt',
    displayName: 'displayName',
    displayNameLowerCase: 'displayNameLowerCase',
    photoUrl: 'photoUrl',
  );

  final String uid;
  final int createdAt;
  final String displayName;
  final String displayNameLowerCase;
  final String photoUrl;

  UserData({
    required this.uid,
    required this.createdAt,
    required this.displayName,
    required this.displayNameLowerCase,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      field.creatAt: createdAt,
      field.displayName: displayName,
      field.displayNameLowerCase: displayNameLowerCase,
      field.photoUrl: photoUrl,
    };
  }

  factory UserData.fromJson(Map<dynamic, dynamic> json, String key) {
    return UserData(
      uid: key,
      createdAt: json[field.creatAt] ?? DateTime.now(),
      displayName: json[field.displayName] ?? '',
      displayNameLowerCase: json[field.displayNameLowerCase] ?? '',
      photoUrl: json[field.photoUrl] ?? '',
    );
  }

  factory UserData.fromSnapshot(DataSnapshot snapshot) {
    return UserData.fromJson(snapshot.value as Map, snapshot.key!);
  }

  /// Returns the user data from the Realtime database as UserData model
  ///
  /// This method is used to get the user data from the Realtime database.
  ///
  /// Returns null if the user data does not exist.
  ///
  /// TODO: make [getUserData] custom action based on this method.
  static Future<UserData?> get(String uid) async {
    // if (Memory.get(uid) != null) {
    //   return Memory.get(uid) as UserData;
    // }

    final snapshot = await UserService.instance.databaseUserRef(uid).get();
    if (snapshot.exists == false) {
      return null;
    }

    if (snapshot.value == null) {
      return null;
    }

    final userData = UserData.fromSnapshot(snapshot);

    // Memory.set(uid, userData);

    return userData;
  }
}

class UserService {
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();
  UserService._();

  /// Firestore collection name for users
  String collectionName = 'users';

  DatabaseReference get databaseUsersRef =>
      database.ref().child(collectionName);

  bool initialized = false;

  init() {
    dog('UserService.init:');
    mirror();
    initialized = true;
  }

  /// Firestore document reference for the current user
  fs.DocumentReference get myDoc {
    final user = fa.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myDoc: user is not signed in');
    }
    final ref = doc(user.uid);
    return ref;
  }

  /// Firestore document reference for the user with [uid]
  fs.DocumentReference doc(String uid) {
    final ref = firestore.collection(collectionName).doc(uid);

    dog('path of ref: ${ref.path}');
    return ref;
  }

  /// Database reference for the current user
  DatabaseReference get myDatabaseRef {
    final user = fa.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myDatabaseRef: user is not signed in');
    }
    final ref = databaseUserRef(user.uid);
    return ref;
  }

  /// Database reference for the user with [uid]
  DatabaseReference databaseUserRef(String uid) {
    final ref = database.ref().child(collectionName).child(uid);

    dog('path of ref: ${ref.path}');
    return ref;
  }

  DatabaseReference get myBlockedUsersRef {
    final user = fa.FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('UserService.myDoc: user is not signed in');
    }
    return database.ref().child('blocked-users').child(user.uid);
  }

  StreamSubscription<fa.User?>? mirrorSubscription;
  StreamSubscription? userDocumentSubscription;

  /// Mirror user's displayName, photoURL, and created_time only from Firestore to Database
  ///
  /// Why?
  /// The super library is using Firebase Realtime Database for chat and other
  /// functionalities. But the user's displayName and photoURL are stored in
  /// Firestore by FlutterFlow.
  mirror() {
    mirrorSubscription?.cancel();
    mirrorSubscription =
        fa.FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        dog('Super library -> mirror() -> User is not signed in. So, return');
        return;
      }

      dog('Super library -> mirror() -> User is signed in. So, mirror the user data');

      userDocumentSubscription?.cancel();
      userDocumentSubscription = doc(user.uid).snapshots().listen((snapshot) {
        if (snapshot.exists == false) {
          return;
        }

        final dataSnapshot = snapshot.data() as Map<String, dynamic>;

        if (dataSnapshot.keys.contains('blockedUsers') == true) {
          myBlockedUsersRef.set(dataSnapshot['blockedUsers']);
          return;
        }

        // TODO add a validation that will check if the field exists
        int stamp;
        if (dataSnapshot['created_time'] != null &&
            dataSnapshot['created_time'] is Timestamp) {
          stamp = (dataSnapshot['created_time'] as Timestamp)
              .millisecondsSinceEpoch;
        } else {
          stamp = DateTime.now().millisecondsSinceEpoch;
        }
        Map<String, dynamic> data = {
          UserData.field.creatAt: stamp,
          UserData.field.displayName: dataSnapshot['display_name'] ?? '',
          UserData.field.displayNameLowerCase:
              (dataSnapshot['display_name'] ?? '').toLowerCase(),
          UserData.field.photoUrl: dataSnapshot['photo_url'] ?? '',
        };

        databaseUserRef(user.uid).update(data);
      });
    });
  }
}

/// Component holder class.
class Component {
  static Widget Function(UserData)? userListTile;
  static Widget Function()? reportDialog;
}

extension SuperLibraryIntExtension on int {
  /// Change the integer of milliseconds to a DateTime object
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
}

/// DateTime extension
///
///
extension SuperLibraryDateTimeExtension on DateTime {
  /// Returns a string of "yyyy-MM-dd"
  String get short => shortDateTime;

  /// Returns date if the date is today, otherwise returns time
  ///
  String get shortDateTime {
    return isToday ? jm : md;
  }

  /// Returns a string of "yyyy-MM-dd"
  String get yMd {
    return DateFormat.yMd().format(this);
  }

  /// Converts a string to a DateTime object and returns it in YYYY-MM-DD HH:mm:ss format.
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get yMdjm {
    return DateFormat.yM().add_jm().format(this);
  }

  /// Converts a string to a DateTime object and returns it in MM-DD format.
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get md {
    return DateFormat.Md().format(this);
  }

  /// Returns a string of "yyyy-MM-dd HH:mm:ss"
  String get jm {
    return DateFormat.jm().format(this);
  }

  /// Returns in the format of 'jms' (e.g. 5:08:37 PM)
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get jms {
    return DateFormat.jms().format(this);
  }

  /// Returns a string of "yy-MM-dd"
  ///
  /// from: https://github.com/jayeshpansheriya/awesome_extensions/blob/main/lib/date_extensions/date_extension.dart
  bool get isToday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  /// Returns true if the date is tomorrow
  bool get isTomorrow {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day + 1;
  }

  /// Returns true if the date is past.
  ///
  /// It returns true even if it is today but the time is past.
  ///
  /// It is a simple alias of `isBefore(DateTime.now())`.
  bool get isPast {
    final nowDate = DateTime.now();
    return isBefore(nowDate);
  }

  /// Returns true if the date is future.
  ///
  /// It returns true even if it is today but the time is future.
  ///
  /// It is a simple alias of `isAfter(DateTime.now())`.
  ///
  /// See also: https://api.flutter.dev/flutter/dart-core/DateTime/isBefore.html
  /// See also: https://api.flutter.dev/flutter/dart-core/DateTime/compareTo.html
  bool get isFuture {
    final nowDate = DateTime.now();
    return isAfter(nowDate);
  }

  /// The day after this [DateTime]
  DateTime get nextDay => add(const Duration(days: 1));

  /// The day previous this [DateTime]
  DateTime get previousDay => subtract(const Duration(days: 1));
}

/// Print log message with emoji 🐶
void dog(dynamic msg, {int level = 0}) {
  if (kReleaseMode) return;
  if (SuperLibrary.instance.debug == false) return;
  log('--> ${msg.toString()}', time: DateTime.now(), name: '🐶', level: level);
}

class Report {
  final String id;
  final String reporter;
  final String reportee;
  final String path;
  final String reason;
  final String type;
  final String summary;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.reporter,
    required this.reportee,
    required this.path,
    required this.reason,
    required this.type,
    required this.summary,
    required this.createdAt,
  });

  static fs.CollectionReference get col => firestore.collection('reports');

  factory Report.fromSnapshot(DataSnapshot snapshot) {
    return Report.fromJson(
      Map<String, dynamic>.from(snapshot.value as Map),
      snapshot.key!,
    );
  }

  factory Report.fromJson(Map<String, dynamic> json, String id) {
    return Report(
      id: id,
      reporter: json['reporter'] ?? '',
      reportee: json['reportee'] ?? '',
      path: json['path'] ?? '',
      reason: json['reason'] ?? '',
      type: json['type'] ?? '',
      summary: json['summary'] ?? '',
      createdAt: json['createdAt'] != null && json['createdAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporter': reporter,
      'reportee': reportee,
      'path': path,
      'reason': reason,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Report(${toJson()})';
  }
}

Future superLibrary() async {
  // Add your function code here!
}

// End custom action code
