import '/components/learning_grid_tile_component/learning_grid_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'math_learning_screen_model.dart';
export 'math_learning_screen_model.dart';

class MathLearningScreenWidget extends StatefulWidget {
  const MathLearningScreenWidget({super.key});

  @override
  State<MathLearningScreenWidget> createState() =>
      _MathLearningScreenWidgetState();
}

class _MathLearningScreenWidgetState extends State<MathLearningScreenWidget> {
  late MathLearningScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MathLearningScreenModel());

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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'w2ltco3p' /* Math Learning */,
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
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
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
                    context.pushNamed(
                      'MathLearnOperationScreen',
                      queryParameters: {
                        'title': serializeParam(
                          'Learn Addition',
                          ParamType.String,
                        ),
                        'operation': serializeParam(
                          'addition',
                          ParamType.String,
                        ),
                        'youtubeId': serializeParam(
                          'RwnqECUD6SI',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Learn Addition',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/59in7hyno7iw/addition.webp',
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
                      'MathLearnOperationScreen',
                      queryParameters: {
                        'title': serializeParam(
                          'Learn Subtraction',
                          ParamType.String,
                        ),
                        'operation': serializeParam(
                          'subtraction',
                          ParamType.String,
                        ),
                        'youtubeId': serializeParam(
                          'C1QG7etNF2U',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Learn Subtraction',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/7wkj23xinq4n/subtraction.webp',
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
                      'MathLearnOperationScreen',
                      queryParameters: {
                        'title': serializeParam(
                          'Learn Multiplication',
                          ParamType.String,
                        ),
                        'operation': serializeParam(
                          'multiplication',
                          ParamType.String,
                        ),
                        'youtubeId': serializeParam(
                          'h0RF0N5TOPE',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Learn Multiplication',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/wdjja2vrlloc/multiplication.webp',
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
                      'MathLearnOperationScreen',
                      queryParameters: {
                        'title': serializeParam(
                          'Learn Division',
                          ParamType.String,
                        ),
                        'operation': serializeParam(
                          'division',
                          ParamType.String,
                        ),
                        'youtubeId': serializeParam(
                          'T3h1HUVHLJo',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Learn Division',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/baorkwyier3x/division.webp',
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
                      'MathLearnOperationScreen',
                      queryParameters: {
                        'title': serializeParam(
                          'Learn Percentage',
                          ParamType.String,
                        ),
                        'operation': serializeParam(
                          'percentage',
                          ParamType.String,
                        ),
                        'youtubeId': serializeParam(
                          'kDFLcCOS7aw',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.learningGridTileComponentModel5,
                    updateCallback: () => safeSetState(() {}),
                    child: LearningGridTileComponentWidget(
                      title: 'Learn Percentage',
                      imageUrl:
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/ai-cool-bjd3vp/assets/b3udkdxxn3qu/percentage.webp',
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
