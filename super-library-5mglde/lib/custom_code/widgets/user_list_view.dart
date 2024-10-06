// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

class UserListView extends StatefulWidget {
  const UserListView({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: UserService.instance.usersRef
          .orderByChild(User.field.creatAt)
          .startAt(0),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final User user = User.fromSnapshot(doc);

            return UserService.instance.userListTile?.call(user) ??
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: user.photoUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(user.displayName),
                  subtitle: Text(user.createdAt.toDateTime.short),
                );
          },
        );
      },
    );
  }
}
