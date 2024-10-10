// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

/// Chat room message list view.
///
/// This widget displays a list of chat messages. This widget can be used in
/// a chat room or any other screen.
///
/// If this widget is shown to screen, it is considered that the user has
/// joined the chat room. So, it has the logic of joining the chat room.
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
  String get roomId =>
      widget.roomId ??
      ChatService.instance.makeSingleChatRoomId(
        myUid,
        widget.otherUid,
      );

  @override
  void initState() {
    super.initState();

    ChatService.instance.join(roomId);

    // Listen and update the chat room data in memory. So, it can be used in
    // other widgets. By doing this, the 'users' field of the chat room is
    // always up-to-date in memory.
    ChatService.instance.roomRef(roomId).onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        final room = ChatRoom.fromSnapshot(event.snapshot);
        Memory.set(roomId, room);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListView(
      reverseQuery: true,
      query: ChatService.instance.messagesRef(roomId),
      builder: (snapshot, fetchMore) {
        return ListView.builder(
          itemCount: snapshot.docs.length,
          reverse: true,
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];

            final message = ChatMessage.fromSnapshot(doc);
            // TODO - support custom ui

            return Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  UserAvatar(
                    uid: message.senderUid,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.displayName != null)
                        Text(
                          message.displayName!,
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      if (message.text != null)
                        Text(
                          message.text!,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                    ],
                  ),
                ],
              ),
            );

            //  ListTile(
            //   shape: const OutlineInputBorder(),
            //   title: Text(doc.key!),
            //   subtitle: Text(doc.value.toString()),
            // );
          },
        );
      },
    );
  }
}
