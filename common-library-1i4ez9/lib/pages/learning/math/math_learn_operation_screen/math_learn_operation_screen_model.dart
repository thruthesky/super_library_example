import '/components/math_learning_icons_component/math_learning_icons_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'math_learn_operation_screen_widget.dart'
    show MathLearnOperationScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MathLearnOperationScreenModel
    extends FlutterFlowModel<MathLearnOperationScreenWidget> {
  ///  Local state fields for this page.

  int? currentQuestionNumber = 0;

  bool? isCorrectAnswer;

  int? correctAnswer;

  List<int> correctAnswers = [];
  void addToCorrectAnswers(int item) => correctAnswers.add(item);
  void removeFromCorrectAnswers(int item) => correctAnswers.remove(item);
  void removeAtIndexFromCorrectAnswers(int index) =>
      correctAnswers.removeAt(index);
  void insertAtIndexInCorrectAnswers(int index, int item) =>
      correctAnswers.insert(index, item);
  void updateCorrectAnswersAtIndex(int index, Function(int) updateFn) =>
      correctAnswers[index] = updateFn(correctAnswers[index]);

  ///  State fields for stateful widgets in this page.

  // Model for MathLearningIconsComponent component.
  late MathLearningIconsComponentModel mathLearningIconsComponentModel;
  // State field(s) for answerTextField widget.
  FocusNode? answerTextFieldFocusNode;
  TextEditingController? answerTextFieldTextController;
  String? Function(BuildContext, String?)?
      answerTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    mathLearningIconsComponentModel =
        createModel(context, () => MathLearningIconsComponentModel());
  }

  @override
  void dispose() {
    mathLearningIconsComponentModel.dispose();
    answerTextFieldFocusNode?.dispose();
    answerTextFieldTextController?.dispose();
  }
}
