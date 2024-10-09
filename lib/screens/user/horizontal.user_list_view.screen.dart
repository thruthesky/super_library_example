import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class HorizontalUserListViewScreen extends StatefulWidget {
  static const String routeName = '/HorizontalUserListView';
  const HorizontalUserListViewScreen({super.key});

  @override
  State<HorizontalUserListViewScreen> createState() =>
      _HorizontalUserListViewScreenState();
}

class _HorizontalUserListViewScreenState
    extends State<HorizontalUserListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) {
      return SizedBox(
        width: 100,
        height: 100,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: user.photoUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            Text(user.displayName),
            const SizedBox(height: 16),
            Text(user.createdAt.toDateTime.short)
          ],
        ),
      );
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('HorizontalUserListView'),
      ),
      body: const Column(
        children: [
          Text("HorizontalUserListView"),
          SizedBox(
            height: 106,
            child: UserListView(
              horizontalScroll: true,
            ),
          ),
        ],
      ),
    );
  }
}
