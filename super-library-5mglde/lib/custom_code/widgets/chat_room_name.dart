// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../actions/super_library.dart';

class ChatRoomName extends StatefulWidget {
  const ChatRoomName({
    super.key,
    this.width,
    this.height,
    required this.roomId,
  });

  final double? width;
  final double? height;
  final String roomId;

  @override
  State<ChatRoomName> createState() => _ChatRoomNameState();
}

class _ChatRoomNameState extends State<ChatRoomName> {
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: ChatService.instance.isSingleChatRoom(widget.roomId)
          ? UserService.instance
              .databaseUserRef(ChatService.instance.getOtherUid(widget.roomId))
              .child(UserData.field.displayName)
          : ChatService.instance.roomsRef
              .child(widget.roomId)
              .child(ChatRoom.field.name),
      builder: (chatRoomName, ref) {
        final String chatRoomNameValue = chatRoomName ?? "Chat Room";
        return Text(
          chatRoomNameValue,
        );
      },
    );
  }
}
