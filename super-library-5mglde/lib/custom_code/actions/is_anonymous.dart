// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

/// [isAnonymous] checks if the current user is anonymous.
Future<bool> isAnonymous() async {
  // Add your function code here!

  final currentUser = FirebaseAuth.instance.currentUser;
  // If the user signed in,
  if (currentUser != null) {
    // If the user is anonymous, then return true.
    if (currentUser.isAnonymous == true) {
      return true;
    }

    if (currentUser.isAnonymous == false) {
      return false;
    }
  }

  // Otherwise, return false.
  return false;
}
