import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/home_grid_tile_component/home_grid_tile_component_widget.dart';
import '/components/home_screen_tile_component/home_screen_tile_component_widget.dart';
import '/components/images/a_i_assistant_image_component/a_i_assistant_image_component_widget.dart';
import '/components/images/home_work_a_i_image_component/home_work_a_i_image_component_widget.dart';
import '/components/images/learn_a_i_image_component/learn_a_i_image_component_widget.dart';
import '/components/images/learn_english_image_component/learn_english_image_component_widget.dart';
import '/components/images/learn_math_image_component/learn_math_image_component_widget.dart';
import '/components/images/music_image_component/music_image_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HomeGridTileComponent component.
  late HomeGridTileComponentModel homeGridTileComponentModel1;
  // Model for HomeGridTileComponent component.
  late HomeGridTileComponentModel homeGridTileComponentModel2;
  // Model for HomeGridTileComponent component.
  late HomeGridTileComponentModel homeGridTileComponentModel3;
  // Model for HomeScreenTileComponent component.
  late HomeScreenTileComponentModel homeScreenTileComponentModel1;
  // Model for HomeScreenTileComponent component.
  late HomeScreenTileComponentModel homeScreenTileComponentModel2;
  // Model for HomeScreenTileComponent component.
  late HomeScreenTileComponentModel homeScreenTileComponentModel3;
  // Model for HomeScreenTileComponent component.
  late HomeScreenTileComponentModel homeScreenTileComponentModel4;

  @override
  void initState(BuildContext context) {
    homeGridTileComponentModel1 =
        createModel(context, () => HomeGridTileComponentModel());
    homeGridTileComponentModel2 =
        createModel(context, () => HomeGridTileComponentModel());
    homeGridTileComponentModel3 =
        createModel(context, () => HomeGridTileComponentModel());
    homeScreenTileComponentModel1 =
        createModel(context, () => HomeScreenTileComponentModel());
    homeScreenTileComponentModel2 =
        createModel(context, () => HomeScreenTileComponentModel());
    homeScreenTileComponentModel3 =
        createModel(context, () => HomeScreenTileComponentModel());
    homeScreenTileComponentModel4 =
        createModel(context, () => HomeScreenTileComponentModel());
  }

  @override
  void dispose() {
    homeGridTileComponentModel1.dispose();
    homeGridTileComponentModel2.dispose();
    homeGridTileComponentModel3.dispose();
    homeScreenTileComponentModel1.dispose();
    homeScreenTileComponentModel2.dispose();
    homeScreenTileComponentModel3.dispose();
    homeScreenTileComponentModel4.dispose();
  }
}
