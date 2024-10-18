// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CommonCircularProgressIndicator extends StatefulWidget {
  const CommonCircularProgressIndicator({
    super.key,
    this.width,
    this.height,
    this.adaptive,
    this.strokeWidth,
  });

  final double? width;
  final double? height;
  final bool? adaptive;
  final double? strokeWidth;

  @override
  State<CommonCircularProgressIndicator> createState() =>
      _CommonCircularProgressIndicatorState();
}

class _CommonCircularProgressIndicatorState
    extends State<CommonCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    if (widget.adaptive == true) {
      return CircularProgressIndicator.adaptive(
        strokeWidth: widget.strokeWidth ?? 4,
      );
    } else {
      return CircularProgressIndicator(
        strokeWidth: widget.strokeWidth ?? 4,
      );
    }
  }
}
