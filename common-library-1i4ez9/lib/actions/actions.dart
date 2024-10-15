import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/report_bottom_sheet_component/report_bottom_sheet_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:super_library_5mglde/custom_code/actions/index.dart'
    as super_library_5mglde_actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

Future blockOrUnblockUser(
  BuildContext context, {
  required String? otherUid,
  required String? displayName,
}) async {
  if ((currentUserDocument?.blockedUsers?.toList() ?? []).contains(otherUid)) {
    await super_library_5mglde_actions.unblockUser(
      otherUid!,
    );
  } else {
    await super_library_5mglde_actions.blockUser(
      otherUid!,
    );
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${(currentUserDocument?.blockedUsers?.toList() ?? []).contains(otherUid) ? 'Blocked' : 'Unblocked'} ${displayName}',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
}

Future reportUser(
  BuildContext context, {
  required String? otherUid,
  required String? summary,
}) async {
  dynamic? data;
  bool? isReportExist;

  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    context: context,
    builder: (context) {
      return WebViewAware(
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: ReportBottomSheetComponentWidget(),
        ),
      );
    },
  ).then((value) => data = value);

  isReportExist = await super_library_5mglde_actions.reportExists(
    getJsonField(
      data,
      r'''$.type''',
    ).toString().toString(),
    otherUid!,
  );
  if (data != null) {
    if (isReportExist == false) {
      await super_library_5mglde_actions.report(
        getJsonField(
          data,
          r'''$.type''',
        ).toString().toString(),
        otherUid!,
        otherUid!,
        getJsonField(
          data,
          r'''$.reason''',
        ).toString().toString(),
        summary!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reported Successfully',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You reported this already',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }
  } else {
    return;
  }
}

Future notImplementedYet(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Page under construction. We\'re working on it.',
        style: TextStyle(),
      ),
      duration: Duration(milliseconds: 1000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
}
