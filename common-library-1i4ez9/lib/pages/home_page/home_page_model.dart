import '/components/country_dial_code_picker/country_dial_code_picker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String sitePreviewUrl = 'Input URL';

  ///  State fields for stateful widgets in this page.

  // State field(s) for sitePreviewUrl widget.
  FocusNode? sitePreviewUrlFocusNode;
  TextEditingController? sitePreviewUrlTextController;
  String? Function(BuildContext, String?)?
      sitePreviewUrlTextControllerValidator;
  // Model for CountryDialCodePicker component.
  late CountryDialCodePickerModel countryDialCodePickerModel;

  @override
  void initState(BuildContext context) {
    countryDialCodePickerModel =
        createModel(context, () => CountryDialCodePickerModel());
  }

  @override
  void dispose() {
    sitePreviewUrlFocusNode?.dispose();
    sitePreviewUrlTextController?.dispose();

    countryDialCodePickerModel.dispose();
  }
}
