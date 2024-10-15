import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'state_edit_screen_widget.dart' show StateEditScreenWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StateEditScreenModel extends FlutterFlowModel<StateEditScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for stateMessageTextField widget.
  FocusNode? stateMessageTextFieldFocusNode;
  TextEditingController? stateMessageTextFieldTextController;
  String? Function(BuildContext, String?)?
      stateMessageTextFieldTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    stateMessageTextFieldFocusNode?.dispose();
    stateMessageTextFieldTextController?.dispose();
  }
}
