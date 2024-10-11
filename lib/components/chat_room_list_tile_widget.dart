import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ChatRoomListTileWidget extends StatefulWidget {
  const ChatRoomListTileWidget({
    super.key,
    required this.roomId,
    required this.name,
    required this.iconUrl,
    required this.displayName,
    required this.photoUrl,
    required this.group,
    required this.single,
    required this.open,
    required this.lastMessageAt,
    required this.lastMessageDeleted,
    required this.lastText,
    required this.lastUrl,
    required this.lastProtocol,
    required this.unreadMessageCount,
  });

  final String roomId;
  final String? name;
  final String? iconUrl;
  final String? displayName;
  final String? photoUrl;

  final bool? group;
  final bool? single;
  final bool? open;

  final DateTime? lastMessageAt;
  final bool? lastMessageDeleted;
  final String? lastText;
  final String? lastUrl;
  final String? lastProtocol;

  final int unreadMessageCount;

  @override
  State<ChatRoomListTileWidget> createState() => _ChatRoomListTileWidgetState();
}

class _ChatRoomListTileWidgetState extends State<ChatRoomListTileWidget> {
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
        final room = await ChatRoom.get(widget.roomId);
        if (room?.users[myUid] == false) {
          final re = await confirm(
            context: context,
            title: const Text('New chat'),
            message: Text(
                'Do you want to join this chat room - ${widget.name ?? widget.displayName}?'),
          );
          if (re != true) {
            return;
          }
        }
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) {
            return ChatRoomScreen(
              roomId: widget.roomId,
            );
          },
        );
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
                    Text(
                      widget.name ?? widget.displayName ?? 'No chat room name',
                    ),
                    Text(
                      'Single: ${widget.single}, Group: ${widget.group}, Open: ${widget.open}',
                    ),
                    Text(
                      widget.lastText ?? 'No last message',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Unread',
                  ),
                  Text(
                    widget.unreadMessageCount.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
