import '/components/menu_comic_card_component/menu_comic_card_component_widget.dart';
import '/components/menu_debug_content_component/menu_debug_content_component_widget.dart';
import '/components/menu_homework_a_i_content_component/menu_homework_a_i_content_component_widget.dart';
import '/components/menu_learning_content_component/menu_learning_content_component_widget.dart';
import '/components/menu_others_content_component/menu_others_content_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'anonymous_menu_screen_model.dart';
export 'anonymous_menu_screen_model.dart';

class AnonymousMenuScreenWidget extends StatefulWidget {
  const AnonymousMenuScreenWidget({super.key});

  @override
  State<AnonymousMenuScreenWidget> createState() =>
      _AnonymousMenuScreenWidgetState();
}

class _AnonymousMenuScreenWidgetState extends State<AnonymousMenuScreenWidget> {
  late AnonymousMenuScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnonymousMenuScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.goNamed('HomeScreen');
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'mpkkwopb' /* Anonymous */,
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Inter Tight',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(
                      'TermsAndConditionScreen',
                      queryParameters: {
                        'displayButtons': serializeParam(
                          true,
                          ParamType.bool,
                        ),
                      }.withoutNulls,
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'ri1sf2h6' /* Sign In */,
                  ),
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter Tight',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.4,
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (kDebugMode)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                      child: wrapWithModel(
                        model: _model.menuComicCardComponentModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuComicCardComponentWidget(
                          label: 'Debug',
                          child: () => MenuDebugContentComponentWidget(),
                        ),
                      ),
                    ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: wrapWithModel(
                      model: _model.menuComicCardComponentModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: MenuComicCardComponentWidget(
                        label: 'Learning',
                        child: () => MenuLearningContentComponentWidget(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: wrapWithModel(
                      model: _model.menuComicCardComponentModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: MenuComicCardComponentWidget(
                        label: 'Homework Helper AI',
                        child: () => MenuHomeworkAIContentComponentWidget(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: wrapWithModel(
                      model: _model.menuComicCardComponentModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: MenuComicCardComponentWidget(
                        label: 'Others',
                        child: () => MenuOthersContentComponentWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
