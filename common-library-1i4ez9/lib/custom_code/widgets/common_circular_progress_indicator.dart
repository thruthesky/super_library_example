// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/material.dart' as md;

class CircularProgressIndicator extends StatefulWidget {
  const CircularProgressIndicator({
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
  State<CircularProgressIndicator> createState() =>
      _CircularProgressIndicatorState();
}

class _CircularProgressIndicatorState extends State<CircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    if (widget.adaptive == true) {
      return md.CircularProgressIndicator.adaptive(
        strokeWidth: widget.strokeWidth ?? 4,
      );
    } else {
      return md.CircularProgressIndicator(
        strokeWidth: widget.strokeWidth ?? 4,
      );
    }
  }
}
