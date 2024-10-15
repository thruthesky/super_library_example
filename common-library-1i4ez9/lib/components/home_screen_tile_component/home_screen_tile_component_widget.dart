import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen_tile_component_model.dart';
export 'home_screen_tile_component_model.dart';

class HomeScreenTileComponentWidget extends StatefulWidget {
  const HomeScreenTileComponentWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageBuilder,
  });

  final String? title;
  final String? subtitle;
  final Widget Function()? imageBuilder;

  @override
  State<HomeScreenTileComponentWidget> createState() =>
      _HomeScreenTileComponentWidgetState();
}

class _HomeScreenTileComponentWidgetState
    extends State<HomeScreenTileComponentWidget> {
  late HomeScreenTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenTileComponentModel());

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
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Builder(builder: (_) {
              return widget.imageBuilder!();
            }),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget!.title!,
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter Tight',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      widget!.subtitle!,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Inter',
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
