// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';

FirebaseDatabase get database => SuperLibrary.instance.database;
fs.FirebaseFirestore get firestore => fs.FirebaseFirestore.instance;

class SuperLibrary {
  static SuperLibrary? _instance;
  static SuperLibrary get instance => _instance ??= SuperLibrary._();

  SuperLibrary._();

  String? databaseURL;
  FirebaseDatabase? _database;

  bool initialized = false;

  bool debug = false;

  init({
    required String databaseURL,
    String collectionName = 'users',
    debug = false,
  }) {
    //
    this.databaseURL = databaseURL;
    this.debug = debug;
    initialized = true;
    UserService.instance.init(collectionName: collectionName);
  }

  FirebaseDatabase get database {
    if (initialized == false) {
      throw Exception('SuperLibrary is not initialized');
    }
    if (databaseURL == null) {
      throw Exception('SuperLibrary.getDatabase is not initialized');
    }
    _database ??= FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: databaseURL!,
    );
    return _database!;
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

    roomId = roomId ?? makeChatRoomId(senderUid, receiverUid!);
    await messagesRef(roomId!).push().set(data);
  }

  makeChatRoomId(String senderUid, String receiverUid) {
    return senderUid.hashCode <= receiverUid.hashCode
        ? '$senderUid-$receiverUid'
        : '$receiverUid-$senderUid';
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

  final Widget Function(User?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // To reduce the flickering
      initialData: FirebaseAuth.instance.currentUser,
      stream: FirebaseAuth.instance.authStateChanges(),
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

  /// List of private fields that should not be synced to the database
  List<String>? _mirrorExcludeFields;

  /// Default private fields
  List<String> defaultMirrorExcludeFields = ['email', 'phone_number'];

  init({
    required String collectionName,
    List<String>? mirrorExcludeFields,
  }) {
    dog('UserService.init: $collectionName');
    this.collectionName = collectionName;
    _mirrorExcludeFields = mirrorExcludeFields ?? defaultMirrorExcludeFields;
    dog(_mirrorExcludeFields);
    mirror();
  }

  /// Firestore document reference for the current user
  fs.DocumentReference get myDoc {
    final user = FirebaseAuth.instance.currentUser;
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
  DatabaseReference get myData {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myRef: user is not signed in');
    }
    final ref = data(user.uid);
    return ref;
  }

  /// Database reference for the user with [uid]
  DatabaseReference data(String uid) {
    final ref = database.ref().child(collectionName).child(uid);

    dog('path of ref: ${ref.path}');
    return ref;
  }

  StreamSubscription<User?>? mirrorSubscription;
  StreamSubscription? userDocumentSubscription;

  /// Mirror user's displayName and photoURL from Firestore to Database
  ///
  /// Why?
  /// The superchat is using Firebase Realtime Database for chat and other
  /// functionalities. But the user's displayName and photoURL are stored in
  /// Firestore by FlutterFlow.
  mirror() {
    dog('UserService.mirror');
    mirrorSubscription?.cancel();
    mirrorSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      print('User uid: ${user?.uid}');
      if (user != null) {
        userDocumentSubscription?.cancel();
        userDocumentSubscription = doc(user.uid).snapshots().listen((snapshot) {
          if (snapshot.exists == false) {
            return;
          }
          Map<String, dynamic> newData = {};

          print('Mirror from Firestore to Database');
          Map<String, dynamic> snapshotData =
              Map<String, dynamic>.from(snapshot.data() as Map);

          for (dynamic key in snapshotData.keys) {
            final value = snapshotData[key];

            if (_mirrorExcludeFields!.contains(key) || value == null) {
              continue;
            }
            if (value is String ||
                value is int ||
                value is double ||
                value is bool ||
                (value is Object && value is List)) {
              newData[key] = value;
            } else if (value is Object) {
              if (value is fs.Timestamp) {
                newData[key] = value.millisecondsSinceEpoch;
              } else if (value is fs.GeoPoint) {
                final geoPoint = value;
                newData['latitude'] = geoPoint.latitude;
                newData['longitude'] = geoPoint.longitude;
              } else if (value is Map) {
                dog('key $key is Map');
                newData[key] = value;
              } else {
                dog('key $key is unknown object type');
              }
            } else {
              dog('key $key is unknown type');
            }
          }
          debugPrint('newData : $newData');
          data(user.uid).update(newData);
        });
      }
    });
  }
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

