import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_others_content_component_model.dart';
export 'menu_others_content_component_model.dart';

class MenuOthersContentComponentWidget extends StatefulWidget {
  const MenuOthersContentComponentWidget({super.key});

  @override
  State<MenuOthersContentComponentWidget> createState() =>
      _MenuOthersContentComponentWidgetState();
}

class _MenuOthersContentComponentWidgetState
    extends State<MenuOthersContentComponentWidget> {
  late MenuOthersContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuOthersContentComponentModel());

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
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed('AboutScreen');
          },
          child: wrapWithModel(
            model: _model.menuListTileComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: MenuListTileComponentWidget(
              icon: Icon(
                Icons.info_rounded,
                size: 24.0,
              ),
              title: 'About AiCool',
            ),
          ),
        ),
      ),
    );
  }
}
