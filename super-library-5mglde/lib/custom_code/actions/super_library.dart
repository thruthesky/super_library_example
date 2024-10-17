// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'dart:developer';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';

import 'package:dio/dio.dart';
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Helpers
///
/// Helper functions, variables -------------------------------------------------------------------
///
FirebaseDatabase get database => SuperLibrary.instance.database;
fs.FirebaseFirestore get firestore => fs.FirebaseFirestore.instance;

/// [currentUserUid] returns the current user's UID. It returns null if the user is not signed in.
String? get currentUserUid => fa.FirebaseAuth.instance.currentUser!.uid;

/// [myUid] returns the current user's UID. It throws an exception if the user is not signed in.
String get myUid {
  if (fa.FirebaseAuth.instance.currentUser == null) {
    throw Exception('[myUid] is called but the user is not signed in');
  }
  return fa.FirebaseAuth.instance.currentUser!.uid;
}

/// User references --------------------------------------------------------------------------------
/// Database reference for the user with [uid]
DatabaseReference databaseUserRef(String uid) {
  return UserService.instance.databaseUserRef(uid);
}

/// Returns the user's photo url reference
DatabaseReference userPhotoUrlRef(String uid) =>
    databaseUserRef(uid).child(UserData.field.photoUrl);

/// Chat helpers -----------------------------------------------------------------------------------

/// Return true if the chat room is a single chat room.
bool isSingleChatRoom(roomId) => ChatService.instance.isSingleChatRoom(roomId);

/// Return the other user's uid from the single chat room id.
String otherUid(roomId) => ChatService.instance.getOtherUid(roomId);

DatabaseReference roomRef(String roomId) =>
    ChatService.instance.roomRef(roomId);

/// EO Helpers -------------------------------------------------------------------------------------

/// load site preview from the url
///
/// [text] is a text that contains the url.
///
/// It throws exception if it fails to get the site preview.
///
/// It returns null if it fails to get the site preview.
///
/// It returns the site preview data if it successfully gets the site preview.
/// But the fields might be null if the site preview data is not found.
Future<SitePreviewData?> loadSitePreview({
  required String text,
}) async {
  // Get the first url of in the text
  final RegExp urlRegex = RegExp(r'https?:\/\/\S+');
  final Match? match = urlRegex.firstMatch(text);
  final String? url = match?.group(0);
  if (url == null) {
    return null;
  }

  // Get the data from the url (internet)
  final dio = Dio();
  Response response;
  try {
    response = await dio.get(url);
  } catch (e) {
    dog('dio.get($url) Error: $e');
    throw SuperLibraryException(
        'load-site-preview/get-failed', 'Failed to get the site preview: $e');
  }
  dynamic res = response.data;
  if (res == null) {
    throw SuperLibraryException('load-site-preview/response-is-empty',
        'Result from dio.get($url) is null');
  }
  String html = res.toString();

  final Document doc = parse(html);

  String? title =
      getSitePreviewOGTag(doc, 'og:title') ?? getSitePreviewTag(doc, 'title');
  String? description = getSitePreviewOGTag(doc, 'og:description') ??
      getSitePreviewMeta(doc, 'description');
  String? imageUrl = getSitePreviewOGTag(doc, 'og:image');
  String? siteName = getSitePreviewOGTag(doc, 'og:site_name') ??
      getSitePreviewTag(doc, 'title');

  return SitePreviewData(
    url: url,
    title: title,
    description: description,
    imageUrl: imageUrl,
    siteName: siteName,
  );
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
    name: 'name',
    iconUrl: 'iconUrl',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
    inviterUid: 'inviterUid',
    inviterName: 'inviterName',
    newMessageCount: 'newMessageCount',
  );

  final String roomId;
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

  final int newMessageCount;

  // chat room name
  final String? name;
  // chat room icon url
  final String? iconUrl;

  // message sender's display name
  final String? displayName;

  // message sender's photo url
  final String? photoUrl;

  bool get group => groupOrder != null;
  bool get single => singleOrder != null;
  bool get open => openOrder != null;

  // Inviter's uid and name when the user is invited to the chat room.
  // Use this to display who invited who.
  String? inviterUid;
  String? inviterName;

  ChatJoin({
    required this.roomId,
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
    this.newMessageCount = 0,
    this.name,
    this.iconUrl,
    this.displayName,
    this.photoUrl,
    this.inviterUid,
    this.inviterName,
  });

  factory ChatJoin.fromSnapshot(DataSnapshot snapshot) {
    return ChatJoin.fromJson(snapshot.value as Map, snapshot.key!);
  }

  factory ChatJoin.fromJson(Map<dynamic, dynamic> json, String roomId) {
    return ChatJoin(
      roomId: roomId,
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
      newMessageCount: json[field.newMessageCount] ?? 0,
      name: json[field.name],
      iconUrl: json[field.iconUrl],
      displayName: json[field.displayName],
      photoUrl: json[field.photoUrl],
      inviterUid: json[field.inviterUid],
      inviterName: json[field.inviterName],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
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
      field.newMessageCount: newMessageCount,
      field.name: name,
      field.iconUrl: iconUrl,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.inviterUid: inviterUid,
      field.inviterName: inviterName,
    };
  }

  @override
  String toString() {
    return 'ChatJoin(${toJson()})';
  }
}

