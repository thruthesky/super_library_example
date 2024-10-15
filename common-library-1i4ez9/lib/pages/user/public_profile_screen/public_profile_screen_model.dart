import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'public_profile_screen_widget.dart' show PublicProfileScreenWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicProfileScreenModel
    extends FlutterFlowModel<PublicProfileScreenWidget> {
  ///  State fields for stateful widgets in this page.

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
