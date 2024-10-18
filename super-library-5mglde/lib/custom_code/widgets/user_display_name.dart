// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

import '/custom_code/actions/super_library.dart';

class UserDisplayName extends StatefulWidget {
  const UserDisplayName({
    super.key,
    this.width,
    this.height,
    required this.uid,
    this.fontSize,
    this.color,
  });

  final double? width;
  final double? height;
  final String uid;
  final int? fontSize;
  final Color? color;

  @override
  State<UserDisplayName> createState() => _UserDisplayNameState();
}

class _UserDisplayNameState extends State<UserDisplayName> {
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: UserService.instance
          .databaseUserRef(widget.uid)
          .child(UserData.field.displayName),
      onLoading: const Text("..."),
      builder: (displayName, ref) {
        return Text(
          displayName ?? "No name",
        );
      },
    );
  }
}
