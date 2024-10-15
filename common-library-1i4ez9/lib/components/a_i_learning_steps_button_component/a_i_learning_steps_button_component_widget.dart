import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'a_i_learning_steps_button_component_model.dart';
export 'a_i_learning_steps_button_component_model.dart';

class AILearningStepsButtonComponentWidget extends StatefulWidget {
  const AILearningStepsButtonComponentWidget({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  State<AILearningStepsButtonComponentWidget> createState() =>
      _AILearningStepsButtonComponentWidgetState();
}

class _AILearningStepsButtonComponentWidgetState
    extends State<AILearningStepsButtonComponentWidget> {
  late AILearningStepsButtonComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AILearningStepsButtonComponentModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(80.0),
        border: Border.all(
          color: Color(0xFFFA462E),
          width: 1.8,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 10.0),
        child: Text(
          widget!.title!,
          style: FlutterFlowTheme.of(context).labelSmall.override(
                fontFamily: 'Inter',
                color: Color(0xFFFA462E),
                letterSpacing: 0.0,
              ),
        ),
      ),
    );
  }
}
