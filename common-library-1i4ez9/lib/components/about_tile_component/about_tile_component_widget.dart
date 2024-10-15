import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_tile_component_model.dart';
export 'about_tile_component_model.dart';

class AboutTileComponentWidget extends StatefulWidget {
  const AboutTileComponentWidget({super.key});

  @override
  State<AboutTileComponentWidget> createState() =>
      _AboutTileComponentWidgetState();
}

class _AboutTileComponentWidgetState extends State<AboutTileComponentWidget> {
  late AboutTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutTileComponentModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  'TermsAndConditionScreen',
                  queryParameters: {
                    'displayButtons': serializeParam(
                      false,
                      ParamType.bool,
                    ),
                  }.withoutNulls,
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel1,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.document_scanner_rounded,
                  ),
                  title: FFLocalizations.of(context).getText(
                    'jdmj2pwz' /* Terms and Condtions */,
                  ),
                ),
              ),
            ),
            Divider(
              height: 4.0,
              thickness: 1.4,
              color: Color(0x68000000),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed('PrivacyPolicyScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.privacy_tip_rounded,
                    size: 24.0,
                  ),
                  title: 'Privacy Policy',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
