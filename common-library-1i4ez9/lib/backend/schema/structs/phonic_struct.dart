// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PhonicStruct extends FFFirebaseStruct {
  PhonicStruct({
    String? example,
    String? key,
    String? title,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _example = example,
        _key = key,
        _title = title,
        super(firestoreUtilData);

  // "example" field.
  String? _example;
  String get example => _example ?? '';
  set example(String? val) => _example = val;

  bool hasExample() => _example != null;

  // "key" field.
  String? _key;
  String get key => _key ?? '';
  set key(String? val) => _key = val;

  bool hasKey() => _key != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static PhonicStruct fromMap(Map<String, dynamic> data) => PhonicStruct(
        example: data['example'] as String?,
        key: data['key'] as String?,
        title: data['title'] as String?,
      );

  static PhonicStruct? maybeFromMap(dynamic data) =>
      data is Map ? PhonicStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'example': _example,
        'key': _key,
        'title': _title,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'example': serializeParam(
          _example,
          ParamType.String,
        ),
        'key': serializeParam(
          _key,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static PhonicStruct fromSerializableMap(Map<String, dynamic> data) =>
      PhonicStruct(
        example: deserializeParam(
          data['example'],
          ParamType.String,
          false,
        ),
        key: deserializeParam(
          data['key'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PhonicStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PhonicStruct &&
        example == other.example &&
        key == other.key &&
        title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([example, key, title]);
}

PhonicStruct createPhonicStruct({
  String? example,
  String? key,
  String? title,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PhonicStruct(
      example: example,
      key: key,
      title: title,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PhonicStruct? updatePhonicStruct(
  PhonicStruct? phonic, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    phonic
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPhonicStructData(
  Map<String, dynamic> firestoreData,
  PhonicStruct? phonic,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (phonic == null) {
    return;
  }
  if (phonic.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && phonic.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final phonicData = getPhonicFirestoreData(phonic, forFieldValue);
  final nestedData = phonicData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = phonic.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPhonicFirestoreData(
  PhonicStruct? phonic, [
  bool forFieldValue = false,
]) {
  if (phonic == null) {
    return {};
  }
  final firestoreData = mapToFirestore(phonic.toMap());

  // Add any Firestore field values
  phonic.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPhonicListFirestoreData(
  List<PhonicStruct>? phonics,
) =>
    phonics?.map((e) => getPhonicFirestoreData(e, true)).toList() ?? [];
