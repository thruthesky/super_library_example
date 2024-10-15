import '/components/menu_comic_card_component/menu_comic_card_component_widget.dart';
import '/components/menu_debug_content_component/menu_debug_content_component_widget.dart';
import '/components/menu_homework_a_i_content_component/menu_homework_a_i_content_component_widget.dart';
import '/components/menu_learning_content_component/menu_learning_content_component_widget.dart';
import '/components/menu_others_content_component/menu_others_content_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'anonymous_menu_screen_widget.dart' show AnonymousMenuScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnonymousMenuScreenModel
    extends FlutterFlowModel<AnonymousMenuScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MenuComicCardComponent component.
  late MenuComicCardComponentModel menuComicCardComponentModel1;
  // Model for MenuComicCardComponent component.
  late MenuComicCardComponentModel menuComicCardComponentModel2;
  // Model for MenuComicCardComponent component.
  late MenuComicCardComponentModel menuComicCardComponentModel3;
  // Model for MenuComicCardComponent component.
  late MenuComicCardComponentModel menuComicCardComponentModel4;

  @override
  void initState(BuildContext context) {
    menuComicCardComponentModel1 =
        createModel(context, () => MenuComicCardComponentModel());
    menuComicCardComponentModel2 =
        createModel(context, () => MenuComicCardComponentModel());
    menuComicCardComponentModel3 =
        createModel(context, () => MenuComicCardComponentModel());
    menuComicCardComponentModel4 =
        createModel(context, () => MenuComicCardComponentModel());
  }

  @override
  void dispose() {
    menuComicCardComponentModel1.dispose();
    menuComicCardComponentModel2.dispose();
    menuComicCardComponentModel3.dispose();
    menuComicCardComponentModel4.dispose();
  }
}
