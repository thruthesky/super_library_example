import '/components/country_picker/country_picker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'country_dial_code_picker_model.dart';
export 'country_dial_code_picker_model.dart';

class CountryDialCodePickerWidget extends StatefulWidget {
  /// Choose dial code for a country
  const CountryDialCodePickerWidget({
    super.key,
    required this.title,
    required this.description,
    required this.searchTitle,
    required this.inputCountryNameHint,
    String? noSearchResult,
    this.favorites,
  }) : this.noSearchResult = noSearchResult ?? '';

  final String? title;
  final String? description;
  final String? searchTitle;
  final String? inputCountryNameHint;
  final String noSearchResult;
  final List<String>? favorites;

  @override
  State<CountryDialCodePickerWidget> createState() =>
      _CountryDialCodePickerWidgetState();
}

class _CountryDialCodePickerWidgetState
    extends State<CountryDialCodePickerWidget> {
  late CountryDialCodePickerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountryDialCodePickerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Color(0x00000000),
          enableDrag: false,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: CountryPickerWidget(
                title: widget!.searchTitle!,
                inputCountryNameHint: widget!.inputCountryNameHint!,
                favorites: widget!.favorites,
                noSearchResult: widget!.noSearchResult,
                onSelect: (country) async {
                  _model.selectedCountry = country;
                  _model.updatePage(() {});
                },
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      },
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color(0x3357636C),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget!.title,
                    'Select country',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: _model.selectedCountry != null ? 10.0 : 14.0,
                        letterSpacing: 0.0,
                      ),
                ),
                if (valueOrDefault<bool>(
                  _model.selectedCountry == null,
                  false,
                ))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget!.description,
                        'Select your country first',
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter Tight',
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                if (_model.selectedCountry != null)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  _model.selectedCountry,
                                  r'''$.flag''',
                                )?.toString(),
                                '[~]',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                _model.selectedCountry,
                                r'''$.dial_code''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                getJsonField(
                                  _model.selectedCountry,
                                  r'''$.name''',
                                ).toString(),
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
