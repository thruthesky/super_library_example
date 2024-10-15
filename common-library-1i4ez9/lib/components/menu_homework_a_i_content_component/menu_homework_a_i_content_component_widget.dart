import '/components/images/home_work_a_i_image_component/home_work_a_i_image_component_widget.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_homework_a_i_content_component_model.dart';
export 'menu_homework_a_i_content_component_model.dart';

class MenuHomeworkAIContentComponentWidget extends StatefulWidget {
  const MenuHomeworkAIContentComponentWidget({super.key});

  @override
  State<MenuHomeworkAIContentComponentWidget> createState() =>
      _MenuHomeworkAIContentComponentWidgetState();
}

class _MenuHomeworkAIContentComponentWidgetState
    extends State<MenuHomeworkAIContentComponentWidget> {
  late MenuHomeworkAIContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHomeworkAIContentComponentModel());

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
                context.pushNamed('HomeworkAiScreen');
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '9l9s2uxg' /* Hello, I'm Homework Assistant.... */,
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.homeWorkAIImageComponentModel,
                    updateCallback: () => safeSetState(() {}),
                    child: HomeWorkAIImageComponentWidget(
                      height: 110.0,
                      width: 110.0,
                    ),
                  ),
                ],
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
                context.pushNamed('AILearningScreen');
              },
              child: wrapWithModel(
                model: _model.menuListTileComponentModel,
                updateCallback: () => safeSetState(() {}),
                child: MenuListTileComponentWidget(
                  icon: Icon(
                    Icons.smart_toy_rounded,
                    size: 24.0,
                  ),
                  title: 'Learn AI',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
