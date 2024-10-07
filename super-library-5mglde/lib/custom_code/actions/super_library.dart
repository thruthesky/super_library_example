// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

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
    debug = false,
  }) {
    //
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

class UserService {
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();
  UserService._();

  /// Firestore collection name for users
  String collectionName = 'users';

  DatabaseReference get usersRef => database.ref().child(collectionName);

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
  DatabaseReference get myRef {
    final user = fa.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myRef: user is not signed in');
    }
    final ref = userRef(user.uid);
    return ref;
  }

  /// Database reference for the user with [uid]
  DatabaseReference userRef(String uid) {
    final ref = database.ref().child(collectionName).child(uid);

    dog('path of ref: ${ref.path}');
    return ref;
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
    dog('UserService.mirror');
    mirrorSubscription?.cancel();
    mirrorSubscription =
        fa.FirebaseAuth.instance.authStateChanges().listen((user) {
      print('User uid: ${user?.uid}');
      if (user != null) {
        userDocumentSubscription?.cancel();
        userDocumentSubscription = doc(user.uid).snapshots().listen((snapshot) {
          if (snapshot.exists == false) {
            return;
          }
          int stamp;
          if (snapshot.get('created_time') is Timestamp) {
            stamp = (snapshot.get('created_time') as Timestamp)
                .millisecondsSinceEpoch;
          } else {
            stamp = DateTime.now().millisecondsSinceEpoch;
          }

          Map<String, dynamic> data = {
            UserData.field.creatAt: stamp,
            UserData.field.displayName: snapshot.get('display_name') ?? '',
            UserData.field.displayNameLowerCase:
                (snapshot.get('display_name') ?? '').toLowerCase(),
            UserData.field.photoUrl: snapshot.get('photo_url') ?? '',
          };

          userRef(user.uid).update(data);
        });
      }
    });
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

  factory UserData.fromJson(Map<dynamic, dynamic> json, String key) {
    return UserData(
      uid: key,
      createdAt: json[field.creatAt],
      displayName: json[field.displayName],
      displayNameLowerCase: json[field.displayNameLowerCase],
      photoUrl: json[field.photoUrl],
    );
  }

  factory UserData.fromSnapshot(DataSnapshot snapshot) {
    return UserData.fromJson(snapshot.value as Map, snapshot.key!);
  }
}

/// Component holder class.
class Component {
  static Widget Function(UserData)? userListTile;
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

Future superLibrary() async {
  // Add your function code here!
}

// End custom action code
