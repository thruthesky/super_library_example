import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/home_grid_tile_component/home_grid_tile_component_widget.dart';
import '/components/home_screen_tile_component/home_screen_tile_component_widget.dart';
import '/components/images/a_i_assistant_image_component/a_i_assistant_image_component_widget.dart';
import '/components/images/home_work_a_i_image_component/home_work_a_i_image_component_widget.dart';
import '/components/images/learn_a_i_image_component/learn_a_i_image_component_widget.dart';
import '/components/images/learn_english_image_component/learn_english_image_component_widget.dart';
import '/components/images/learn_math_image_component/learn_math_image_component_widget.dart';
import '/components/images/music_image_component/music_image_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
export 'home_screen_model.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late HomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!loggedIn) {
        GoRouter.of(context).prepareAuthEvent();
        final user = await authManager.signInAnonymously(context);
        if (user == null) {
          return;
        }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              'aznlh5li' /* AI COOL */,
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Inter Tight',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('AILearningScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeGridTileComponentModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeGridTileComponentWidget(
                            label: FFLocalizations.of(context).getText(
                              'jjxejav6' /* LEARN AI */,
                            ),
                            imageBuilder: () => LearnAIImageComponentWidget(),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('HomeworkAiScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeGridTileComponentModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeGridTileComponentWidget(
                            label: FFLocalizations.of(context).getText(
                              'rhhufrz3' /* HOMEWORK AI */,
                            ),
                            imageBuilder: () =>
                                HomeWorkAIImageComponentWidget(),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('ChatAiScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeGridTileComponentModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeGridTileComponentWidget(
                            label: FFLocalizations.of(context).getText(
                              '51w3ikz1' /* AI ASSISTANT */,
                            ),
                            imageBuilder: () =>
                                AIAssistantImageComponentWidget(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 62.0,
                    thickness: 1.4,
                    color: Color(0x68000000),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('AILearningScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeScreenTileComponentModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeScreenTileComponentWidget(
                            title: FFLocalizations.of(context).getText(
                              'xnvg52m7' /* Learn AI */,
                            ),
                            subtitle: FFLocalizations.of(context).getText(
                              'ovwgw7bm' /* Have a fun journey into AI wor... */,
                            ),
                            imageBuilder: () => LearnAIImageComponentWidget(
                              height: 52.0,
                              width: 52.0,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('LearningScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeScreenTileComponentModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeScreenTileComponentWidget(
                            title: FFLocalizations.of(context).getText(
                              '2mm0pcx5' /* Learn English */,
                            ),
                            subtitle: FFLocalizations.of(context).getText(
                              't6cwx7se' /* Let's learn English with fun a... */,
                            ),
                            imageBuilder: () =>
                                LearnEnglishImageComponentWidget(
                              height: 52.0,
                              width: 52.0,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('MathLearningScreen');
                        },
                        child: wrapWithModel(
                          model: _model.homeScreenTileComponentModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeScreenTileComponentWidget(
                            title: FFLocalizations.of(context).getText(
                              'yihmhln3' /* Learn Math */,
                            ),
                            subtitle: FFLocalizations.of(context).getText(
                              'ggziq9ku' /* Give yourself confidence in ma... */,
                            ),
                            imageBuilder: () => LearnMathImageComponentWidget(
                              height: 52.0,
                              width: 52.0,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'YoutubeListScreen',
                            queryParameters: {
                              'title': serializeParam(
                                'Idol Music',
                                ParamType.String,
                              ),
                              'youtubes': serializeParam(
                                functions.getMusicYoutubes(),
                                ParamType.DataStruct,
                                isList: true,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: wrapWithModel(
                          model: _model.homeScreenTileComponentModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: HomeScreenTileComponentWidget(
                            title: FFLocalizations.of(context).getText(
                              'qkliz9ah' /* Listen to Music */,
                            ),
                            subtitle: FFLocalizations.of(context).getText(
                              '553x8uwf' /* Sing and dance with your favor... */,
                            ),
                            imageBuilder: () => MusicImageComponentWidget(
                              height: 52.0,
                              width: 52.0,
                            ),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 24.0))
                        .addToEnd(SizedBox(height: 24.0)),
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
