// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

class UserListView extends StatefulWidget {
  const UserListView({
    super.key,
    this.width,
    this.height,
    this.horizontalScroll,
    this.reverse,
    this.onTap,
  });

  final double? width;
  final double? height;
  final bool? horizontalScroll;
  final bool? reverse;
  final Future Function(String userId)? onTap;

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      reverseQuery: widget.reverse == true,
      query: UserService.instance.databaseUsersRef
          .orderByChild(UserData.field.creatAt)
          .startAt(0),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
          scrollDirection:
              widget.horizontalScroll == true ? Axis.horizontal : Axis.vertical,
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final UserData user = UserData.fromSnapshot(doc);

            return Component.userListTile?.call(user) ??
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: UserAvatar(uid: user.uid),
                  title: Text(user.displayName.or('...')),
                  subtitle: Text(user.createdAt.toDateTime.short),
                  onTap: () => widget.onTap?.call(user.uid),
                );
          },
        );
      },
      emptyBuilder: () => const Center(
        child: Text('No users found'),
      ),
      errorBuilder: (error) => Center(
        child: Text('Error: $error'),
      ),
      loadingBuilder: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
