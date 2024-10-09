import '/components/comic_box/comic_box_widget.dart';
import '/components/user_avatar/user_avatar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ComicBox component.
  late ComicBoxModel comicBoxModel;

  @override
  void initState(BuildContext context) {
    comicBoxModel = createModel(context, () => ComicBoxModel());
  }

  @override
  void dispose() {
    comicBoxModel.dispose();
  }
}
