import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/report_list_tile_component/report_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'report_list_screen_widget.dart' show ReportListScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportListScreenModel extends FlutterFlowModel<ReportListScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for ReportListTileComponent dynamic component.
  late FlutterFlowDynamicModels<ReportListTileComponentModel>
      reportListTileComponentModels;

  @override
  void initState(BuildContext context) {
    reportListTileComponentModels =
        FlutterFlowDynamicModels(() => ReportListTileComponentModel());
  }

  @override
  void dispose() {
    reportListTileComponentModels.dispose();
  }
}
