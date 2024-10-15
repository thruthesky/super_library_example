import '/components/images/home_work_a_i_image_component/home_work_a_i_image_component_widget.dart';
import '/components/menu_list_tile_component/menu_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'menu_homework_a_i_content_component_widget.dart'
    show MenuHomeworkAIContentComponentWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuHomeworkAIContentComponentModel
    extends FlutterFlowModel<MenuHomeworkAIContentComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for HomeWorkAIImageComponent component.
  late HomeWorkAIImageComponentModel homeWorkAIImageComponentModel;
  // Model for MenuListTileComponent component.
  late MenuListTileComponentModel menuListTileComponentModel;

  @override
  void initState(BuildContext context) {
    homeWorkAIImageComponentModel =
        createModel(context, () => HomeWorkAIImageComponentModel());
    menuListTileComponentModel =
        createModel(context, () => MenuListTileComponentModel());
  }

  @override
  void dispose() {
    homeWorkAIImageComponentModel.dispose();
    menuListTileComponentModel.dispose();
  }
}
