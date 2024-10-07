// Automatic FlutterFlow imports
import 'package:super_library/custom_code/actions/super_library.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ChatRoomCreateScreen extends StatefulWidget {
  const ChatRoomCreateScreen({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChatRoomCreateScreen> createState() => _ChatRoomCreateScreenState();
}

class _ChatRoomCreateScreenState extends State<ChatRoomCreateScreen> {
  bool open = false;
  bool allMembersCanInvite = false;
  bool isLoading = false;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  // TODO icon url
  // String? iconUrl;

  // @override
  // void initState() {
  //   super.initState();
  //   if (isCreate) {
  //     open = widget.open;
  //     return;
  //   }
  //   nameController.text = room!.name;
  //   descriptionController.text = room!.description;

  //   open = room?.open ?? false;
  //   allMembersCanInvite = room!.allMembersCanInvite;
  // }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    // TODO iconUrl
    // if (iconUrl != null && iconUrl != room?.iconUrl) {
    //   // delete if something was uploaded but not saved
    //   StorageService.instance.delete(iconUrl);
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat room create'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'enter room name',
                  helperText: 'you can change this chat room name later',
                  label: Text('group chat name'),
                ),
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'enter description',
                  label: Text('description'),
                  helperText: 'this is chat room description',
                ),
                controller: descriptionController,
              ),
            ),
            const SizedBox(height: 36),
            // NOTE: If Image is uploaded, it is automatically saved
            //       However, chat room will be reactive if updatedAt is
            //       changed. Using ImageUploadCard won't update it.
            // TODO icon things
            // ImageUploadCard(
            //   initialData: room?.iconUrl,
            //   onUpload: (url) {
            //     if (iconUrl != null && room?.iconUrl != iconUrl) {
            //       // This means the photo before saving is being
            //       // replaced. Must delete the previous one.
            //       StorageService.instance.delete(iconUrl);
            //     }
            //     setState(() {
            //       iconUrl = url;
            //     });
            //   },
            // ),

            const SizedBox(height: 36),
            //
            Padding(
              padding: const EdgeInsets.all(0),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                title: const Text('open chat'),
                subtitle: const Text('anyone can join this chat room'),
                value: open,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    open = value;
                  });
                },
              ),
            ),

            CheckboxListTile(
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              // When it is open group, basically all members can invite
              enabled: !open,
              title: const Text('members can invite'),
              subtitle: Text(
                open
                    ? 'in an open chat, all members can invite others by default'
                    : 'all members can invite others to join',
              ),
              value: open ? true : allMembersCanInvite,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  allMembersCanInvite = value;
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            if (isLoading) ...[
              const CircularProgressIndicator(),
            ] else
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  // TODO continue from heere.
                  try {
                    ChatRoom? chatRoom;

                    /// Create a new chat room
                    final newRoomRef = await ChatRoom.create(
                      name: nameController.text,
                      description: descriptionController.text,
                      // TODO icon url
                      // iconUrl: iconUrl,
                      open: open,
                      group: true,
                      single: false,
                      users: {myUid!: false},
                    );

                    /// Get the chat room
                    chatRoom = await ChatRoom.get(newRoomRef.key!);
                    // TODO join room
                    // await ChatService.instance.join(
                    //   chatRoom!,
                    //   protocol: ChatProtocol.create,
                    // );

                    // This will prevent the newly Uploaded photo to be deleted
                    // TODO icon URL
                    // iconUrl = null;
                    if (!context.mounted) return;
                    Navigator.of(context).pop(chatRoom!.ref);
                    // TODO showing the chat room screen
                    // ChatService.instance
                    //     .showChatRoomScreen(context, room: chatRoom);
                  } catch (e) {
                    dog("Failed on chat room creation: ${e.toString()}");
                    setState(() {
                      isLoading = false;
                    });
                    rethrow;
                  }
                },
                child: Text('create'),
              ),

            const SafeArea(
              child: SizedBox(
                height: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