class ChatMessage {
  /// Field names for the Chat Message Model
  static const field = (
    id: 'id',
    roomId: 'roomId',
    text: 'text',
    url: 'url',
    senderUid: 'uid',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
    createdAt: 'createdAt',
    replyTo: 'replyTo',
    deleted: 'deleted',
    updatedAt: 'updatedAt',
    previewUrl: 'previewUrl',
    previewTitle: 'previewTitle',
    previewDescription: 'previewDescription',
    previewImageUrl: 'previewImageUrl',
    protocol: 'protocol',
  );

  String? id;

  /// [roomId] is not saved in database. It can be found in the path.
  String? roomId;
  String senderUid;
  String? displayName;

  /// [photoUrl] is pertaining to the sender's profile photo url,
  /// not the attached photo in message itself.
  String? photoUrl;
  int createdAt;
  int? updatedAt;
  int? order;
  String? text;

  /// [url] is used for the attached url in the message
  String? url;
  String? protocol;
  final bool deleted;

  String? previewUrl;
  String? previewTitle;
  String? previewDescription;
  String? previewImageUrl;

  ChatMessage? replyTo;

  bool get isUpdated => updatedAt != null;
  bool get isProtocol => protocol != null && protocol!.isNotEmpty;

  DatabaseReference get ref =>
      ChatService.instance.messagesRef(roomId!).child(id!);

  ChatMessage({
    this.id,
    required this.roomId,
    this.text,
    this.url,
    this.protocol,
    required this.senderUid,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.replyTo,
    this.deleted = false,
    this.updatedAt,
    this.previewUrl,
    this.previewTitle,
    this.previewDescription,
    this.previewImageUrl,
  });

  factory ChatMessage.fromSnapshot(DataSnapshot snapshot) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return ChatMessage.fromJson(
      data,
      snapshot.key!,
      snapshot.ref.parent!.key,
    );
  }

  static ChatMessage fromJson(
    Map<String, dynamic> json,
    String id, [
    String? roomId,
  ]) {
    final replyTo = json[field.replyTo] == null
        ? null
        : Map<String, dynamic>.from(json[field.replyTo] as Map);

    // dog('ChatMessage.fromJson: $json');
    return ChatMessage(
      id: id,
      roomId: roomId,
      text: json[field.text],
      url: json[field.url],
      protocol: json[field.protocol],
      senderUid: json[field.senderUid],
      displayName: json[field.displayName],
      photoUrl: json[field.photoUrl],
      createdAt: json[field.createdAt],
      replyTo: replyTo == null
          ? null
          : ChatMessage.fromJson(replyTo, replyTo[field.id]),
      // Added '?? false' because this it RTDB
      // Reason: There is no use for saving false in deleted.
      deleted: json[field.deleted] ?? false,
      updatedAt: json[field.updatedAt],
      previewUrl: json[field.previewUrl],
      previewTitle: json[field.previewTitle],
      previewDescription: json[field.previewDescription],
      previewImageUrl: json[field.previewImageUrl],
    );
  }

  static Map<String, dynamic> json({
    String? text,
    String? url,
    String? protocol,
    required String senderUid,
    String? displayName,
    String? photoUrl,
    required Map<String, String> createdAt,
    dynamic replyTo,
    bool? deleted,
    Map<String, String>? updatedAt,
    String? previewUrl,
    String? previewTitle,
    String? previewDescription,
    String? previewImageUrl,
  }) {
    return {
      field.text: text,
      field.url: url,
      field.protocol: protocol,
      field.senderUid: senderUid,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.createdAt: createdAt,
      field.replyTo: replyTo?.toJson(),
      field.deleted: deleted,
      field.updatedAt: updatedAt,
      field.previewUrl: previewUrl,
      field.previewTitle: previewTitle,
      field.previewDescription: previewDescription,
      field.previewImageUrl: previewImageUrl,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      field.text: text,
      field.url: url,
      field.protocol: protocol,
      field.senderUid: senderUid,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.createdAt: createdAt,
      field.replyTo: replyTo?.toJson(),
      field.deleted: deleted,
      field.updatedAt: updatedAt,
      field.previewUrl: previewUrl,
      field.previewTitle: previewTitle,
      field.previewDescription: previewDescription,
      field.previewImageUrl: previewImageUrl,
    };
  }
}

