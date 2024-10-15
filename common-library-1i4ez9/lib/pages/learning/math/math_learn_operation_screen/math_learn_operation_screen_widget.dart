import '/components/math_learning_icons_component/math_learning_icons_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'math_learn_operation_screen_model.dart';
export 'math_learn_operation_screen_model.dart';

class MathLearnOperationScreenWidget extends StatefulWidget {
  const MathLearnOperationScreenWidget({
    super.key,
    required this.title,
    required this.operation,
    required this.youtubeId,
  });

  final String? title;
  final String? operation;
  final String? youtubeId;

  @override
  State<MathLearnOperationScreenWidget> createState() =>
      _MathLearnOperationScreenWidgetState();
}

class _MathLearnOperationScreenWidgetState
    extends State<MathLearnOperationScreenWidget> {
  late MathLearnOperationScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MathLearnOperationScreenModel());

    _model.answerTextFieldTextController ??= TextEditingController();
    _model.answerTextFieldFocusNode ??= FocusNode();

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
            widget!.title!,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: FlutterFlowYoutubePlayer(
                        url: functions.getYoutubeUrl(widget!.youtubeId!),
                        autoPlay: false,
                        looping: true,
                        mute: false,
                        showControls: true,
                        showFullScreen: false,
                        strictRelatedVideos: true,
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (_model.currentQuestionNumber! <
                        valueOrDefault<int>(
                          functions
                              .getPracticeQuestions(widget!.operation!)
                              ?.length,
                          10,
                        )) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '9ld508u0' /* Practice */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final index = functions
                                            .generateEmptyList(
                                                valueOrDefault<int>(
                                              functions
                                                  .getPracticeQuestions(
                                                      widget!.operation!)
                                                  ?.length,
                                              10,
                                            ))
                                            .toList();

                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(index.length,
                                              (indexIndex) {
                                            final indexItem = index[indexIndex];
                                            return Builder(
                                              builder: (context) {
                                                if (indexIndex <=
                                                    _model
                                                        .currentQuestionNumber!) {
                                                  return Icon(
                                                    Icons.circle_rounded,
                                                    color: _model.correctAnswers
                                                            .contains(
                                                                indexIndex)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    size: indexIndex ==
                                                            _model
                                                                .currentQuestionNumber
                                                        ? 16.0
                                                        : 12.0,
                                                  );
                                                } else {
                                                  return Icon(
                                                    Icons.circle_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 12.0,
                                                  );
                                                }
                                              },
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        Icons.lightbulb_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        _model.correctAnswer = functions
                                            .getAnswer(
                                                widget!.operation!,
                                                (functions.getPracticeQuestions(
                                                        widget!
                                                            .operation!)![_model
                                                        .currentQuestionNumber!])
                                                    .numbers
                                                    .toList());
                                        safeSetState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                if (_model.isCorrectAnswer != null)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 16.0),
                                    child: Builder(
                                      builder: (context) {
                                        if (_model.isCorrectAnswer ?? false) {
                                          return Text(
                                            FFLocalizations.of(context).getText(
                                              '19aprizs' /* Correct Answer. Great Job! */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .success,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          );
                                        } else {
                                          return Text(
                                            FFLocalizations.of(context).getText(
                                              '9pvqpg2l' /* Try again */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Text(
                                    functions.getQuestion(
                                        widget!.operation!,
                                        (functions.getPracticeQuestions(
                                                    widget!.operation!)![
                                                _model.currentQuestionNumber!])
                                            .numbers
                                            .toList()),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  child: wrapWithModel(
                                    model:
                                        _model.mathLearningIconsComponentModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: MathLearningIconsComponentWidget(
                                      operation: widget!.operation!,
                                      numbers: (functions.getPracticeQuestions(
                                                  widget!.operation!)?[
                                              _model.currentQuestionNumber!])
                                          ?.numbers,
                                      isCorrectAnswer: _model.isCorrectAnswer,
                                      answer: int.tryParse(_model
                                          .answerTextFieldTextController.text),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.answerTextFieldTextController,
                                      focusNode:
                                          _model.answerTextFieldFocusNode,
                                      autofocus: false,
                                      readOnly: _model.isCorrectAnswer != null
                                          ? _model.isCorrectAnswer!
                                          : false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          'ywzxdt9t' /* Enter your answer */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1.3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1.3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      keyboardType: TextInputType.number,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .answerTextFieldTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_model.isCorrectAnswer ?? false) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            safeSetState(() {
                                              _model
                                                  .answerTextFieldTextController
                                                  ?.clear();
                                            });
                                            _model.currentQuestionNumber =
                                                _model.currentQuestionNumber! +
                                                    1;
                                            _model.isCorrectAnswer = null;
                                            _model.addToCorrectAnswers((_model
                                                    .currentQuestionNumber!) -
                                                1);
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '5ceqjzh9' /* Next */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.isCorrectAnswer = functions.checkAnswer(
                                                widget!.operation!,
                                                (functions.getPracticeQuestions(
                                                        widget!
                                                            .operation!)![_model
                                                        .currentQuestionNumber!])
                                                    .numbers
                                                    .toList(),
                                                int.tryParse(_model
                                                    .answerTextFieldTextController
                                                    .text));
                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'r866x7oc' /* Submit */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                if (_model.isCorrectAnswer == false)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        safeSetState(() {
                                          _model.answerTextFieldTextController
                                              ?.clear();
                                        });
                                        _model.currentQuestionNumber =
                                            _model.currentQuestionNumber! + 1;
                                        _model.isCorrectAnswer = null;
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'tpzs1267' /* Next */,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.celebration,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 32.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '6aue3zmd' /* Lesson Complete */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.celebration_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 32.0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 24.0),
                                  child: Text(
                                    '${_model.correctAnswers.length.toString()}/${valueOrDefault<String>(
                                      functions
                                          .getPracticeQuestions(
                                              widget!.operation!)
                                          ?.length
                                          ?.toString(),
                                      '10',
                                    )}',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      safeSetState(() {
                                        _model.answerTextFieldTextController
                                            ?.clear();
                                      });
                                      _model.currentQuestionNumber = 0;
                                      _model.isCorrectAnswer = null;
                                      _model.correctAnswers = [];
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      '96dwjj26' /* Restart */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.3,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                if (kDebugMode)
                  Text(
                    'curr: ${_model.currentQuestionNumber?.toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                if (kDebugMode)
                  Builder(
                    builder: (context) {
                      final ss = _model.correctAnswers.toList();

                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: List.generate(ss.length, (ssIndex) {
                          final ssItem = ss[ssIndex];
                          return Text(
                            ssItem.toString(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          );
                        }),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
