// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
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
    this.open,
  });

  final double? width;
  final double? height;
  final bool? open;

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: ChatService.instance.joinsRef.orderByChild(ChatJoin.field.order),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final join = ChatJoin.fromSnapshot(doc);

            return Component.chatRoomListTile?.call(join) ??
                InkWell(
                  onTap: () async {
                    final room = await ChatRoom.get(join.roomId);
                    if (room?.users[myUid] == false) {
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

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Customize your UI/UX to open chat room. Refer to the developer documentation for details.'),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                ),
                                Text(
                                  'Single: ${join.single}, Group: ${join.group}, Open: ${join.open}',
                                ),
                                Text(
                                  join.lastText ?? 'No last message',
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
                                join.unreadMessageCount.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );

            // ListTile(
            //   title: Text(join.name ?? join.displayName ?? '...'),
            //   subtitle: Text(join.lastText ?? join.lastUrl ?? '...'),
            //   onTap: () async {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(
            //             'Customize your UI/UX to open chat room key: ${doc.key}'),
            //       ),
            //     );
            //   },
            // );
          },
        );
      },
    );
  }
}
