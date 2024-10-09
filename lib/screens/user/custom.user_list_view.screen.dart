import 'package:flutter/material.dart';
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
  const CustomUserListViewScreen({super.key});

  @override
  State<CustomUserListViewScreen> createState() =>
      _CustomUserListViewScreenState();
}

class _CustomUserListViewScreenState extends State<CustomUserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) {
      return Container(
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: user.photoUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(user.displayName),
                  const SizedBox(height: 16),
                  Text(user.createdAt.toDateTime.short)
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.block),
                  onPressed: () async {
                    await blockUser(
                      user.uid,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.report),
                  onPressed: () async {
                    final re = await reportExists('user', user.uid);
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
                      user.uid,
                      user.uid,
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
                          otherUid: user.uid,
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
    };
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
