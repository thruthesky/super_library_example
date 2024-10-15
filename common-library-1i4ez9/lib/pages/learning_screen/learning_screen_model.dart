import '/components/learning_grid_tile_component/learning_grid_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'learning_screen_widget.dart' show LearningScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LearningScreenModel extends FlutterFlowModel<LearningScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for LearningGridTileComponent component.
  late LearningGridTileComponentModel learningGridTileComponentModel1;
  // Model for LearningGridTileComponent component.
  late LearningGridTileComponentModel learningGridTileComponentModel2;
  // Model for LearningGridTileComponent component.
  late LearningGridTileComponentModel learningGridTileComponentModel3;
  // Model for LearningGridTileComponent component.
  late LearningGridTileComponentModel learningGridTileComponentModel4;

  @override
  void initState(BuildContext context) {
    learningGridTileComponentModel1 =
        createModel(context, () => LearningGridTileComponentModel());
    learningGridTileComponentModel2 =
        createModel(context, () => LearningGridTileComponentModel());
    learningGridTileComponentModel3 =
        createModel(context, () => LearningGridTileComponentModel());
    learningGridTileComponentModel4 =
        createModel(context, () => LearningGridTileComponentModel());
  }

  @override
  void dispose() {
    learningGridTileComponentModel1.dispose();
    learningGridTileComponentModel2.dispose();
    learningGridTileComponentModel3.dispose();
    learningGridTileComponentModel4.dispose();
  }
}
