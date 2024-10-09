// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

class ReportListView extends StatefulWidget {
  const ReportListView({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ReportListView> createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: ReportService.instance.myReportsRef.orderByKey(),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            fetchMore(index);
            final report = Report.fromSnapshot(snapshot.docs[index]);
            return Value(
              ref: FirebaseDatabase.instance.ref(
                ReportService.instance.userPhotoUrlPath
                    .replaceFirst('{uid}', report.reportee),
              ),
              builder: (photoUrl, _) => Value(
                ref: FirebaseDatabase.instance.ref(
                  ReportService.instance.userNamePath
                      .replaceFirst('{uid}', report.reportee),
                ),
                builder: (displayName, _) {
                  return Component.reportListTile?.call(
                        report,
                        displayName,
                        photoUrl,
                      ) ??
                      ListTile(
                        leading: CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(
                            photoUrl,
                          ),
                        ),
                        title: Text(
                          '$displayName',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          '${report.reason} ${report.type} ${report.summary}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                },
              ),
            );
          },
        );
      },
    );
  }
}
