// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Block a user
///
/// This function blocks a user by adding their UID to the current user's
/// `blockedUsers` array.
///
/// Note that, this function does not check if the user is already blocked.
Future blockUser(String otherUid) async {
  final myRef = firestore.collection('users').doc(myUid);

  await myRef.update({
    'blockedUsers': FieldValue.arrayUnion([otherUid])
  });
}
