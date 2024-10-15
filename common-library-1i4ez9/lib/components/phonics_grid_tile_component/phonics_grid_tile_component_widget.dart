import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'phonics_grid_tile_component_model.dart';
export 'phonics_grid_tile_component_model.dart';

class PhonicsGridTileComponentWidget extends StatefulWidget {
  const PhonicsGridTileComponentWidget({
    super.key,
    required this.phonic,
  });

  final PhonicStruct? phonic;

  @override
  State<PhonicsGridTileComponentWidget> createState() =>
      _PhonicsGridTileComponentWidgetState();
}

class _PhonicsGridTileComponentWidgetState
    extends State<PhonicsGridTileComponentWidget> {
  late PhonicsGridTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhonicsGridTileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          'PhonicWordsScreen',
          queryParameters: {
            'phonic': serializeParam(
              widget!.phonic,
              ParamType.DataStruct,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  functions.getPhonicImagePath(widget!.phonic!.key),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.black,
                  borderRadius: 8.0,
                  borderWidth: 2.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  icon: Icon(
                    Icons.volume_up_rounded,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    _model.soundPlayer ??= AudioPlayer();
                    if (_model.soundPlayer!.playing) {
                      await _model.soundPlayer!.stop();
                    }
                    _model.soundPlayer!.setVolume(1.0);
                    _model.soundPlayer!
                        .setUrl(
                            functions.getPhonicAudioPath(widget!.phonic!.key))
                        .then((_) => _model.soundPlayer!.play());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
