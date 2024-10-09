import 'package:flutter/material.dart';
import 'package:super_library/components/user_list_tile/user_list_tile_widget.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/widgets/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomComponentUserListViewScreen extends StatefulWidget {
  static const String routeName = '/UserListView';
  const CustomComponentUserListViewScreen({super.key});

  @override
  State<CustomComponentUserListViewScreen> createState() =>
      _CustomComponentUserListViewScreenState();
}

class _CustomComponentUserListViewScreenState
    extends State<CustomComponentUserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) => UserListTileWidget(
          uid: user.uid,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
        );
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
