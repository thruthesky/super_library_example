import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_comic_card_component_model.dart';
export 'menu_comic_card_component_model.dart';

class MenuComicCardComponentWidget extends StatefulWidget {
  const MenuComicCardComponentWidget({
    super.key,
    required this.label,
    required this.child,
  });

  final String? label;
  final Widget Function()? child;

  @override
  State<MenuComicCardComponentWidget> createState() =>
      _MenuComicCardComponentWidgetState();
}

class _MenuComicCardComponentWidgetState
    extends State<MenuComicCardComponentWidget> {
  late MenuComicCardComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuComicCardComponentModel());

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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 8.0),
            child: Text(
              widget!.label!,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primaryText,
                width: FFAppConstants.borderThickness,
              ),
            ),
            child: Builder(builder: (_) {
              return widget.child!();
            }),
          ),
        ],
      ),
    );
  }
}
