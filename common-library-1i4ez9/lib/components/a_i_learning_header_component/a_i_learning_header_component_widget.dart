import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'a_i_learning_header_component_model.dart';
export 'a_i_learning_header_component_model.dart';

class AILearningHeaderComponentWidget extends StatefulWidget {
  const AILearningHeaderComponentWidget({super.key});

  @override
  State<AILearningHeaderComponentWidget> createState() =>
      _AILearningHeaderComponentWidgetState();
}

class _AILearningHeaderComponentWidgetState
    extends State<AILearningHeaderComponentWidget> {
  late AILearningHeaderComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AILearningHeaderComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Image.asset(
            'assets/images/ai_learning_title_image.webp',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(36.0, 30.0, 100.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  '3814510o' /* What is AI? */,
                ),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Inter Tight',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 14.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    '36g4kinm' /* SMART BRAIN */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Inter Tight',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'soemrnre' /* for
Robots and Computers */
                    ,
                  ),
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
