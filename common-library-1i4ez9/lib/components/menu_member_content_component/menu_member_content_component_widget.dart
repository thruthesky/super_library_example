import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_member_content_component_model.dart';
export 'menu_member_content_component_model.dart';

class MenuMemberContentComponentWidget extends StatefulWidget {
  const MenuMemberContentComponentWidget({super.key});

  @override
  State<MenuMemberContentComponentWidget> createState() =>
      _MenuMemberContentComponentWidgetState();
}

class _MenuMemberContentComponentWidgetState
    extends State<MenuMemberContentComponentWidget> {
  late MenuMemberContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuMemberContentComponentModel());

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
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('ProfileEditScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel1,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.person_rounded,
                    size: 24.0,
                  ),
                  title: 'Update Profile',
                ),
              ),
            ),
            Divider(
              height: 4.0,
              thickness: 1.4,
              color: Color(0x68000000),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('StateEditScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.location_history,
                    size: 24.0,
                  ),
                  title: 'Update State',
                ),
              ),
            ),
            Divider(
              height: 4.0,
              thickness: 1.4,
              color: Color(0x68000000),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'PublicProfileScreen',
                  queryParameters: {
                    'userDocumentReference': serializeParam(
                      currentUserReference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel3,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.face_rounded,
                    size: 24.0,
                  ),
                  title: 'Public Profile',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
