import '/backend/schema/structs/index.dart';
import '/components/phonics_grid_tile_component/phonics_grid_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'phonics_screen_widget.dart' show PhonicsScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhonicsScreenModel extends FlutterFlowModel<PhonicsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for PhonicsGridTileComponent dynamic component.
  late FlutterFlowDynamicModels<PhonicsGridTileComponentModel>
      phonicsGridTileComponentModels;

  @override
  void initState(BuildContext context) {
    phonicsGridTileComponentModels =
        FlutterFlowDynamicModels(() => PhonicsGridTileComponentModel());
  }

  @override
  void dispose() {
    phonicsGridTileComponentModels.dispose();
  }
}
