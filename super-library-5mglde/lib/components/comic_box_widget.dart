import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comic_box_model.dart';
export 'comic_box_model.dart';

class ComicBoxWidget extends StatefulWidget {
  const ComicBoxWidget({
    super.key,
    required this.builder,
  });

  final Widget Function()? builder;

  @override
  State<ComicBoxWidget> createState() => _ComicBoxWidgetState();
}

class _ComicBoxWidgetState extends State<ComicBoxWidget> {
  late ComicBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComicBoxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: Color(0xE857636C),
              width: 1.6,
            ),
          ),
          child: Builder(builder: (_) {
            return widget.builder!();
          }),
        ),
      ),
    );
  }
}