class ChatRoom {
  /// Field names used for the Firestore document
  static const field = (
    name: 'name',
    description: 'description',
    iconUrl: 'iconUrl',
    users: 'users',
    blockedUsers: 'blockedUsers',
    masterUsers: 'masterUsers',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    open: 'open',
    openCreatedAt: 'openCreatedAt',
    single: 'single',
    group: 'group',
    lastMessageAt: 'lastMessageAt',
    allMembersCanInvite: 'allMembersCanInvite',
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

  /// [openCreatedAt] is the time when the open chat room was creatd.
  /// It is null if the chat room is not open chat.
  /// It is used to sort the open chat rooms.
  DateTime? openCreatedAt;

  /// [single] is true if the chat room is single chat or 1:1.
  bool single;

  /// [group] is true if the chat room is group chat.
  bool group;

  /// [lastMessageAt] is the time when last message was sent to chat room.
  DateTime? lastMessageAt;

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
    this.openCreatedAt,
    required this.single,
    required this.group,
    required this.users,
    required this.masterUsers,
    this.blockedUsers = const {},
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    this.allMembersCanInvite = false,
  });

  /// Return the chat room object from the snapshot.
  factory ChatRoom.fromSnapshot(DataSnapshot data) {
    if (data.exists == false || data.value == null) {
      dog("data does not exists or is null");
    }
    if (data.value is int) {
      dog("data.value is int");
    }
    return ChatRoom.fromJson(
      (Map<String, dynamic>.from(data.value as Map)),
      data.key!,
    );
  }

  /// Return the chat room object from the json.
  factory ChatRoom.fromJson(Map<String, dynamic> json, String id) {
    return ChatRoom(
      id: id,
      name: json[field.name] ?? '',
      description: json[field.description] ?? '',
      iconUrl: json[field.iconUrl],
      open: json[field.open],
      openCreatedAt: json[field.openCreatedAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.openCreatedAt])
          : DateTime.now(),
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
      field.openCreatedAt: openCreatedAt,
      field.single: single,
      field.group: group,
      field.users: users,
      field.masterUsers: masterUsers,
      field.blockedUsers: blockedUsers,
      field.createdAt: createdAt.millisecondsSinceEpoch,
      field.updatedAt: updatedAt.millisecondsSinceEpoch,
      field.lastMessageAt: lastMessageAt?.millisecondsSinceEpoch,
      field.allMembersCanInvite: allMembersCanInvite,
    };
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
    Map<String, bool> users = const {},
    List<String>? masterUsers,
    bool allMembersCanInvite = false,
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
      if (open) field.openCreatedAt: ServerValue.timestamp,
      field.single: single,
      field.group: group,
      // if (invitedUsers != null) field.invitedUsers: invitedUsers,
      field.users: users,
      field.masterUsers: [myUid],
      field.allMembersCanInvite: allMembersCanInvite,
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
    String otherUid,
  ) async {
    ///
    final ref = await create(
      group: false,
      open: false,
      single: true,
      id: ChatService.instance.makeSingleChatRoomId(myUid, otherUid),
      users: {
        myUid: true,
        otherUid: false,
      },
      masterUsers: [myUid],
    );

    return ref;
  }

  /// [get] gets the cached chat room by id.
  ///
  /// Note that the chat room data is updated in realtime by [ChatMessageListView] widget.
  static Future<ChatRoom?> get(
    String id, {
    bool cache = true,
  }) async {
    if (cache && Memory.get(id) != null) {
      return Memory.get(id) as ChatRoom;
    }
    final snapshot = await ChatService.instance.roomRef(id).get();
    if (snapshot.exists == false) {
      dog('ChatRoom.get() -> Chat room not found. id: $id');
      return null;
    }
    final room = ChatRoom.fromSnapshot(snapshot);

    Memory.set(id, room);
    return room;
  }

  /// [update] updates the chat room.
  ///
  ///
  /// Note that the chat room cannot be turn into single chat room if it's group chat room.
  Future<void> update({
    String? name,
    String? description,
    String? iconUrl,
    bool? open,
    bool? allMembersCanInvite,
  }) async {
    if (single == true && (group == true || open == true)) {
      throw SuperLibraryException(
        'chat-room-update/single-cannot-be-group-or-open',
        'Single chat room cannot be group or open',
      );
    }
    if (single == false && group == false) {
      throw SuperLibraryException(
        'chat-room-update/single-or-group',
        'Single or group chat room must be selected',
      );
    }
    final updateData = {
      field.name: name,
      field.description: description,
      field.iconUrl: iconUrl,
      field.open: open,
      field.single: single,
      field.group: group,
      field.allMembersCanInvite: allMembersCanInvite,
      field.updatedAt: ServerValue.timestamp,
    };

    await ref.update(updateData);
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

  DatabaseReference get mySettingRef => FirebaseDatabase.instance
      .ref()
      .child('chat')
      .child('settings')
      .child(myUid);

  Future sendMessage({
    required String roomId,
    String? text,
    String? photoUrl,
  }) async {
    // Add your function code here!
    roomId = mayConvertSingleChatRoomId(roomId);
    // Get the cached user data
    final my = await UserData.get(myUid);

    // Save/create a chat message into chat room.
    final message = ChatMessage.json(
      senderUid: myUid,
      displayName: my?.displayName,
      photoUrl: my?.photoUrl,
      createdAt: ServerValue.timestamp,
      text: text,
    );

    final messageRef = messagesRef(roomId).push();
    await messageRef.set(message);

    // Get server timestamp
    final createdAtSnapshot =
        await messageRef.child(ChatMessage.field.createdAt).get();
    final timestamp = createdAtSnapshot.value as int;

    final moreImportant = int.parse("-1$timestamp");
    final lessImportant = -1 * timestamp;

    // Get the cached chat room data. Note that the chat room data is updated
    // in realtime by [ChatMessageListView] widget.
    final room = await ChatRoom.get(roomId);
    if (room == null) {
      dog('sendMessage() -> Chat room not found. roomId: $roomId');
      throw SuperLibraryException('send-message', 'Chat room not found');
    }

    final Map<String, Object?> updates = {};
    const f = ChatJoin.field;
    for (String uid in room.userUids) {
      dog('sendMessage() user uid: $uid');
      if (uid == myUid) {
        // If it's my join data
        // The order must not have -11 infront since I have already read that
        // chat room. (I am in the chat room)
        updates['chat/joins/$uid/${room.id}/order'] = lessImportant;
        if (room.single) {
          updates['chat/joins/$uid/${room.id}/${f.singleOrder}'] =
              lessImportant;
        }
        if (room.group) {
          updates['chat/joins/$uid/${room.id}/${f.groupOrder}'] = lessImportant;
        }
        if (room.open) {
          updates['chat/joins/$uid/${room.id}/${f.openOrder}'] = lessImportant;
        }
        updates['chat/settings/$uid/${f.newMessageCount}/${room.id}'] = null;
      } else {
        updates['chat/joins/$uid/${room.id}/order'] = moreImportant;
        if (room.single) {
          updates['chat/joins/$uid/${room.id}/${f.singleOrder}'] =
              moreImportant;
        }
        if (room.group) {
          updates['chat/joins/$uid/${room.id}/${f.groupOrder}'] = moreImportant;
        }
        if (room.open) {
          updates['chat/joins/$uid/${room.id}/${f.openOrder}'] = moreImportant;
        }

        /// Increment the unread message count if the message is not
        /// - join,
        /// - left,
        /// - or invitation-not-sent
        // TODO: Protocol support
        // if (protocol != ChatProtocol.join &&
        //     protocol != ChatProtocol.left &&
        //     protocol != ChatProtocol.invitationNotSent) {

        updates['chat/settings/$uid/${f.newMessageCount}/${room.id}'] =
            ServerValue.increment(1);
        updates['chat/joins/$uid/${room.id}/${f.newMessageCount}'] =
            ServerValue.increment(1);

        // }
      }

      updates['chat/joins/$uid/${room.id}/${f.lastMessageAt}'] = timestamp;

      // Add more about chat room info, to display the chat room list
      // information without referring to the chat room.
      updates['chat/joins/$uid/${room.id}/${f.lastMessageUid}'] = myUid;
      updates['chat/joins/$uid/${room.id}/${f.lastText}'] = text;
      updates['chat/joins/$uid/${room.id}/${f.lastUrl}'] = photoUrl;
      // TODO: Protocol support
      // updates['chat/joins/$uid/${room.id}/${f.lastProtocol}'] = protocol;
      updates['chat/joins/$uid/${room.id}/${f.lastMessageDeleted}'] = null;

      // If it's single chat, add the my information to the other user's join
      if (room.single && uid != myUid) {
        updates['chat/joins/$uid/${room.id}/${f.displayName}'] =
            my?.displayName;
        updates['chat/joins/$uid/${room.id}/${f.photoUrl}'] = my?.photoUrl;
      } else if (room.group) {
        updates['chat/joins/$uid/${room.id}/${f.name}'] = room.name;
        updates['chat/joins/$uid/${room.id}/${f.iconUrl}'] = room.iconUrl;
      }

      // If it's group chat, add the sender's information
      if (room.group) {
        updates['chat/joins/$uid/${room.id}/${f.displayName}'] =
            my?.displayName;
        updates['chat/joins/$uid/${room.id}/${f.photoUrl}'] = my?.photoUrl;
      }
    }

    // Must save the last message at in room to properly reorder it upon seening the message.
    updates['chat/rooms/${room.id}/${f.lastMessageAt}'] = timestamp;
    await database.ref().update(updates);

    // Write the data first for the speed of performance and then update the
    // other user data.
    // See README.md for details
    if (room.single) {
      UserData? user = await UserData.get(getOtherUid(roomId));
      await database.ref().update({
        'chat/joins/$myUid/${room.id}/${f.displayName}': user?.displayName,
        'chat/joins/$myUid/${room.id}/${f.photoUrl}': user?.photoUrl,
      });
    }

    // TODO: site preview
    // await updateUrlPreview(newMessage, text);
  }

  String joinSeparator = '---';

  ///
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

  /// Returns the chat room id from the other user uid.
  ///
  /// If the [otherUid] is not a uid, it should be the chat room id. then, it
  /// will return it as it is.
  ///
  /// If the [otherUid] is a uid, it will return the single chat room id.
  ///
  /// Why?
  /// - For listing chat messages and seding a chat message, it needs to know
  /// the chat room id.
  /// - To make it clean code, it will automatically convert the other uid into
  /// chat room id. So, the developer can simply pass the other user's uid or
  /// chat room id.
  String mayConvertSingleChatRoomId(String otherUid) {
    // If it's a node key, return it as it is.
    if (otherUid.startsWith('-')) {
      return otherUid;
    }
    // If it's a node key, return it as it is.
    if (otherUid.length == 20) {
      return otherUid;
    }
    // If it's a single chat room id, return it as it is.
    if (isSingleChatRoom(otherUid)) {
      return otherUid;
    }
    // If it's a UID, then convert it to single chat room id.
    if (otherUid.length == 28) {
      return makeSingleChatRoomId(myUid, otherUid);
    }

    // If it does not look like a node key, nor a single chat room id, nor a UID,
    // then return it as it is.
    return otherUid;
  }

  /// [isSingleChatRoom] returns true if the room id is single chat room.
  bool isSingleChatRoom(String roomId) {
    return roomId.contains(joinSeparator);
  }

  /// [getOtherUid] returns the other user's uid from the single chat room id.
  String getOtherUid(String singleChatRoomId) {
    // dog('getOtherUid: $singleChatRoomId');
    final uids = singleChatRoomId.split(joinSeparator);
    if (uids.length != 2) {
      throw SuperLibraryException(
        'getOtherUid',
        'Invalid single chat room id',
      );
    }
    return uids.firstWhere((uid) => uid != myUid);
  }

  // TODO where to put this
  Future<int> getDatabaseServerTimestamp() async {
    final ref = database.ref().child('chat').child('-info').child('timestamp');
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
  /// - It is called in chat message list view.
  ///
  /// Logic:
  /// - It update the room.users with current user's uid.
  /// - If it's single chat room, it will add the other user's uid in the
  ///   room.users field with requireConsent: true.
  Future<void> join(String roomId) async {
    dog("Joining into roomId: $roomId");

    // Prepare
    const f = ChatJoin.field;
    // Get the chat room data from the database.
    ChatRoom? room = await ChatRoom.get(roomId, cache: false);

    if (room == null) {
      if (isSingleChatRoom(roomId)) {
        // Join the single chat room. The chat room join is not created, yet.
        await ChatRoom.createSingle(getOtherUid(roomId));
        room = await ChatRoom.get(roomId);
      } else {
        // Group chat room must exist before entering chat room.
        throw SuperLibraryException(
            'chat-room-join', 'Group chat room not found');
      }
    } else if (room.joined &&
        room.users.containsKey(myUid) &&
        room.users[myUid] == true) {
      // Already joined and accepted the invitation, then just return.
      return;
    } else {
      // Chat room exists but not joined yet.
    }

    // Hereby, [room] is ready.
    dog("continue the join work for the room now: $room");

    final timestamp = await getDatabaseServerTimestamp();
    final negativeTimestamp = -1 * timestamp;

    // int timestamp = await getDatabaseServerTimestamp();
    // final order = timestamp * -1; // int.parse("-1$timestamp");
    final joinValues = {
      // Add uid in users
      room!.ref.child('users').child(myUid).path: true,

      // Should be in top in order
      // This will make the newly joined room at top.
      'chat/joins/$myUid/${room.id}/${f.order}': negativeTimestamp,
      if (room.single)
        'chat/joins/$myUid/${room.id}/${f.singleOrder}': negativeTimestamp,
      if (room.group)
        'chat/joins/$myUid/${room.id}/${f.groupOrder}': negativeTimestamp,
      if (room.open)
        'chat/joins/$myUid/${room.id}/${f.openOrder}': negativeTimestamp,

      // Chat room information
      if (room.name.isNotEmpty)
        'chat/joins/$myUid/${room.id}/${f.name}': room.name,
      if (room.iconUrl != null)
        'chat/joins/$myUid/${room.id}/${f.iconUrl}': room.iconUrl,
    };
    // If it's single chat, add the other user information to my room's join
    if (room.single == true) {
      final other = await UserData.get(getOtherUid(room.id));
      if (other != null) {
        joinValues.addAll({
          'chat/joins/$myUid/${room.id}/${f.displayName}': other.displayName,
          'chat/joins/$myUid/${room.id}/${f.photoUrl}': other.photoUrl,
        });
      }
    }

    dog("Joining: $joinValues");

    await database.ref().update(joinValues);

    // TODO support protocol
    // await sendMessage(
    //   room,
    // protocol: protocol ?? ChatProtocol.join,
    // );
  }

  /// Invite a user to a chat room
  ///
  /// Only the group chat room can invite a user.
  Future<void> invite({
    required String roomId,
    required String otherUid,
  }) async {
    dog("Inviting into roomId: $roomId, otherUid: $otherUid");
    // Prepare
    const f = ChatJoin.field;
    ChatRoom? room = await ChatRoom.get(roomId);
    if (room == null) {
      throw SuperLibraryException(
          'chat-room-join', 'Group chat room not found');
    }
    UserData my = await UserData.get(myUid) as UserData;

    final timestamp = await getDatabaseServerTimestamp();
    final negativeTimestamp = -1 * timestamp;
    final joinValues = {
      room.ref.child('users').child(otherUid).path: false,

      // Should be in top in order
      // This will make the newly joined room at top.
      'chat/joins/$otherUid/${room.id}/${f.order}': negativeTimestamp,
      if (room.group)
        'chat/joins/$otherUid/${room.id}/${f.groupOrder}': negativeTimestamp,
      if (room.open)
        'chat/joins/$otherUid/${room.id}/${f.openOrder}': negativeTimestamp,

      // Chat room information
      if (room.name.isNotEmpty)
        'chat/joins/$otherUid/${room.id}/${f.name}': room.name,

      // Add the inviter's information
      'chat/joins/$otherUid/${room.id}/${f.inviterUid}': my.uid,
      'chat/joins/$otherUid/${room.id}/${f.inviterName}': my.displayName,
    };
    dog("Inviting: $joinValues");
    await database.ref().update(joinValues);
  }

  /// Adjust chat data upon entering the chat room
  Future<void> enter(String roomId) async {
    const f = ChatJoin.field;
    final enterValues = {
      // TODO: Don't update if these fields are not existing for the performance improvement.
      'chat/joins/$myUid/$roomId/${f.inviterUid}': null,
      'chat/joins/$myUid/$roomId/${f.inviterName}': null,

      // Remove the no of new messages in each chat room and in the settings
      'chat/settings/$myUid/${f.newMessageCount}/$roomId': null,
      'chat/joins/$myUid/$roomId/${f.newMessageCount}': null,
    };
    await database.ref().update(enterValues);
  }
}

/// Confirm dialog
///
/// It requires build context.
///
/// Return true if the user taps on the 'Yes' button.
///
/// TODO: support custom design.
Future<bool?> confirm({
  required BuildContext context,
  required Widget title,
  Widget? subtitle,
  required Widget message,
}) {
  return
      //  HouseService.instance.confirmDialog
      //         ?.call(context: context, title: title, message: message) ??
      showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDialog(
        title: title,
        subtitle: subtitle,
        message: message,
      );
    },
  );
}

