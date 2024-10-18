import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'circular_progress_indicator_screen_model.dart';
export 'circular_progress_indicator_screen_model.dart';

class CircularProgressIndicatorScreenWidget extends StatefulWidget {
  const CircularProgressIndicatorScreenWidget({super.key});

  @override
  State<CircularProgressIndicatorScreenWidget> createState() =>
      _CircularProgressIndicatorScreenWidgetState();
}

class _CircularProgressIndicatorScreenWidgetState
    extends State<CircularProgressIndicatorScreenWidget> {
  late CircularProgressIndicatorScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CircularProgressIndicatorScreenModel());

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
          automaticallyImplyLeading: false,
          title: Text(
            'CircularProgressIndicator',
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
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Unfortunately, there is no CircularProgressIndicator in Flutterflow. Use CommonCircularProgressIndicator to display an indicator.',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: custom_widgets.CommonCircularProgressIndicator(
                    width: 60.0,
                    height: 60.0,
                    adaptive: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: custom_widgets.CommonCircularProgressIndicator(
                    width: 60.0,
                    height: 60.0,
                    adaptive: true,
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
