import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_grid_tile_component_model.dart';
export 'home_grid_tile_component_model.dart';

class HomeGridTileComponentWidget extends StatefulWidget {
  const HomeGridTileComponentWidget({
    super.key,
    required this.imageBuilder,
    required this.label,
  });

  final Widget Function()? imageBuilder;
  final String? label;

  @override
  State<HomeGridTileComponentWidget> createState() =>
      _HomeGridTileComponentWidgetState();
}

class _HomeGridTileComponentWidgetState
    extends State<HomeGridTileComponentWidget> {
  late HomeGridTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeGridTileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primaryText,
                width: 1.4,
              ),
            ),
            child: Builder(builder: (_) {
              return widget.imageBuilder!();
            }),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Text(
            widget!.label!,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
