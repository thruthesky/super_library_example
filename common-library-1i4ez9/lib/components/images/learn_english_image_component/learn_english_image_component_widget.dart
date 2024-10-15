import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'learn_english_image_component_model.dart';
export 'learn_english_image_component_model.dart';

class LearnEnglishImageComponentWidget extends StatefulWidget {
  const LearnEnglishImageComponentWidget({
    super.key,
    double? height,
    double? width,
  })  : this.height = height ?? 100.0,
        this.width = width ?? 100.0;

  final double height;
  final double width;

  @override
  State<LearnEnglishImageComponentWidget> createState() =>
      _LearnEnglishImageComponentWidgetState();
}

class _LearnEnglishImageComponentWidgetState
    extends State<LearnEnglishImageComponentWidget> {
  late LearnEnglishImageComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LearnEnglishImageComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/learn_english.webp',
        width: widget!.width,
        height: widget!.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
