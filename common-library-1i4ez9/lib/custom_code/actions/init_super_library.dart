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

import '/components/user_tile_component/user_tile_component_widget.dart';
import 'package:super_library_5mglde/custom_code/actions/super_library.dart';

Future initSuperLibrary() async {
  SuperLibrary.instance.init(
    getDatabaseUrl: () => FFDevEnvironmentValues().databaseURL,
    // 'https://withcenter-test-4-default-rtdb.firebaseio.com'
    // 'https://withcenter-school-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  Component.userListTile = (user) {
    FFUserDataStruct ffUserData = FFUserDataStruct(
      photoUrl: user.photoUrl,
      displayName: user.displayName,
      displayNameLowerCase: user.displayNameLowerCase,
      createdAt: DateTime.fromMillisecondsSinceEpoch(user.createdAt),
      uid: user.uid,
    );
    return UserTileComponentWidget(
      userData: ffUserData,
    );
  };
}
