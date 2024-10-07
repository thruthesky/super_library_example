// Automatic FlutterFlow imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    super.key,
    this.width,
    this.height,
    this.roomId,
    this.otherUid,
  });

  final double? width;
  final double? height;

  final String? roomId;
  final String? otherUid;

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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ChatMessageListView(
                  // TODO review if we need other Uid
                  otherUid: widget.otherUid,
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
                        await chatSendMessage(
                          myUid,
                          widget.otherUid,
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
