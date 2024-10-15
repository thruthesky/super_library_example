import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/environment_values.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_debug_content_component_model.dart';
export 'menu_debug_content_component_model.dart';

class MenuDebugContentComponentWidget extends StatefulWidget {
  const MenuDebugContentComponentWidget({super.key});

  @override
  State<MenuDebugContentComponentWidget> createState() =>
      _MenuDebugContentComponentWidgetState();
}

class _MenuDebugContentComponentWidgetState
    extends State<MenuDebugContentComponentWidget> {
  late MenuDebugContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuDebugContentComponentModel());

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
                await Clipboard.setData(ClipboardData(text: currentUserUid));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Copied ${currentUserUid}',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                  ),
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel1,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.grid_3x3,
                    size: 24.0,
                  ),
                  title: 'UID',
                  subtitle: currentUserUid,
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
                context.pushNamed('PhoneSignInScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.phone_iphone_rounded,
                    size: 24.0,
                  ),
                  title: 'Phone Sign In',
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
                context.pushNamed('EmailLoginScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel3,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.alternate_email_rounded,
                    size: 24.0,
                  ),
                  title: 'Email Sign In',
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
                  'UserListScreen',
                  queryParameters: {
                    'type': serializeParam(
                      'rtdb',
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel4,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.groups_rounded,
                    size: 24.0,
                  ),
                  title: 'User Lists (RTDB)',
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
                  'UserListScreen',
                  queryParameters: {
                    'type': serializeParam(
                      'firestore',
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel5,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.groups_rounded,
                    size: 24.0,
                  ),
                  title: 'User Lists (Firestore)',
                ),
              ),
            ),
            Divider(
              height: 4.0,
              thickness: 1.4,
              color: Color(0x68000000),
            ),
            wrapWithModel(
              model: _model.menuListTileComponentModel6,
              updateCallback: () => safeSetState(() {}),
              child: MenuListTileComponentWidget(
                icon: Icon(
                  Icons.bug_report,
                  size: 24.0,
                ),
                title: 'is Debug Mode',
                subtitle: kDebugMode.toString(),
              ),
            ),
            Divider(
              height: 4.0,
              thickness: 1.4,
              color: Color(0x68000000),
            ),
            wrapWithModel(
              model: _model.menuListTileComponentModel7,
              updateCallback: () => safeSetState(() {}),
              child: MenuListTileComponentWidget(
                icon: Icon(
                  Icons.manage_accounts_rounded,
                  size: 24.0,
                ),
                title: 'Current Environment',
                subtitle: FFDevEnvironmentValues.currentEnvironment,
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
                context.pushNamed('BlockListScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel8,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.person_off_rounded,
                    size: 24.0,
                  ),
                  title: 'Block List',
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
                context.pushNamed('ReportListScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel9,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.report_rounded,
                    size: 24.0,
                  ),
                  title: 'Report List',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
