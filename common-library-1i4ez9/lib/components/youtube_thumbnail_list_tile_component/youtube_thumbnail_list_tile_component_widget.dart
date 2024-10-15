import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'youtube_thumbnail_list_tile_component_model.dart';
export 'youtube_thumbnail_list_tile_component_model.dart';

class YoutubeThumbnailListTileComponentWidget extends StatefulWidget {
  const YoutubeThumbnailListTileComponentWidget({
    super.key,
    required this.youtube,
  });

  final YoutubeStruct? youtube;

  @override
  State<YoutubeThumbnailListTileComponentWidget> createState() =>
      _YoutubeThumbnailListTileComponentWidgetState();
}

class _YoutubeThumbnailListTileComponentWidgetState
    extends State<YoutubeThumbnailListTileComponentWidget> {
  late YoutubeThumbnailListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => YoutubeThumbnailListTileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          child: Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Image.network(
                functions
                    .getYoutubeStandardThumbnail(widget!.youtube?.youtubeId)!,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget!.youtube?.title,
                'Youtube Title',
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Inter Tight',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget!.youtube?.channel,
                'Youtube Channel',
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
