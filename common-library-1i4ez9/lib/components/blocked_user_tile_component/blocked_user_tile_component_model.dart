import '/backend/backend.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'blocked_user_tile_component_widget.dart'
    show BlockedUserTileComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BlockedUserTileComponentModel
    extends FlutterFlowModel<BlockedUserTileComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel =
        createModel(context, () => UserAvatarComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel.dispose();
  }
}
