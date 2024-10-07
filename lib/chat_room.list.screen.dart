import 'package:flutter/material.dart';

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
              // TODO create Chat Room Screen
              // TODO customizable?
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
