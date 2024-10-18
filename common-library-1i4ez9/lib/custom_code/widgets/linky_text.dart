// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:linkfy_text/linkfy_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkyText extends StatefulWidget {
  const LinkyText({
    super.key,
    this.width,
    this.height,
    required this.text,
  });

  final double? width;
  final double? height;
  final String text;

  @override
  State<LinkyText> createState() => _LinkifyTextState();
}

class _LinkifyTextState extends State<LinkyText> {
  @override
  Widget build(BuildContext context) {
    return LinkifyText(
      widget.text,
      linkStyle: const TextStyle(color: Colors.blue),
      linkTypes: const [LinkType.url],
      onTap: (link) async {
        if (link.type == LinkType.url) {
          if (await canLaunchUrlString(link.value!)) {
            await launchUrlString(link.value!);
          } else {
            throw 'Could not launch ${link.value}';
          }
        }
      },
    );
  }
}
