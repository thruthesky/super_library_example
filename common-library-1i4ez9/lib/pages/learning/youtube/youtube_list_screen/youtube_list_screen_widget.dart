import '/backend/schema/structs/index.dart';
import '/components/youtube_thumbnail_list_tile_component/youtube_thumbnail_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'youtube_list_screen_model.dart';
export 'youtube_list_screen_model.dart';

class YoutubeListScreenWidget extends StatefulWidget {
  const YoutubeListScreenWidget({
    super.key,
    required this.title,
    required this.youtubes,
  });

  final String? title;
  final List<YoutubeStruct>? youtubes;

  @override
  State<YoutubeListScreenWidget> createState() =>
      _YoutubeListScreenWidgetState();
}

class _YoutubeListScreenWidgetState extends State<YoutubeListScreenWidget> {
  late YoutubeListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YoutubeListScreenModel());

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
              context.pop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget!.title,
              'Youtube List Screen',
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Inter Tight',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Builder(
              builder: (context) {
                final youtubes = widget!.youtubes!.toList();

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: youtubes.length,
                  separatorBuilder: (_, __) => SizedBox(height: 24.0),
                  itemBuilder: (context, youtubesIndex) {
                    final youtubesItem = youtubes[youtubesIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'YoutubeViewScreen',
                          queryParameters: {
                            'youtube': serializeParam(
                              youtubesItem,
                              ParamType.DataStruct,
                            ),
                            'youtubeList': serializeParam(
                              widget!.youtubes,
                              ParamType.DataStruct,
                              isList: true,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: wrapWithModel(
                        model: _model.youtubeThumbnailListTileComponentModels
                            .getModel(
                          youtubesItem.youtubeId,
                          youtubesIndex,
                        ),
                        updateCallback: () => safeSetState(() {}),
                        child: YoutubeThumbnailListTileComponentWidget(
                          key: Key(
                            'Key4yn_${youtubesItem.youtubeId}',
                          ),
                          youtube: youtubesItem,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
