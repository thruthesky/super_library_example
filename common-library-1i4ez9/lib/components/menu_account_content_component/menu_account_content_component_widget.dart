import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'menu_account_content_component_model.dart';
export 'menu_account_content_component_model.dart';

class MenuAccountContentComponentWidget extends StatefulWidget {
  const MenuAccountContentComponentWidget({super.key});

  @override
  State<MenuAccountContentComponentWidget> createState() =>
      _MenuAccountContentComponentWidgetState();
}

class _MenuAccountContentComponentWidgetState
    extends State<MenuAccountContentComponentWidget> {
  late MenuAccountContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuAccountContentComponentModel());

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
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return WebViewAware(
                          child: AlertDialog(
                            title: Text('Sign Out'),
                            content: Text('Do you want to sign out?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      },
                    ) ??
                    false;
                if (confirmDialogResponse) {
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signOut();
                  GoRouter.of(context).clearRedirectLocation();

                  context.goNamedAuth('HomeScreen', context.mounted);
                }
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel1,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 24.0,
                  ),
                  title: 'Sign Out',
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
                context.pushNamed('ResignScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.person_off_rounded,
                    size: 24.0,
                  ),
                  title: 'Resign',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
