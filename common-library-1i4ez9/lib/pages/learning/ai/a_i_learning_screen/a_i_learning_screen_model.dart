import '/components/a_i_learning_header_component/a_i_learning_header_component_widget.dart';
import '/components/a_i_learning_steps_button_component/a_i_learning_steps_button_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'a_i_learning_screen_widget.dart' show AILearningScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AILearningScreenModel extends FlutterFlowModel<AILearningScreenWidget> {
  ///  Local state fields for this page.

  int step = 0;

  ///  State fields for stateful widgets in this page.

  // Model for AILearningHeaderComponent component.
  late AILearningHeaderComponentModel aILearningHeaderComponentModel;
  // Model for AILearningStepsButtonComponent component.
  late AILearningStepsButtonComponentModel aILearningStepsButtonComponentModel1;
  // Model for AILearningStepsButtonComponent component.
  late AILearningStepsButtonComponentModel aILearningStepsButtonComponentModel2;
  // Model for AILearningStepsButtonComponent component.
  late AILearningStepsButtonComponentModel aILearningStepsButtonComponentModel3;

  @override
  void initState(BuildContext context) {
    aILearningHeaderComponentModel =
        createModel(context, () => AILearningHeaderComponentModel());
    aILearningStepsButtonComponentModel1 =
        createModel(context, () => AILearningStepsButtonComponentModel());
    aILearningStepsButtonComponentModel2 =
        createModel(context, () => AILearningStepsButtonComponentModel());
    aILearningStepsButtonComponentModel3 =
        createModel(context, () => AILearningStepsButtonComponentModel());
  }

  @override
  void dispose() {
    aILearningHeaderComponentModel.dispose();
    aILearningStepsButtonComponentModel1.dispose();
    aILearningStepsButtonComponentModel2.dispose();
    aILearningStepsButtonComponentModel3.dispose();
  }
}
