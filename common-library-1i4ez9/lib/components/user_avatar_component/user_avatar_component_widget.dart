import '/flutter_flow/flutter_flow_util.dart';
import 'package:super_library_5mglde/custom_code/widgets/index.dart'
    as super_library_5mglde_custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_avatar_component_model.dart';
export 'user_avatar_component_model.dart';

class UserAvatarComponentWidget extends StatefulWidget {
  const UserAvatarComponentWidget({
    super.key,
    double? borderRadius,
    required this.uid,
    double? size,
  })  : this.borderRadius = borderRadius ?? 100.0,
        this.size = size ?? 100.0;

  final double borderRadius;
  final String? uid;
  final double size;

  @override
  State<UserAvatarComponentWidget> createState() =>
      _UserAvatarComponentWidgetState();
}

class _UserAvatarComponentWidgetState extends State<UserAvatarComponentWidget> {
  late UserAvatarComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserAvatarComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget!.size,
      height: widget!.size,
      decoration: BoxDecoration(),
      child: super_library_5mglde_custom_widgets.UserAvatar(
        width: 80.0,
        height: 80.0,
        uid: widget!.uid!,
        radius: widget!.borderRadius,
      ),
    );
  }
}
