import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 's_m_s_verification_screen_widget.dart' show SMSVerificationScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SMSVerificationScreenModel
    extends FlutterFlowModel<SMSVerificationScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for smsCode widget.
  FocusNode? smsCodeFocusNode;
  TextEditingController? smsCodeTextController;
  String? Function(BuildContext, String?)? smsCodeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    smsCodeFocusNode?.dispose();
    smsCodeTextController?.dispose();
  }
}
