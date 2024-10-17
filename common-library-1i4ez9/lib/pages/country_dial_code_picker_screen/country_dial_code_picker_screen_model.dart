import '/components/country_dial_code_picker/country_dial_code_picker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'country_dial_code_picker_screen_widget.dart'
    show CountryDialCodePickerScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CountryDialCodePickerScreenModel
    extends FlutterFlowModel<CountryDialCodePickerScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CountryDialCodePicker component.
  late CountryDialCodePickerModel countryDialCodePickerModel;

  @override
  void initState(BuildContext context) {
    countryDialCodePickerModel =
        createModel(context, () => CountryDialCodePickerModel());
  }

  @override
  void dispose() {
    countryDialCodePickerModel.dispose();
  }
}
