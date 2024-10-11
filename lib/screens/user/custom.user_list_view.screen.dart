import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/widgets/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomUserListViewScreen extends StatefulWidget {
  static const String routeName = '/UserListView';
  const CustomUserListViewScreen({
    super.key,
  });

  @override
  State<CustomUserListViewScreen> createState() =>
      _CustomUserListViewScreenState();
}

class _CustomUserListViewScreenState extends State<CustomUserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) => CustomTile(user: user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserListView'),
      ),
      body: const Column(
        children: [
          Text("UserListView"),
          Expanded(
            child: UserListView(),
          ),
        ],
      ),
    );
  }
}

class CustomTile extends StatefulWidget {
  const CustomTile({super.key, required this.user});

  final UserData user;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.user.photoUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              children: [
                Text(widget.user.displayName),
                const SizedBox(height: 16),
                Text(widget.user.createdAt.toDateTime.short)
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.report),
                onPressed: () async {
                  final re = await reportExists('user', widget.user.uid);
                  if (re) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: const Text('User already reported'),
                      ),
                    );
                    return;
                  }
                  await report(
                    'user',
                    widget.user.uid,
                    widget.user.uid,
                    'Abuse',
                    'I report this user because he is an abuser',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User reported'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return ChatRoomScreen(
                        roomId: widget.user.uid,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
