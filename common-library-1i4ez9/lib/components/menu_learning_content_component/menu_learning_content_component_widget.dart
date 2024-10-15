import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_learning_content_component_model.dart';
export 'menu_learning_content_component_model.dart';

class MenuLearningContentComponentWidget extends StatefulWidget {
  const MenuLearningContentComponentWidget({super.key});

  @override
  State<MenuLearningContentComponentWidget> createState() =>
      _MenuLearningContentComponentWidgetState();
}

class _MenuLearningContentComponentWidgetState
    extends State<MenuLearningContentComponentWidget> {
  late MenuLearningContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuLearningContentComponentModel());

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
                context.pushNamed('AILearningScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel1,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.smart_toy_rounded,
                    size: 24.0,
                  ),
                  title: 'AI Learning',
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
                context.pushNamed('LearningScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.abc_rounded,
                    size: 24.0,
                  ),
                  title: 'English Learning',
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
                context.pushNamed(
                  'YoutubeListScreen',
                  queryParameters: {
                    'title': serializeParam(
                      'TED Talks - KIDS',
                      ParamType.String,
                    ),
                    'youtubes': serializeParam(
                      functions.getTedTalksYoutubes(),
                      ParamType.DataStruct,
                      isList: true,
                    ),
                  }.withoutNulls,
                );
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel3,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.record_voice_over_rounded,
                    size: 24.0,
                  ),
                  title: 'TED Talks - KIDS',
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
                context.pushNamed('MathLearningScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel4,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.calculate_rounded,
                  ),
                  title: 'Math Learning',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
