import 'package:flutter/material.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ChatInviteUserScreen extends StatefulWidget {
  static const String routeName = '/ChatInviteUser';
  const ChatInviteUserScreen({super.key});

  @override
  State<ChatInviteUserScreen> createState() => _ChatInviteUserScreenState();
}

class _ChatInviteUserScreenState extends State<ChatInviteUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatInviteUser'),
      ),
      body: const UserListView(
        reverse: true,
        onTap: null, // (uid) => inviteChatUser(roomId, uid),
      ),
    );
  }
}
