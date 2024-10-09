// Automatic FlutterFlow imports

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'package:super_library/custom_code/actions/super_library.dart';

Future<UserDataModelStruct> toUserDataModel(dynamic data) async {
  final userDataJSON = data as Map<String, dynamic>;
  return UserData.fromJson(userDataJSON, userDataJSON['uid'])
      as UserDataModelStruct;
}
