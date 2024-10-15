import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/user_tile_component/user_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:super_library_5mglde/custom_code/widgets/index.dart'
    as super_library_5mglde_custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_list_screen_model.dart';
export 'user_list_screen_model.dart';

class UserListScreenWidget extends StatefulWidget {
  const UserListScreenWidget({
    super.key,
    required this.type,
  });

  final String? type;

  @override
  State<UserListScreenWidget> createState() => _UserListScreenWidgetState();
}

class _UserListScreenWidgetState extends State<UserListScreenWidget> {
  late UserListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListScreenModel());

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
              'eihes2v1' /* UsersList */,
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
          child: Builder(
            builder: (context) {
              if (widget!.type == 'rtdb') {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: super_library_5mglde_custom_widgets.UserListView(
                    width: double.infinity,
                    height: double.infinity,
                    horizontalScroll: false,
                    reverse: false,
                    onTap: (userId) async {},
                  ),
                );
              } else {
                return FutureBuilder<List<UsersRecord>>(
                  future: queryUsersRecordOnce(
                    queryBuilder: (usersRecord) =>
                        usersRecord.orderBy('created_time'),
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
                    List<UsersRecord> listViewUsersRecordList = snapshot.data!
                        .where((u) => u.uid != currentUserUid)
                        .toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewUsersRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewUsersRecord =
                            listViewUsersRecordList[listViewIndex];
                        return Visibility(
                          visible: listViewUsersRecord.hasCreatedTime(),
                          child: wrapWithModel(
                            model: _model.userTileComponentModels.getModel(
                              listViewUsersRecord.uid,
                              listViewIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: UserTileComponentWidget(
                              key: Key(
                                'Key11w_${listViewUsersRecord.uid}',
                              ),
                              userData: FFUserDataStruct(
                                displayName: listViewUsersRecord.displayName,
                                displayNameLowerCase: 'aa',
                                photoUrl: listViewUsersRecord.photoUrl,
                                createdAt: listViewUsersRecord.createdTime,
                                uid: listViewUsersRecord.uid,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
