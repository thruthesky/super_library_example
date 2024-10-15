// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<bool> isAnonymous() async {
  // Add your function code here!

  // If the user signed in,
  if (loggedIn) {
    // If the user is anonymous, then return true.
    if (FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      return true;
    }

    // If the user signed in but the email and phone number are empty, then
    // consider the user is anonymous.
    if ((currentUserEmail == null || currentUserEmail == '') &&
        (currentPhoneNumber == null || currentPhoneNumber == '')) {
      return true;
    }
  }

  // Otherwise, return false.
  return false;
}
