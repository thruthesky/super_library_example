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

class OpenChatRoomListView extends StatefulWidget {
  const OpenChatRoomListView({
    super.key,
    this.width,
    this.height,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Future Function(String roomId)? onTap;

  @override
  State<OpenChatRoomListView> createState() => _OpenChatRoomListViewState();
}

class _OpenChatRoomListViewState extends State<OpenChatRoomListView> {
  Query get query {
    return ChatService.instance.roomsRef
        .orderByChild(ChatRoom.field.openCreatedAt)
        .startAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: query,
      reverseQuery: true,
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
          ),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final room = ChatRoom.fromSnapshot(doc);

            return Component.openChatRoomListTile?.call(room) ??
                InkWell(
                  onTap: () async {
                    if (room.users[myUid] == false) {
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

                    if (context.mounted) {
                      widget.onTap?.call(room.id) ??
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
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(room.name),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Users',
                              ),
                              Text(
                                room.users.length.toString(),
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
