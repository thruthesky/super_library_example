import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class OpenChatRoomListScreen extends StatefulWidget {
  static const String routeName = '/OpenChatRoomList';
  const OpenChatRoomListScreen({super.key});

  @override
  State<OpenChatRoomListScreen> createState() => _OpenChatRoomListScreenState();
}

class _OpenChatRoomListScreenState extends State<OpenChatRoomListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenChatRoomList'),
      ),
      body: OpenChatRoomListView(
        onTap: (roomId) => showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) {
            return ChatRoomScreen(
              roomId: roomId,
            );
          },
        ),
      ),
    );
  }
}
