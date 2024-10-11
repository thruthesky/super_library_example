// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/custom_code/actions/super_library.dart';

Future report(
  String type,
  String id,
  String reporteeUid,
  String reason,
  String summary,
) async {
  final data = {
    'reporter': myUid,
    'reportee': reporteeUid,
    'reason': reason,
    'id': id,
    'type': type,
    'summary': summary,
    'createdAt': Timestamp.now(),
  };

  final reportId = '$myUid-$type-$id';

  /// Set to firestore
  await Report.col.doc(reportId).set(data);
}
