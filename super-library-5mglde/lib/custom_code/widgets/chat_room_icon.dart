// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

import 'package:cached_network_image/cached_network_image.dart';
import '/custom_code/actions/super_library.dart';

/// ChatRoomIcon
///
/// Display the chat room icon.
///
///
class ChatRoomIcon extends StatefulWidget {
  const ChatRoomIcon({
    super.key,
    this.width,
    this.height,
    required this.roomId,
    this.radius,
  });

  final double? width;
  final double? height;
  final String roomId;
  final double? radius;

  @override
  State<ChatRoomIcon> createState() => _ChatRoomIconState();
}

class _ChatRoomIconState extends State<ChatRoomIcon> {
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: isSingleChatRoom(widget.roomId)
          ? userPhotoUrlRef(otherUid(widget.roomId))
          : roomRef(widget.roomId).child(ChatRoom.field.iconUrl),
      builder: (iconUrl, ref) {
        return Container(
          width: widget.width ?? 52,
          height: widget.height ?? 52,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 25),
          ),
          child: iconUrl != null && iconUrl.isNotEmpty
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: iconUrl,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chat,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
