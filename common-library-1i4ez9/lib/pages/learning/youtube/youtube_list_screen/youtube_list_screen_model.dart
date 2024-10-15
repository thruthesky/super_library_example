import '/backend/schema/structs/index.dart';
import '/components/youtube_thumbnail_list_tile_component/youtube_thumbnail_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'youtube_list_screen_widget.dart' show YoutubeListScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YoutubeListScreenModel extends FlutterFlowModel<YoutubeListScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for YoutubeThumbnailListTileComponent dynamic component.
  late FlutterFlowDynamicModels<YoutubeThumbnailListTileComponentModel>
      youtubeThumbnailListTileComponentModels;

  @override
  void initState(BuildContext context) {
    youtubeThumbnailListTileComponentModels = FlutterFlowDynamicModels(
        () => YoutubeThumbnailListTileComponentModel());
  }

  @override
  void dispose() {
    youtubeThumbnailListTileComponentModels.dispose();
  }
}
