import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';

class ChatRoomEditDialog extends StatefulWidget {
  const ChatRoomEditDialog({super.key});

  @override
  State<ChatRoomEditDialog> createState() => _ChatRoomEditDialogState();
}

class _ChatRoomEditDialogState extends State<ChatRoomEditDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool open = true;
  bool canInvite = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Chat Room Edit'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter chat room name',
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter chat room description',
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Text('Open'),
                Checkbox(
                  value: open,
                  onChanged: (value) {
                    setState(() {
                      open = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Can Invite'),
                Checkbox(
                  value: canInvite,
                  onChanged: (value) {
                    setState(() {
                      canInvite = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final roomId = await createChatRoom(
                  nameController.text,
                  descriptionController.text,
                  null,
                  open,
                  canInvite,
                );
                Navigator.of(context).pop();
                showGeneralDialog(
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return ChatRoomScreen(
                      roomId: roomId,
                    );
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
