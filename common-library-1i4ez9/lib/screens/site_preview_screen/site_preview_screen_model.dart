import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'site_preview_screen_widget.dart' show SitePreviewScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SitePreviewScreenModel extends FlutterFlowModel<SitePreviewScreenWidget> {
  ///  Local state fields for this page.

  String sitePreviewUrl = 'Input URL';

  ///  State fields for stateful widgets in this page.

  // State field(s) for sitePreviewUrl widget.
  FocusNode? sitePreviewUrlFocusNode;
  TextEditingController? sitePreviewUrlTextController;
  String? Function(BuildContext, String?)?
      sitePreviewUrlTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    sitePreviewUrlFocusNode?.dispose();
    sitePreviewUrlTextController?.dispose();
  }
}
