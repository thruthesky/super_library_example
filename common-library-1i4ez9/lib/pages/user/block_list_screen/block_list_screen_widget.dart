import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/blocked_user_tile_component/blocked_user_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'block_list_screen_model.dart';
export 'block_list_screen_model.dart';

class BlockListScreenWidget extends StatefulWidget {
  const BlockListScreenWidget({super.key});

  @override
  State<BlockListScreenWidget> createState() => _BlockListScreenWidgetState();
}

class _BlockListScreenWidgetState extends State<BlockListScreenWidget> {
  late BlockListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlockListScreenModel());

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
              'ubfajokd' /* Blocked Users */,
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
            child: AuthUserStreamWidget(
              builder: (context) => Builder(
                builder: (context) {
                  final uid =
                      (currentUserDocument?.blockedUsers?.toList() ?? [])
                          .toList();

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: uid.length,
                    separatorBuilder: (_, __) => SizedBox(height: 24.0),
                    itemBuilder: (context, uidIndex) {
                      final uidItem = uid[uidIndex];
                      return FutureBuilder<List<UsersRecord>>(
                        future: queryUsersRecordOnce(
                          queryBuilder: (usersRecord) => usersRecord
                              .where(
                                'uid',
                                isEqualTo: uidItem,
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
                              blockedUserTileComponentUsersRecordList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final blockedUserTileComponentUsersRecord =
                              blockedUserTileComponentUsersRecordList.isNotEmpty
                                  ? blockedUserTileComponentUsersRecordList
                                      .first
                                  : null;

                          return wrapWithModel(
                            model:
                                _model.blockedUserTileComponentModels.getModel(
                              'block${uidItem}',
                              uidIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: BlockedUserTileComponentWidget(
                              key: Key(
                                'Key2zy_${'block${uidItem}'}',
                              ),
                              userDocument:
                                  blockedUserTileComponentUsersRecord!,
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
      ),
    );
  }
}
