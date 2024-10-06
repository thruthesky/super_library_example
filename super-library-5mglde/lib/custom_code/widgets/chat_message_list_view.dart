// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

/// A list view of chat messages
///
/// This widget displays a list of chat messages in a chat room.
///
///
class ChatMessageListView extends StatefulWidget {
  const ChatMessageListView({
    super.key,
    this.width,
    this.height,
    this.otherUid,
    this.roomId,
  });

  final double? width;
  final double? height;
  final String? otherUid;
  final String? roomId;

  @override
  State<ChatMessageListView> createState() => _ChatMessageListViewState();
}

class _ChatMessageListViewState extends State<ChatMessageListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: ChatService.instance.messagesRef('roomId'),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            return ListTile(
              title: Text(doc.key!),
              subtitle: Text(doc.value.toString()),
            );
          },
        );
      },
    );
  }
}
