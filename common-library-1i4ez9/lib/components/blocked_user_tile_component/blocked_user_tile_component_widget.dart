import '/backend/backend.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'blocked_user_tile_component_model.dart';
export 'blocked_user_tile_component_model.dart';

class BlockedUserTileComponentWidget extends StatefulWidget {
  const BlockedUserTileComponentWidget({
    super.key,
    required this.userDocument,
  });

  final UsersRecord? userDocument;

  @override
  State<BlockedUserTileComponentWidget> createState() =>
      _BlockedUserTileComponentWidgetState();
}

class _BlockedUserTileComponentWidgetState
    extends State<BlockedUserTileComponentWidget> {
  late BlockedUserTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlockedUserTileComponentModel());

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.userAvatarComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: UserAvatarComponentWidget(
                uid: widget!.userDocument!.uid,
                size: 62.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget!.userDocument?.displayName,
                        ' No Name',
                      ),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
            ),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 80.0,
              buttonSize: 40.0,
              fillColor: Colors.transparent,
              icon: Icon(
                Icons.delete,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                await action_blocks.blockOrUnblockUser(
                  context,
                  otherUid: widget!.userDocument?.uid,
                  displayName: widget!.userDocument?.displayName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
