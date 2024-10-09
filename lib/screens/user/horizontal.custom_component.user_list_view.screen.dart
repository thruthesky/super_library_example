import 'package:flutter/material.dart';
import 'package:super_library/components/user_list_icon/user_list_icon_widget.dart';
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

class HorizontalCustomComponentUserListViewScreen extends StatefulWidget {
  static const String routeName = '/UserListView';
  const HorizontalCustomComponentUserListViewScreen({super.key});

  @override
  State<HorizontalCustomComponentUserListViewScreen> createState() =>
      _HorizontalCustomComponentUserListViewScreenState();
}

class _HorizontalCustomComponentUserListViewScreenState
    extends State<HorizontalCustomComponentUserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) => UserListIconWidget(
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
            child: UserListView(
              horizontalScroll: true,
            ),
          ),
        ],
      ),
    );
  }
}
