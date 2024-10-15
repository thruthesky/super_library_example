// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// CommonSafeArea
///
/// The CommonSafeArea widget provides padding to the top or bottom of the screen when
/// there is no system statu bar. [minHeight] can be used to provide a minimum height for
/// the device that does not have a system status bar.
///
class CommonSafeArea extends StatefulWidget {
  const CommonSafeArea({
    super.key,
    this.width,
    this.height,
    this.top,
    this.bottom,
    this.minHeight,
  });

  final double? width;
  final double? height;
  final bool? top;
  final bool? bottom;
  final double? minHeight;

  @override
  State<CommonSafeArea> createState() => _CommonSafeAreaState();
}

class _CommonSafeAreaState extends State<CommonSafeArea> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: widget.top ?? true,
      bottom: widget.bottom ?? true,
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.viewPaddingOf(context).bottom > 0
            ? 0
            : widget.minHeight ?? 16,
      ),
    );
  }
}
