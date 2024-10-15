import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'math_learning_icons_component_model.dart';
export 'math_learning_icons_component_model.dart';

class MathLearningIconsComponentWidget extends StatefulWidget {
  const MathLearningIconsComponentWidget({
    super.key,
    required this.operation,
    this.numbers,
    bool? isCorrectAnswer,
    int? answer,
  })  : this.isCorrectAnswer = isCorrectAnswer ?? false,
        this.answer = answer ?? 0;

  final String? operation;
  final List<int>? numbers;
  final bool isCorrectAnswer;
  final int answer;

  @override
  State<MathLearningIconsComponentWidget> createState() =>
      _MathLearningIconsComponentWidgetState();
}

class _MathLearningIconsComponentWidgetState
    extends State<MathLearningIconsComponentWidget> {
  late MathLearningIconsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MathLearningIconsComponentModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Builder(
        builder: (context) {
          if (widget!.operation != 'percentage') {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final index = functions
                          .generateEmptyList(widget!.numbers!.first)
                          .toList();

                      return Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: List.generate(index.length, (indexIndex) {
                          final indexItem = index[indexIndex];
                          return Icon(
                            Icons.park_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          );
                        }),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: Text(
                    () {
                      if (widget!.operation == 'addition') {
                        return '+';
                      } else if (widget!.operation == 'subtraction') {
                        return '-';
                      } else if (widget!.operation == 'multiplication') {
                        return 'x';
                      } else {
                        return '/';
                      }
                    }(),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final index = functions
                          .generateEmptyList(widget!.numbers!.last)
                          .toList();

                      return Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: List.generate(index.length, (indexIndex) {
                          final indexItem = index[indexIndex];
                          return Icon(
                            Icons.park_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          );
                        }),
                      );
                    },
                  ),
                ),
                if (valueOrDefault<bool>(
                  widget!.isCorrectAnswer,
                  false,
                ))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '7vfcmby0' /* = */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                if (valueOrDefault<bool>(
                  widget!.isCorrectAnswer,
                  false,
                ))
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final index = functions
                            .generateEmptyList(functions.getAnswer(
                                widget!.operation!, widget!.numbers!.toList())!)
                            .toList();

                        return Wrap(
                          spacing: 0.0,
                          runSpacing: 0.0,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: List.generate(index.length, (indexIndex) {
                            final indexItem = index[indexIndex];
                            return Icon(
                              Icons.park_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            );
                          }),
                        );
                      },
                    ),
                  ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
              child: Builder(
                builder: (context) {
                  final empty = functions
                      .generateEmptyList(widget!.numbers!.last)
                      .toList();

                  return Wrap(
                    spacing: 0.0,
                    runSpacing: 0.0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: List.generate(empty.length, (emptyIndex) {
                      final emptyItem = empty[emptyIndex];
                      return Icon(
                        Icons.park_rounded,
                        color: (emptyIndex < widget!.answer) &&
                                (widget!.answer > 0)
                            ? FlutterFlowTheme.of(context).tertiary
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      );
                    }),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
