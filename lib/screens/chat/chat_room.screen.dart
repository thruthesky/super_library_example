import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_example/screens/chat/chat_invite_user.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  const ChatRoomScreen({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatRoom'),
        actions: [
          IconButton(
            onPressed: () async {
              await showGeneralDialog(
                context: context,
                pageBuilder: (context, a1, a2) {
                  return const ChatInviteUserScreen();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ChatMessageListView(
                  roomId: widget.roomId,
                ),
              ),
              SafeArea(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await sendChatMessage(
                          widget.roomId,
                          textController.text,
                        );
                        textController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