/// Confirm dialog widget
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.message,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle != null) ...[
            subtitle!,
            const SizedBox(height: 24),
          ],
          message,
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('no'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('yes'),
        ),
      ],
    );
  }
}

/// Component holder class.
class Component {
  static Widget Function(UserData)? userListTile;
  static Widget Function(ChatJoin)? chatRoomListTile;
  static Widget Function(ChatRoom)? openChatRoomListTile;
  static Widget Function(ChatMessage)? chatMessageListTile;
}

/// Print log message with emoji 🐶
void dog(dynamic msg, {int level = 0}) {
  if (kReleaseMode) return;
  if (SuperLibrary.instance.debug == false) return;
  log('--> ${msg.toString()}', time: DateTime.now(), name: '🐶', level: level);
}

String? getSitePreviewMeta(Document document, String parameter) {
  final metaTags = document.getElementsByTagName("meta");
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    if (meta.attributes['name'] == parameter) {
      return meta.attributes['content']?.replaceAll('\n', " ");
    }
  }
  return null;
}

String? getSitePreviewOGTag(Document document, String parameter) {
  final metaTags = document.getElementsByTagName("meta");
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    if (meta.attributes['property'] == parameter) {
      return meta.attributes['content']?.replaceAll('\n', " ");
    }
  }
  return null;
}

