import '/backend/schema/structs/index.dart';
import '/components/phonic_example_component/phonic_example_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'phonic_words_screen_widget.dart' show PhonicWordsScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhonicWordsScreenModel extends FlutterFlowModel<PhonicWordsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PhonicExampleComponent component.
  late PhonicExampleComponentModel phonicExampleComponentModel;

  @override
  void initState(BuildContext context) {
    phonicExampleComponentModel =
        createModel(context, () => PhonicExampleComponentModel());
  }

  @override
  void dispose() {
    phonicExampleComponentModel.dispose();
  }
}
