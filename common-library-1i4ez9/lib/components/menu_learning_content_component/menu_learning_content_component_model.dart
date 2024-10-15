import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'menu_learning_content_component_widget.dart'
    show MenuLearningContentComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuLearningContentComponentModel
    extends FlutterFlowModel<MenuLearningContentComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel1;
  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel2;
  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel3;
  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel4;

  @override
  void initState(BuildContext context) {
    menuListTileComponentModel1 =
        createModel(context, () => MenuListTileComponentModel());
    menuListTileComponentModel2 =
        createModel(context, () => MenuListTileComponentModel());
    menuListTileComponentModel3 =
        createModel(context, () => MenuListTileComponentModel());
    menuListTileComponentModel4 =
        createModel(context, () => MenuListTileComponentModel());
  }

  @override
  void dispose() {
    menuListTileComponentModel1.dispose();
    menuListTileComponentModel2.dispose();
    menuListTileComponentModel3.dispose();
    menuListTileComponentModel4.dispose();
  }
}
