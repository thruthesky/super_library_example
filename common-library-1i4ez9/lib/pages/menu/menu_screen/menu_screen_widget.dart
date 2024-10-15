import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_account_content_component/menu_account_content_component_widget.dart';
import '/components/menu_comic_card_component/menu_comic_card_component_widget.dart';
import '/components/menu_debug_content_component/menu_debug_content_component_widget.dart';
import '/components/menu_homework_a_i_content_component/menu_homework_a_i_content_component_widget.dart';
import '/components/menu_learning_content_component/menu_learning_content_component_widget.dart';
import '/components/menu_member_content_component/menu_member_content_component_widget.dart';
import '/components/menu_others_content_component/menu_others_content_component_widget.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_screen_model.dart';
export 'menu_screen_model.dart';

class MenuScreenWidget extends StatefulWidget {
  const MenuScreenWidget({super.key});

  @override
  State<MenuScreenWidget> createState() => _MenuScreenWidgetState();
}

class _MenuScreenWidgetState extends State<MenuScreenWidget> {
  late MenuScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isAnonymous = await actions.isAnonymous();
      if (_model.isAnonymous!) {
        context.goNamed('AnonymousMenuScreen');
      } else {
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: !valueOrDefault<bool>(
              _model.isAnonymous,
              true,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(),
                          child: wrapWithModel(
                            model: _model.userAvatarComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: UserAvatarComponentWidget(
                              uid: currentUserUid,
                              borderRadius: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (valueOrDefault(
                                            currentUserDocument?.name, '') !=
                                        null &&
                                    valueOrDefault(
                                            currentUserDocument?.name, '') !=
                                        '')
                                  AuthUserStreamWidget(
                                    builder: (context) => Text(
                                      valueOrDefault(
                                          currentUserDocument?.name, ''),
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                if (currentUserDisplayName != null &&
                                    currentUserDisplayName != '')
                                  AuthUserStreamWidget(
                                    builder: (context) => Text(
                                      currentUserDisplayName,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                if ((currentUserDisplayName == null ||
                                        currentUserDisplayName == '') &&
                                    (valueOrDefault(currentUserDocument?.name,
                                                '') ==
                                            null ||
                                        valueOrDefault(
                                                currentUserDocument?.name,
                                                '') ==
                                            ''))
                                  AuthUserStreamWidget(
                                    builder: (context) => Text(
                                      FFLocalizations.of(context).getText(
                                        'mvbdht0c' /* Update your profile */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('ProfileEditScreen');
                          },
                          text: FFLocalizations.of(context).getText(
                            'gajdz5te' /* Update */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.4,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 64.0,
                    thickness: 1.4,
                    indent: 24.0,
                    endIndent: 24.0,
                    color: Color(0x68000000),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (kDebugMode)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 24.0),
                            child: wrapWithModel(
                              model: _model.menuDebugComponentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: MenuComicCardComponentWidget(
                                label: 'Debug',
                                child: () => MenuDebugContentComponentWidget(),
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: wrapWithModel(
                            model: _model.menuMemberComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MenuComicCardComponentWidget(
                              label: 'Member',
                              child: () => MenuMemberContentComponentWidget(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: wrapWithModel(
                            model: _model.menuLearningComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MenuComicCardComponentWidget(
                              label: 'Learning',
                              child: () => MenuLearningContentComponentWidget(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: wrapWithModel(
                            model: _model.menuHomeworkAIComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MenuComicCardComponentWidget(
                              label: 'Homework Helper AI',
                              child: () =>
                                  MenuHomeworkAIContentComponentWidget(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: wrapWithModel(
                            model: _model.menuAccountComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MenuComicCardComponentWidget(
                              label: 'Account',
                              child: () => MenuAccountContentComponentWidget(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: wrapWithModel(
                            model: _model.menuOthersComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MenuComicCardComponentWidget(
                              label: 'Others',
                              child: () => MenuOthersContentComponentWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
