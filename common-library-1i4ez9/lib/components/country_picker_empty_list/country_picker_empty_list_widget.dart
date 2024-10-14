import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'country_picker_empty_list_model.dart';
export 'country_picker_empty_list_model.dart';

class CountryPickerEmptyListWidget extends StatefulWidget {
  const CountryPickerEmptyListWidget({
    super.key,
    required this.noSearchResult,
  });

  final String? noSearchResult;

  @override
  State<CountryPickerEmptyListWidget> createState() =>
      _CountryPickerEmptyListWidgetState();
}

class _CountryPickerEmptyListWidgetState
    extends State<CountryPickerEmptyListWidget> {
  late CountryPickerEmptyListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountryPickerEmptyListModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Text(
          valueOrDefault<String>(
            widget!.noSearchResult,
            'No country found',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
        ),
      ),
    );
  }
}
