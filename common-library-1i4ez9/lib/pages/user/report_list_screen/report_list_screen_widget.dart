import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/report_list_tile_component/report_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'report_list_screen_model.dart';
export 'report_list_screen_model.dart';

class ReportListScreenWidget extends StatefulWidget {
  const ReportListScreenWidget({super.key});

  @override
  State<ReportListScreenWidget> createState() => _ReportListScreenWidgetState();
}

class _ReportListScreenWidgetState extends State<ReportListScreenWidget> {
  late ReportListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportListScreenModel());

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
              'fmekdvfy' /* Report List Screen */,
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
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: FutureBuilder<List<ReportsRecord>>(
              future: queryReportsRecordOnce(
                queryBuilder: (reportsRecord) => reportsRecord
                    .where(
                      'reporter',
                      isEqualTo: currentUserUid,
                    )
                    .orderBy('createdAt', descending: true),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<ReportsRecord> listViewReportsRecordList = snapshot.data!;

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewReportsRecordList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 24.0),
                  itemBuilder: (context, listViewIndex) {
                    final listViewReportsRecord =
                        listViewReportsRecordList[listViewIndex];
                    return FutureBuilder<List<UsersRecord>>(
                      future: queryUsersRecordOnce(
                        queryBuilder: (usersRecord) => usersRecord
                            .where(
                              'uid',
                              isEqualTo: listViewReportsRecord.reportee,
                            )
                            .orderBy('created_time', descending: true),
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<UsersRecord>
                            reportListTileComponentUsersRecordList =
                            snapshot.data!;
                        // Return an empty Container when the item does not exist.
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final reportListTileComponentUsersRecord =
                            reportListTileComponentUsersRecordList.isNotEmpty
                                ? reportListTileComponentUsersRecordList.first
                                : null;

                        return wrapWithModel(
                          model: _model.reportListTileComponentModels.getModel(
                            listViewReportsRecord.id,
                            listViewIndex,
                          ),
                          updateCallback: () => safeSetState(() {}),
                          child: ReportListTileComponentWidget(
                            key: Key(
                              'Keymmh_${listViewReportsRecord.id}',
                            ),
                            reportDocument: listViewReportsRecord,
                            userDocument: reportListTileComponentUsersRecord!,
                          ),
                        );
                      },
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
