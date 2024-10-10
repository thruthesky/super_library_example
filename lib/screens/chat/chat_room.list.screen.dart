import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room_edit_dialog.dart';

import 'package:super_library/custom_code/widgets/chat_room_list_view.dart';

class ChatRoomListScreen extends StatelessWidget {
  static const String routeName = '/ChatRoomList';
  const ChatRoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatRoomList'),
        actions: [
          IconButton(
            onPressed: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (context, a1, a2) {
                  return const ChatRoomEditDialog();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ChatRoomListView(),
        ),
      ),
    );
  }
}