String? getSitePreviewTag(Document document, String tag) {
  final metaTags = document.getElementsByTagName(tag);
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    return meta.text.replaceAll('\n', " ");
  }
  return null;
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

class SitePreview extends StatelessWidget {
  const SitePreview({
    super.key,
    required this.data,
    this.maxLinesOfDescription = 3,
  });

  final SitePreviewData data;
  final int maxLinesOfDescription;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (data.url == null) {
          return;
        }
        if (await canLaunchUrlString(data.url!)) {
          await launchUrlString(data.url!);
        } else {
          throw 'Could not launch {$data.url}';
        }
      },
      child: Container(
        /// [imageUrl] are sometimes smaller than the length of the [description] and leads to
        /// inconsistent design of the [UrlPreview] in [ChatViewScreen] and [ForumChatViewScreen]
        /// [BoxConstraints] to make it a single width and consistent design

        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.imageUrl != null && data.imageUrl!.isNotEmpty) ...[
              CachedNetworkImage(
                imageUrl: data.imageUrl!,
                // Don't show
                errorWidget: (context, url, error) {
                  dog("Not showing an image preview because there's a problem with the url: ${data.imageUrl}");
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 8),
            ],
            if (data.title != null && data.title!.isNotEmpty) ...[
              Text(
                data.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (data.description != null && data.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                data.description!.length > 100
                    ? '${data.description!.substring(0, 90)}...'
                    : data.description!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                maxLines: maxLinesOfDescription,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SitePreviewData {
  final String? url;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;

  SitePreviewData({
    this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
  });
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

    return _database!;
  }
}

extension SuperLibraryIntExtension on int {
  /// Change the integer of milliseconds to a DateTime object
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
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

/// String Extension to check if a string is null or empty
///
/// Checks if a String? is null or not in the extends clause.
extension SuperLibraryNullableStringExtension on String? {
  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// If the string is null or empty, then it will return the newString
  String or(String newString) => isNullOrEmpty ? newString : this!;
}

extension SuperLibraryStringExtension on String {
  /// If the string is empty, return the newString.
  ///
  /// example
  /// ```dart
  /// String gender = user.gender.or(null);
  /// ```
  String or(String newString) => isEmpty ? newString : this;

  /// Cut the string
  ///
  /// [suffix] is the string to be added at the end of the string. You may want
  /// to add '...' at the end of the string.
  ///
  /// ```dart
  /// Text( comment.content.cut(56, suffix: '...') );
  /// ```
  String cut(int length, {String suffix = ''}) {
    String temp = this;
    temp = temp.trim();
    temp = temp.replaceAll('\n', ' ');
    temp = temp.replaceAll('\r', ' ');
    temp = temp.replaceAll('\t', ' ');
    return temp.length > length ? '${temp.substring(0, length)}$suffix' : temp;
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

  @override
  String toString() {
    return 'UserData(${toJson()})';
  }

  /// Returns the user data from the json as UserData model
  ///
  /// * Warning: This method caches the user data in the memory automatically.
  /// * So, you would use `UserData.get(cache: false)` method to get the user data
  /// * from the database without caching.
  factory UserData.fromJson(Map<dynamic, dynamic> json, String key) {
    final userData = UserData(
      uid: key,
      createdAt: json[field.creatAt] ?? DateTime.now().millisecondsSinceEpoch,
      displayName: json[field.displayName] ?? '',
      displayNameLowerCase: json[field.displayNameLowerCase] ?? '',
      photoUrl: json[field.photoUrl] ?? '',
    );

    Memory.set(key, userData);

    return userData;
  }

  factory UserData.fromSnapshot(DataSnapshot snapshot) {
    return UserData.fromJson(snapshot.value as Map, snapshot.key!);
  }

  /// Returns the user data from the Realtime database as UserData model
  ///
  /// This method is used to get the user data from the Realtime database.
  ///
  /// The user data is cached in the memory to reduce the flickering and improve
  /// the performance.
  ///
  /// Returns null if the user data does not exist.
  ///
  /// TODO: make [getUserData] custom action based on this method.
  static Future<UserData?> get(
    String uid, {
    bool cache = true,
  }) async {
    if (cache && Memory.get(uid) != null) {
      return Memory.get(uid) as UserData;
    }

    final snapshot = await UserService.instance.databaseUserRef(uid).get();
    if (snapshot.exists == false) {
      return null;
    }

    if (snapshot.value == null) {
      return null;
    }

    return UserData.fromSnapshot(snapshot);
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
    _mirrorUserData();
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

    // dog('path of ref: ${ref.path}');
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

    // dog('path of ref: ${ref.path}');
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

  /// Mirror user's displayName, photoURL, and created_time only from Firestore
  /// to Database.
  ///
  /// * It also copy the 'display_name` into 'dispaly_name_lowercase' for the
  /// * case-insensitive search.
  ///
  ///
  /// Why?
  /// The super library is using Firebase Realtime Database for chat and other
  /// functionalities. But the user's displayName and photoURL are stored in
  /// Firestore by FlutterFlow.
  _mirrorUserData() {
    mirrorSubscription?.cancel();
    mirrorSubscription =
        fa.FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        dog('Super library -> _mirrorUserData() -> User is not signed in. So, return');
        return;
      }

      dog('Super library -> _mirrorUserData() -> User is signed in. So, mirror the user data');

      userDocumentSubscription?.cancel();
      // ! Warning: careful for recursive call by updating the user document and listening to it.
      userDocumentSubscription = doc(user.uid).snapshots().listen((snapshot) {
        if (snapshot.exists == false) {
          return;
        }

        // Get user data
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;

        // TODO: improve the logic. Check if the blockedUsers has changed, then, update it.
        if (data.keys.contains('blockedUsers') == true) {
          myBlockedUsersRef.set(data['blockedUsers']);
          return;
        }

        // Copy the 'display_name' into 'dispaly_name_lowercase' for the
        // case-insensitive search.
        // * careful for recursive update and listen to the user document.
        if (data['display_name'] != data['display_name_lowercase']) {
          snapshot.reference.update({
            'display_name_lowercase':
                (data['display_name'] as String).toLowerCase(),
          });
        }

        // Mirror user data to database.
        // If a field does exist in the firestore, then save it as null in the
        // database. So, it will be removed from the database.
        int stamp;
        if (data['created_time'] != null && data['created_time'] is Timestamp) {
          stamp = (data['created_time'] as Timestamp).millisecondsSinceEpoch;
        } else {
          stamp = DateTime.now().millisecondsSinceEpoch;
        }
        Map<String, dynamic> update = <String, dynamic>{
          UserData.field.creatAt: stamp,
          UserData.field.displayName: data['display_name'],
          UserData.field.displayNameLowerCase:
              (data['display_name'] ?? '').toLowerCase(),
          UserData.field.photoUrl: data['photo_url'],
        };

        databaseUserRef(user.uid).update(update);
      });
    });
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

/// Put this at the bottom !!
Future superLibrary() async {
  // Add your function code here!
}

// End custom action code
