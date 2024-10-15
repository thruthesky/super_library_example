// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FFUserDataStruct extends FFFirebaseStruct {
  FFUserDataStruct({
    String? displayName,
    String? displayNameLowerCase,
    String? photoUrl,
    DateTime? createdAt,
    String? uid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _displayName = displayName,
        _displayNameLowerCase = displayNameLowerCase,
        _photoUrl = photoUrl,
        _createdAt = createdAt,
        _uid = uid,
        super(firestoreUtilData);

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "displayNameLowerCase" field.
  String? _displayNameLowerCase;
  String get displayNameLowerCase => _displayNameLowerCase ?? '';
  set displayNameLowerCase(String? val) => _displayNameLowerCase = val;

  bool hasDisplayNameLowerCase() => _displayNameLowerCase != null;

  // "photoUrl" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  set photoUrl(String? val) => _photoUrl = val;

  bool hasPhotoUrl() => _photoUrl != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  set uid(String? val) => _uid = val;

  bool hasUid() => _uid != null;

  static FFUserDataStruct fromMap(Map<String, dynamic> data) =>
      FFUserDataStruct(
        displayName: data['displayName'] as String?,
        displayNameLowerCase: data['displayNameLowerCase'] as String?,
        photoUrl: data['photoUrl'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        uid: data['uid'] as String?,
      );

  static FFUserDataStruct? maybeFromMap(dynamic data) => data is Map
      ? FFUserDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'displayName': _displayName,
        'displayNameLowerCase': _displayNameLowerCase,
        'photoUrl': _photoUrl,
        'createdAt': _createdAt,
        'uid': _uid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'displayName': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'displayNameLowerCase': serializeParam(
          _displayNameLowerCase,
          ParamType.String,
        ),
        'photoUrl': serializeParam(
          _photoUrl,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'uid': serializeParam(
          _uid,
          ParamType.String,
        ),
      }.withoutNulls;

  static FFUserDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FFUserDataStruct(
        displayName: deserializeParam(
          data['displayName'],
          ParamType.String,
          false,
        ),
        displayNameLowerCase: deserializeParam(
          data['displayNameLowerCase'],
          ParamType.String,
          false,
        ),
        photoUrl: deserializeParam(
          data['photoUrl'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        uid: deserializeParam(
          data['uid'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FFUserDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FFUserDataStruct &&
        displayName == other.displayName &&
        displayNameLowerCase == other.displayNameLowerCase &&
        photoUrl == other.photoUrl &&
        createdAt == other.createdAt &&
        uid == other.uid;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([displayName, displayNameLowerCase, photoUrl, createdAt, uid]);
}

FFUserDataStruct createFFUserDataStruct({
  String? displayName,
  String? displayNameLowerCase,
  String? photoUrl,
  DateTime? createdAt,
  String? uid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FFUserDataStruct(
      displayName: displayName,
      displayNameLowerCase: displayNameLowerCase,
      photoUrl: photoUrl,
      createdAt: createdAt,
      uid: uid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FFUserDataStruct? updateFFUserDataStruct(
  FFUserDataStruct? fFUserData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fFUserData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFFUserDataStructData(
  Map<String, dynamic> firestoreData,
  FFUserDataStruct? fFUserData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fFUserData == null) {
    return;
  }
  if (fFUserData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fFUserData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fFUserDataData = getFFUserDataFirestoreData(fFUserData, forFieldValue);
  final nestedData = fFUserDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fFUserData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFFUserDataFirestoreData(
  FFUserDataStruct? fFUserData, [
  bool forFieldValue = false,
]) {
  if (fFUserData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fFUserData.toMap());

  // Add any Firestore field values
  fFUserData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFFUserDataListFirestoreData(
  List<FFUserDataStruct>? fFUserDatas,
) =>
    fFUserDatas?.map((e) => getFFUserDataFirestoreData(e, true)).toList() ?? [];
