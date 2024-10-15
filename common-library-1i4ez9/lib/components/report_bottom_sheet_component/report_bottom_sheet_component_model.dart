import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'report_bottom_sheet_component_widget.dart'
    show ReportBottomSheetComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportBottomSheetComponentModel
    extends FlutterFlowModel<ReportBottomSheetComponentWidget> {
  ///  Local state fields for this component.

  dynamic data;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for reasonTextField widget.
  FocusNode? reasonTextFieldFocusNode;
  TextEditingController? reasonTextFieldTextController;
  String? Function(BuildContext, String?)?
      reasonTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reasonTextFieldFocusNode?.dispose();
    reasonTextFieldTextController?.dispose();
  }
}
