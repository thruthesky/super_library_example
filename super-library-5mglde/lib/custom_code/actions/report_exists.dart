// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

/// Check if the same report exists
Future<bool> reportExists(String type, String id) async {
  // Add your function code here!
  final reportId = '$myUid-$type-$id';
  final snapshot = await Report.col.doc(reportId).get();

  return snapshot.exists;
}
