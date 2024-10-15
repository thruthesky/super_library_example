import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ai_response_chat_bubble_component_model.dart';
export 'ai_response_chat_bubble_component_model.dart';

class AiResponseChatBubbleComponentWidget extends StatefulWidget {
  const AiResponseChatBubbleComponentWidget({
    super.key,
    this.response,
    this.error,
    this.textPreview,
    this.completedAt,
  });

  final String? response;
  final String? error;
  final String? textPreview;
  final DateTime? completedAt;

  @override
  State<AiResponseChatBubbleComponentWidget> createState() =>
      _AiResponseChatBubbleComponentWidgetState();
}

class _AiResponseChatBubbleComponentWidgetState
    extends State<AiResponseChatBubbleComponentWidget> {
  late AiResponseChatBubbleComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AiResponseChatBubbleComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if ((widget!.response == null || widget!.response == '') &&
            (widget!.error == null || widget!.error == '') &&
            (widget!.textPreview == null || widget!.textPreview == '')) {
          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 4.0, 0.0),
                child: Icon(
                  Icons.adb_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      width: 1.4,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((widget!.response != null &&
                                widget!.response != '') ||
                            ((widget!.textPreview != null &&
                                    widget!.textPreview != '') &&
                                (widget!.textPreview != ' ')))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 8.0),
                            child: MarkdownBody(
                              data: (String? response, String? textPreview,
                                      String? error) {
                                return response != null || error != null
                                    ? response!.trim() +
                                        (error!.isNotEmpty
                                            ? '${response.trim().isEmpty ? '' : '\n\n'}${'something went wrong, try again. or try changing your message'}'
                                            : '')
                                    : textPreview ?? ' ';
                              }(widget!.response, widget!.textPreview,
                                  widget!.error),
                              selectable: true,
                              onTapLink: (_, url, __) => launchURL(url!),
                            ),
                          ),
                        if (widget!.completedAt != null)
                          Text(
                            dateTimeFormat(
                              "relative",
                              widget!.completedAt,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF9EADB6),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        if (widget!.textPreview != null &&
                            widget!.textPreview != '')
                          custom_widgets.AdaptiveCircularProgressIndicator(
                            width: 24.0,
                            height: 24.0,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
