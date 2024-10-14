// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

/// ChatRoomListView
///
/// This widget displays a list of chat rooms
class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({
    super.key,
    this.width,
    this.height,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Future Function(String roomId)? onTap;

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  Query get query {
    return ChatService.instance.joinsRef.orderByChild(ChatJoin.field.order);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: query,
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
          ),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final join = ChatJoin.fromSnapshot(doc);

            return Component.chatRoomListTile?.call(join) ??
                InkWell(
                  onTap: () async {
                    final room = await ChatRoom.get(join.roomId);
                    if (room?.users[myUid] == false) {
                      if (context.mounted) {
                        final re = await confirm(
                          context: context,
                          title: const Text('New chat'),
                          message:
                              const Text('Do you want to join this chat room?'),
                        );
                        if (re != true) {
                          return;
                        }
                      }
                    }

                    if (context.mounted) {
                      widget.onTap?.call(join.roomId) ??
                          // * FlutterFlow provides an action(callback) with empty body
                          // * so, there is less chance that users would see tis toast.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Use [onTap] callback action to open chat room. '
                                'Or customize your UI/UX to open chat room. '
                                'Refer to the developer documentation for details.',
                              ),
                            ),
                          );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Row(
                        children: [
                          if (join.single == true)
                            UserAvatar(
                              uid:
                                  ChatService.instance.getOtherUid(join.roomId),
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
                                  join.name ??
                                      join.displayName ??
                                      'No chat room name',
                                  style:
                                      FlutterFlowTheme.of(context).titleMedium,
                                ),
                                Row(
                                  children: [
                                    if (join.single == false)
                                      const Icon(
                                        Icons.supervisor_account_rounded,
                                        size: 16,
                                      ),
                                    if (join.open == true)
                                      const Icon(
                                        Icons.lock_open_rounded,
                                        size: 16,
                                      ),
                                  ],
                                ),
                                if (join.inviterUid != null &&
                                    join.inviterUid!.isNotEmpty)
                                  Text(
                                    'Invited by: ${join.inviterName}',
                                  ),
                                if (join.lastText != null &&
                                    join.lastText!.isNotEmpty)
                                  Text(
                                    join.lastText!,
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
                              if (join.lastMessageAt != null)
                                Text(
                                  join.lastMessageAt!.short,
                                  style:
                                      FlutterFlowTheme.of(context).labelSmall,
                                ),
                              if (join.newMessageCount > 0)
                                Badge(
                                  label: Text('${join.newMessageCount}'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
          },
        );
      },
    );
  }
}
