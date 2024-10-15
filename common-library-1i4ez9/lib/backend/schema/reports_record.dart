import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReportsRecord extends FirestoreRecord {
  ReportsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  bool hasReason() => _reason != null;

  // "summary" field.
  String? _summary;
  String get summary => _summary ?? '';
  bool hasSummary() => _summary != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "reportee" field.
  String? _reportee;
  String get reportee => _reportee ?? '';
  bool hasReportee() => _reportee != null;

  // "reporter" field.
  String? _reporter;
  String get reporter => _reporter ?? '';
  bool hasReporter() => _reporter != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _reason = snapshotData['reason'] as String?;
    _summary = snapshotData['summary'] as String?;
    _id = snapshotData['id'] as String?;
    _reportee = snapshotData['reportee'] as String?;
    _reporter = snapshotData['reporter'] as String?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reports');

  static Stream<ReportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReportsRecord.fromSnapshot(s));

  static Future<ReportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReportsRecord.fromSnapshot(s));

  static ReportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReportsRecordData({
  DateTime? createdAt,
  String? reason,
  String? summary,
  String? id,
  String? reportee,
  String? reporter,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
      'reason': reason,
      'summary': summary,
      'id': id,
      'reportee': reportee,
      'reporter': reporter,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReportsRecordDocumentEquality implements Equality<ReportsRecord> {
  const ReportsRecordDocumentEquality();

  @override
  bool equals(ReportsRecord? e1, ReportsRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.reason == e2?.reason &&
        e1?.summary == e2?.summary &&
        e1?.id == e2?.id &&
        e1?.reportee == e2?.reportee &&
        e1?.reporter == e2?.reporter &&
        e1?.type == e2?.type;
  }

  @override
  int hash(ReportsRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.reason,
        e?.summary,
        e?.id,
        e?.reportee,
        e?.reporter,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is ReportsRecord;
}
