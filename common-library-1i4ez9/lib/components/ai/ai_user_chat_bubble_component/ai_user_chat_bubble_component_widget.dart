import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ai_user_chat_bubble_component_model.dart';
export 'ai_user_chat_bubble_component_model.dart';

class AiUserChatBubbleComponentWidget extends StatefulWidget {
  const AiUserChatBubbleComponentWidget({
    super.key,
    this.createdAt,
    this.prompt,
  });

  final DateTime? createdAt;
  final String? prompt;

  @override
  State<AiUserChatBubbleComponentWidget> createState() =>
      _AiUserChatBubbleComponentWidgetState();
}

class _AiUserChatBubbleComponentWidgetState
    extends State<AiUserChatBubbleComponentWidget> {
  late AiUserChatBubbleComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AiUserChatBubbleComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 4.0),
          child: Text(
            dateTimeFormat(
              "relative",
              widget!.createdAt,
              locale: FFLocalizations.of(context).languageCode,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: Color(0xFF9EADB6),
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8C428),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  width: 1.4,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget!.prompt!,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
