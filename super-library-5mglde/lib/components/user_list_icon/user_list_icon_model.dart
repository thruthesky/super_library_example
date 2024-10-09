import '/components/user_avatar/user_avatar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'user_list_icon_widget.dart' show UserListIconWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserListIconModel extends FlutterFlowModel<UserListIconWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for UserAvatar component.
  late UserAvatarModel userAvatarModel;

  @override
  void initState(BuildContext context) {
    userAvatarModel = createModel(context, () => UserAvatarModel());
  }

  @override
  void dispose() {
    userAvatarModel.dispose();
  }
}
