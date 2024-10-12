// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

Future editChatRoom(
  String? roomId,
  String name,
  String? description,
  String? iconUrl,
  bool? open,
  bool? canInvite,
) async {
  // Add your function code here!
  if (roomId == null) {
    await createChatRoom(name, description, iconUrl, open, canInvite);
  } else {
    final room = await ChatRoom.get(roomId);
    await room!.update(
      name: name,
      description: description,
      iconUrl: iconUrl,
      open: open ?? true,
      allMembersCanInvite: canInvite ?? true,
    );
  }
}
