import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'menu_account_content_component_widget.dart'
    show MenuAccountContentComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class MenuAccountContentComponentModel
    extends FlutterFlowModel<MenuAccountContentComponentWidget> {
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
