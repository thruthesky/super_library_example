// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isAnonymous() async {
  // Add your function code here!

  final currentUser = FirebaseAuth.instance.currentUser;
  // If the user signed in,
  if (currentUser != null) {
    // If the user is anonymous, then return true.
    if (currentUser?.isAnonymous == true) {
      return true;
    }

    // If the user signed in but the email and phone number are empty, then
    // consider the user is anonymous.
    if ((currentUser?.email == null || currentUser?.email == '') &&
        (currentUser?.phoneNumber == null || currentUser?.phoneNumber == '')) {
      return true;
    }
  }

  // Otherwise, return false.
  return false;
}
