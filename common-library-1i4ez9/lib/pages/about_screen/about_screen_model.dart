import '/components/about_tile_component/about_tile_component_widget.dart';
import '/components/menu_comic_card_component/menu_comic_card_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'about_screen_widget.dart' show AboutScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutScreenModel extends FlutterFlowModel<AboutScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MenuComicCardComponent component.
  late MenuComicCardComponentModel menuComicCardComponentModel;

  @override
  void initState(BuildContext context) {
    menuComicCardComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
  }

  @override
  void dispose() {
    menuComicCardComponentModel.dispose();
  }
}
