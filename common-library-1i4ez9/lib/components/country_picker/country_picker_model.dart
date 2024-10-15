import '/components/country_picker_empty_list/country_picker_empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'country_picker_widget.dart' show CountryPickerWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CountryPickerModel extends FlutterFlowModel<CountryPickerWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for countryName widget.
  FocusNode? countryNameFocusNode;
  TextEditingController? countryNameTextController;
  String? Function(BuildContext, String?)? countryNameTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    countryNameFocusNode?.dispose();
    countryNameTextController?.dispose();
  }
}
