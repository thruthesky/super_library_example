import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class OpenChatRoomListTileWidget extends StatefulWidget {
  const OpenChatRoomListTileWidget({
    super.key,
    required this.roomId,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.users,
    required this.blockedUsers,
    required this.masterUsers,
    required this.createdAt,
    required this.updatedAt,
    required this.open,
    required this.openCreatedAt,
    required this.single,
    required this.group,
    required this.lastMessageAt,
    required this.allMembersCanInvite,
  });

  final String roomId;
  final String name;
  final String? description;
  final String? iconUrl;
  final Map<String, bool> users;
  final List<String>? blockedUsers;
  final List<String> masterUsers;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool open;
  final DateTime? openCreatedAt;
  final bool single;
  final bool group;
  final DateTime? lastMessageAt;
  final bool allMembersCanInvite;

  @override
  State<OpenChatRoomListTileWidget> createState() =>
      _OpenChatRoomListTileWidgetState();
}

class _OpenChatRoomListTileWidgetState
    extends State<OpenChatRoomListTileWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.users[myUid] == false) {
          if (context.mounted) {
            final re = await confirm(
              context: context,
              title: const Text('New chat'),
              message:
                  Text('Do you want to join this chat room - ${widget.name}?'),
            );
            if (re != true) {
              return;
            }
          }
        }
        if (context.mounted) {
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) {
              return ChatRoomScreen(
                roomId: widget.roomId,
              );
            },
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (widget.single == true)
                UserAvatar(
                  uid: ChatService.instance.getOtherUid(widget.roomId),
                  width: 60,
                  height: 60,
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    Text(
                      'Single: ${widget.single}, Group: ${widget.group}, Open: ${widget.open}',
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Users:',
                  ),
                  Text('${widget.users.length}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
