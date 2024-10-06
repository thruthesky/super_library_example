// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';

FirebaseDatabase get database => SuperLibrary.instance.database;

class SuperLibrary {
  static SuperLibrary? _instance;
  static SuperLibrary get instance => _instance ??= SuperLibrary._();

  SuperLibrary._();

  String? databaseURL;
  FirebaseDatabase? _database;

  bool initialized = false;

  init({
    required String databaseURL,
  }) {
    //
    this.databaseURL = databaseURL;
    initialized = true;
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

Future superLibrary() async {
  // Add your function code here!
}
