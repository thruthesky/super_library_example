import '/backend/schema/structs/index.dart';
import '/components/phonics_grid_tile_component/phonics_grid_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'phonics_screen_model.dart';
export 'phonics_screen_model.dart';

class PhonicsScreenWidget extends StatefulWidget {
  const PhonicsScreenWidget({super.key});

  @override
  State<PhonicsScreenWidget> createState() => _PhonicsScreenWidgetState();
}

class _PhonicsScreenWidgetState extends State<PhonicsScreenWidget> {
  late PhonicsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhonicsScreenModel());

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
            FFLocalizations.of(context).getText(
              'gbxn10df' /* Phonics */,
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Builder(
              builder: (context) {
                final phonic = functions.getPhonics().toList();

                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.9,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: phonic.length,
                  itemBuilder: (context, phonicIndex) {
                    final phonicItem = phonic[phonicIndex];
                    return wrapWithModel(
                      model: _model.phonicsGridTileComponentModels.getModel(
                        phonicItem.key,
                        phonicIndex,
                      ),
                      updateCallback: () => safeSetState(() {}),
                      child: PhonicsGridTileComponentWidget(
                        key: Key(
                          'Keyzae_${phonicItem.key}',
                        ),
                        phonic: phonicItem,
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
