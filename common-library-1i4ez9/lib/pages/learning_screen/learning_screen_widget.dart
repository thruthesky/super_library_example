import '/components/learning_grid_tile_component/learning_grid_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'learning_screen_model.dart';
export 'learning_screen_model.dart';

class LearningScreenWidget extends StatefulWidget {
  const LearningScreenWidget({super.key});

  @override
  State<LearningScreenWidget> createState() => _LearningScreenWidgetState();
}

class _LearningScreenWidgetState extends State<LearningScreenWidget> {
  late LearningScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LearningScreenModel());

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
              'uj28educ' /* Learning Screen */,
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
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 0.9,
              ),
              scrollDirection: Axis.vertical,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed('PhonicsScreen');
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Phonics',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/1ujaln59zgk3/phonics.webp',
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
                          'English Tutorial',
                          ParamType.String,
                        ),
                        'youtubes': serializeParam(
                          functions.getEnglishTutorialYoutubes(),
                          ParamType.DataStruct,
                          isList: true,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'English Tutorials',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/9sh3c4hmxmgx/english_tutorials.webp',
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
                    model: _model.learningGridTileComponentModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Math',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/k07bqa9s76f2/learn_math.webp',
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
                          'TED Talks - KIDS',
                          ParamType.String,
                        ),
                        'youtubes': serializeParam(
                          functions.getTedTalksYoutubes(),
                          ParamType.DataStruct,
                          isList: true,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'TED Talks - KIDS',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/h01a67p0wo7j/ted_talks_kids.webp',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
