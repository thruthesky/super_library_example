// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

/// Invite a user to a chat room.
///
/// [roomId] is the chat room ID.
///
/// [otherUid] is the user ID to invite.
Future inviteChatUser(
  String roomId,
  String otherUid,
) async {
  // Add your function code here!
  final room = await ChatRoom.get(roomId);
  if (room == null) {
    dog('The chat room does not exist.');
    throw SuperLibraryException(
        'invite-chat-user', 'The chat room does not exist.');
  }

  if (room.users[otherUid] != null) {
    // TODO: The user is already in the chat room. Show a warning message.
    dog('The user is already in the chat room.');
    return;
  }

  if (room.allMembersCanInvite == false) {
    // TODO: The user is not allowed to invite other users. Show a warning message.
    dog('The user is not allowed to invite other users.');
    return;
  }

  // Invite the user
  // The user is set to false, because the user has not accepted the invitation yet.
  // TODO: Send a notification to the user.
  await ChatService.instance.invite(roomId: roomId, otherUid: otherUid);
}
