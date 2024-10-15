import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:common_library_1i4ez9/flutter_flow/flutter_flow_util.dart'
    as common_library_1i4ez9_util show wrapWithModel, createModel;
import 'phone_sign_in_screen_widget.dart' show PhoneSignInScreenWidget;
import 'package:common_library_1i4ez9/components/country_dial_code_picker/country_dial_code_picker_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhoneSignInScreenModel extends FlutterFlowModel<PhoneSignInScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CountryDialCodePicker component.
  late CountryDialCodePickerModel countryDialCodePickerModel;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {
    countryDialCodePickerModel = common_library_1i4ez9_util.createModel(
        context, () => CountryDialCodePickerModel());
  }

  @override
  void dispose() {
    countryDialCodePickerModel.dispose();
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
