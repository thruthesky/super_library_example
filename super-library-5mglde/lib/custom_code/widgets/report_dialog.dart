// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    super.key,
    this.width,
    this.height,
    required this.path,
    required this.reportee,
    required this.type,
    required this.summary,
  });

  final double? width;
  final double? height;
  final String path;
  final String type;
  final String reportee;
  final String summary;

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 0),
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Why are you reporting this user?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            /// REVIEW: Get user data from RTDB
            // const Text("TODO: Get user data from RTDB, and display"),

            // UserAvatar.fromUid(
            //   uid: reportee,
            // ),
            // const SizedBox(height: 8),
            // DisplayName(uid: reportee),
            Text('Type: ${widget.type}'),
            Text('Summary: ${widget.summary}'),
            const SizedBox(height: 24),
            Text(
              'Select a reason for reporting',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.maxFinite,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop('spam'),
                    child: const Text('Spam'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop('abusive'),
                    child: const Text('Abusive'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop('other'),
                    child: const Text('Other'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
