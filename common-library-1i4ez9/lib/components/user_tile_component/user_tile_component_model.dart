import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'user_tile_component_widget.dart' show UserTileComponentWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserTileComponentModel extends FlutterFlowModel<UserTileComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - userRefById] action in UserTileComponent widget.
  DocumentReference? userDocumentReference1;
  // Stores action output result for [Custom Action - userRefById] action in Container widget.
  DocumentReference? userDocumentReference;
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
