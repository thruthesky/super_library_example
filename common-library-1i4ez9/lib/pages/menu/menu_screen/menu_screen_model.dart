import '/auth/firebase_auth/auth_util.dart';
import '/components/menu_account_content_component/menu_account_content_component_widget.dart';
import '/components/menu_comic_card_component/menu_comic_card_component_widget.dart';
import '/components/menu_debug_content_component/menu_debug_content_component_widget.dart';
import '/components/menu_homework_a_i_content_component/menu_homework_a_i_content_component_widget.dart';
import '/components/menu_learning_content_component/menu_learning_content_component_widget.dart';
import '/components/menu_member_content_component/menu_member_content_component_widget.dart';
import '/components/menu_others_content_component/menu_others_content_component_widget.dart';
import '/components/user_avatar_component/user_avatar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'menu_screen_widget.dart' show MenuScreenWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuScreenModel extends FlutterFlowModel<MenuScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isAnonymous] action in MenuScreen widget.
  bool? isAnonymous;
  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for MenuDebugComponent.
  late MenuComicCardComponentModel menuDebugComponentModel;
  // Model for MenuMemberComponent.
  late MenuComicCardComponentModel menuMemberComponentModel;
  // Model for MenuLearningComponent.
  late MenuComicCardComponentModel menuLearningComponentModel;
  // Model for MenuHomeworkAIComponent.
  late MenuComicCardComponentModel menuHomeworkAIComponentModel;
  // Model for MenuAccountComponent.
  late MenuComicCardComponentModel menuAccountComponentModel;
  // Model for MenuOthersComponent.
  late MenuComicCardComponentModel menuOthersComponentModel;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel =
        createModel(context, () => UserAvatarComponentModel());
    menuDebugComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
    menuMemberComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
    menuLearningComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
    menuHomeworkAIComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
    menuAccountComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
    menuOthersComponentModel =
        createModel(context, () => MenuComicCardComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel.dispose();
    menuDebugComponentModel.dispose();
    menuMemberComponentModel.dispose();
    menuLearningComponentModel.dispose();
    menuHomeworkAIComponentModel.dispose();
    menuAccountComponentModel.dispose();
    menuOthersComponentModel.dispose();
  }
}
