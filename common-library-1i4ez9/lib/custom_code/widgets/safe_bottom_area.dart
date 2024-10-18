// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// SafeBottomArea
///
/// The SafeBottomArea widget adds padding to the bottom of the screen.
///
/// - If there is a system status bar, it applies SafeArea to the bottom.
/// - If there is no system status bar, it provides padding to the bottom.
///
/// ### Parameters:
/// - [height]: The height of the SafeBottomArea widget. Defaults to 16 if not provided.
///
/// ### Usage:
/// Normally, you don't need this widget. The content usually looks fine even if it's hidden by the system status bar.
///
/// However, if you have a custom bottom navigation bar and don't want it to be
/// hidden by the system status bar, or most importantly, if you want to add
/// some padding to the bottom of the screen for your custom bottom navigation
/// bar to have space, you can use this widget.
///
class SafeBottomArea extends StatefulWidget {
  const SafeBottomArea({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SafeBottomArea> createState() => _SafeBottomAreaState();
}

class _SafeBottomAreaState extends State<SafeBottomArea> {
  @override
  Widget build(BuildContext context) {
    final hasStatusBar = View.of(context).padding.bottom > 0;
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        color: Colors.transparent,
        height: hasStatusBar ? 0 : widget.height ?? 16,
      ),
    );
  }
}
