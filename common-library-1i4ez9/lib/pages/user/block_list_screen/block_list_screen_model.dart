import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/blocked_user_tile_component/blocked_user_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'block_list_screen_widget.dart' show BlockListScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BlockListScreenModel extends FlutterFlowModel<BlockListScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for BlockedUserTileComponent dynamic component.
  late FlutterFlowDynamicModels<BlockedUserTileComponentModel>
      blockedUserTileComponentModels;

  @override
  void initState(BuildContext context) {
    blockedUserTileComponentModels =
        FlutterFlowDynamicModels(() => BlockedUserTileComponentModel());
  }

  @override
  void dispose() {
    blockedUserTileComponentModels.dispose();
  }
}
