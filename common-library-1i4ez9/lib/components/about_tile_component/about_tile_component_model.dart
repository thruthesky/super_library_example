import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'about_tile_component_widget.dart' show AboutTileComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutTileComponentModel
    extends FlutterFlowModel<AboutTileComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel1;
  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel2;

  @override
  void initState(BuildContext context) {
    menuListTileComponentModel1 =
        createModel(context, () => MenuListTileComponentModel());
    menuListTileComponentModel2 =
        createModel(context, () => MenuListTileComponentModel());
  }

  @override
  void dispose() {
    menuListTileComponentModel1.dispose();
    menuListTileComponentModel2.dispose();
  }
}
