import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'safe_bottom_area_screen_model.dart';
export 'safe_bottom_area_screen_model.dart';

class SafeBottomAreaScreenWidget extends StatefulWidget {
  const SafeBottomAreaScreenWidget({super.key});

  @override
  State<SafeBottomAreaScreenWidget> createState() =>
      _SafeBottomAreaScreenWidgetState();
}

class _SafeBottomAreaScreenWidgetState
    extends State<SafeBottomAreaScreenWidget> {
  late SafeBottomAreaScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SafeBottomAreaScreenModel());

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
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            'SafeBottomArea Screen',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: MarkdownBody(
                    data:
                        '''# SafeBottomArea\n\n## Why Use SafeBottomArea?\n\nThe `SafeBottomArea` widget adds padding to the bottom of the screen when the `SafeArea` does not apply. This is useful for devices without a system status bar.\n\n## How It Works\n\n- **With System Status Bar**: Uses `SafeArea` to add padding at the bottom.\n- **Without System Status Bar**: Adds custom padding at the bottom.\n\n## Parameters\n\n- **height**: The height of the padding. Defaults to 16 if not provided.\n\n## Usage\n\nUse this widget if:\n\n- You have a custom bottom navigation bar and need to add padding at the bottom.\n- On devices without a status bar, there is no space at the bottom of the navigation bar. This widget ensures the navigation bar has some padding at the bottom.\n- Even with `SafeArea` enabled, your custom navigation bar might not have enough space at the bottom. This widget adds the necessary padding to make it look good.''',
                    selectable: true,
                    onTapLink: (_, url, __) => launchURL(url!),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 16.0, 24.0, 16.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.favorite_border_sharp,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              Text(
                                'Heart',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 16.0, 24.0, 16.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.two_wheeler,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              Text(
                                'Bike',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 16.0, 24.0, 16.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.redeem,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              Text(
                                'Gift',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  custom_widgets.SafeBottomArea(
                    width: double.infinity,
                    height: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
