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
    this.radius,
  });

  final double? width;
  final double? height;
  final String uid;
  final double? radius;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  final double _defaultSize = 50;
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: UserService.instance.databaseUserRef(widget.uid),
      initialData: Memory.get<UserData>(widget.uid)?.toJson(),
      sync: true,
      builder: (v, r) {
        final anonymousAvatar = ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius ?? _defaultSize),
          child: Container(
            color: FlutterFlowTheme.of(context).alternate,
            width: widget.width ?? _defaultSize,
            height: widget.height ?? _defaultSize,
            child: Icon(
              Icons.person,
              size:
                  (widget.width == null ? _defaultSize : widget.width!) * 0.64,
              color: FlutterFlowTheme.of(context).primaryText,
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
          borderRadius: BorderRadius.circular(widget.radius ?? _defaultSize),
          child: CachedNetworkImage(
            imageUrl: user.photoUrl,
            width: widget.width ?? _defaultSize,
            height: widget.height ?? _defaultSize,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
