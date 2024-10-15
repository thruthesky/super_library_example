import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'menu_others_content_component_widget.dart'
    show MenuOthersContentComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuOthersContentComponentModel
    extends FlutterFlowModel<MenuOthersContentComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel;

  @override
  void initState(BuildContext context) {
    menuListTileComponentModel =
        createModel(context, () => MenuListTileComponentModel());
  }

  @override
  void dispose() {
    menuListTileComponentModel.dispose();
  }
}
