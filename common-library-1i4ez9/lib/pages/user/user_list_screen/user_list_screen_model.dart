import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/user_tile_component/user_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:super_library_5mglde/custom_code/widgets/index.dart'
    as super_library_5mglde_custom_widgets;
import 'user_list_screen_widget.dart' show UserListScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserListScreenModel extends FlutterFlowModel<UserListScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for UserTileComponent dynamic component.
  late FlutterFlowDynamicModels<UserTileComponentModel> userTileComponentModels;

  @override
  void initState(BuildContext context) {
    userTileComponentModels =
        FlutterFlowDynamicModels(() => UserTileComponentModel());
  }

  @override
  void dispose() {
    userTileComponentModels.dispose();
  }
}
