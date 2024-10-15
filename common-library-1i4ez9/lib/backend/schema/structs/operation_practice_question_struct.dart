// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OperationPracticeQuestionStruct extends FFFirebaseStruct {
  OperationPracticeQuestionStruct({
    List<int>? numbers,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _numbers = numbers,
        super(firestoreUtilData);

  // "numbers" field.
  List<int>? _numbers;
  List<int> get numbers => _numbers ?? const [];
  set numbers(List<int>? val) => _numbers = val;

  void updateNumbers(Function(List<int>) updateFn) {
    updateFn(_numbers ??= []);
  }

  bool hasNumbers() => _numbers != null;

  static OperationPracticeQuestionStruct fromMap(Map<String, dynamic> data) =>
      OperationPracticeQuestionStruct(
        numbers: getDataList(data['numbers']),
      );

  static OperationPracticeQuestionStruct? maybeFromMap(dynamic data) => data
          is Map
      ? OperationPracticeQuestionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'numbers': _numbers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'numbers': serializeParam(
          _numbers,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static OperationPracticeQuestionStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OperationPracticeQuestionStruct(
        numbers: deserializeParam<int>(
          data['numbers'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'OperationPracticeQuestionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OperationPracticeQuestionStruct &&
        listEquality.equals(numbers, other.numbers);
  }

  @override
  int get hashCode => const ListEquality().hash([numbers]);
}

OperationPracticeQuestionStruct createOperationPracticeQuestionStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OperationPracticeQuestionStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OperationPracticeQuestionStruct? updateOperationPracticeQuestionStruct(
  OperationPracticeQuestionStruct? operationPracticeQuestion, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    operationPracticeQuestion
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOperationPracticeQuestionStructData(
  Map<String, dynamic> firestoreData,
  OperationPracticeQuestionStruct? operationPracticeQuestion,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (operationPracticeQuestion == null) {
    return;
  }
  if (operationPracticeQuestion.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      operationPracticeQuestion.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final operationPracticeQuestionData =
      getOperationPracticeQuestionFirestoreData(
          operationPracticeQuestion, forFieldValue);
  final nestedData =
      operationPracticeQuestionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      operationPracticeQuestion.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOperationPracticeQuestionFirestoreData(
  OperationPracticeQuestionStruct? operationPracticeQuestion, [
  bool forFieldValue = false,
]) {
  if (operationPracticeQuestion == null) {
    return {};
  }
  final firestoreData = mapToFirestore(operationPracticeQuestion.toMap());

  // Add any Firestore field values
  operationPracticeQuestion.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOperationPracticeQuestionListFirestoreData(
  List<OperationPracticeQuestionStruct>? operationPracticeQuestions,
) =>
    operationPracticeQuestions
        ?.map((e) => getOperationPracticeQuestionFirestoreData(e, true))
        .toList() ??
    [];
