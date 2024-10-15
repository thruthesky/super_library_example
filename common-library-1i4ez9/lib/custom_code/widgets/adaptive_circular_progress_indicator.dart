// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class AdaptiveCircularProgressIndicator extends StatefulWidget {
  const AdaptiveCircularProgressIndicator({
    super.key,
    this.width,
    this.height,
    this.strokeWidth,
  });

  final double? width;
  final double? height;
  final double? strokeWidth;

  @override
  State<AdaptiveCircularProgressIndicator> createState() =>
      _AdaptiveCircularProgressIndicatorState();
}

class _AdaptiveCircularProgressIndicatorState
    extends State<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: widget.strokeWidth ?? 4.0,
      ),
    );
  }
}
