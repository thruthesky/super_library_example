// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import '/custom_code/actions/super_library.dart';

/// UserAvatar
///
/// Display the user's avatar from the given user ID.
class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
    this.width,
    this.height,
    required this.uid,
  });

  final double? width;
  final double? height;
  final String uid;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: UserService.instance.databaseUserRef(widget.uid),
      initialData: Memory.get<UserData>(widget.uid)?.toJson(),
      sync: true,
      builder: (v, r) {
        final anonymousAvatar = ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Icon(
              Icons.person,
              size: widget.width == null ? null : widget.width! * 0.75,
            ),
          ),
        );
        if (v == null) {
          return anonymousAvatar;
        }
        final user = UserData.fromJson(v, widget.uid);
        if (user.photoUrl.isEmpty) {
          return anonymousAvatar;
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: user.photoUrl,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
