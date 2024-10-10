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
import 'package:super_library/custom_code/widgets/chat_room_screen.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: ChatService.instance.joinsRef,
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            fetchMore(index);
            // TODO customization
            final DataSnapshot doc = snapshot.docs[index];
            return ListTile(
              title: Text(doc.key!),
              subtitle: Text(doc.value.toString()),
              onTap: () async {
                // Open chat room screen
                await showGeneralDialog(
                  context: context,
                  pageBuilder: (context, a1, a2) {
                    // TODO customization
                    return ChatRoomScreen(
                      roomId: doc.key,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
