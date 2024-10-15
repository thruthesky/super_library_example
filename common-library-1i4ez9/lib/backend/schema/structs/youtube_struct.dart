// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class YoutubeStruct extends FFFirebaseStruct {
  YoutubeStruct({
    String? title,
    String? channel,
    String? youtubeId,
    int? viewCount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _channel = channel,
        _youtubeId = youtubeId,
        _viewCount = viewCount,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "channel" field.
  String? _channel;
  String get channel => _channel ?? '';
  set channel(String? val) => _channel = val;

  bool hasChannel() => _channel != null;

  // "youtubeId" field.
  String? _youtubeId;
  String get youtubeId => _youtubeId ?? '';
  set youtubeId(String? val) => _youtubeId = val;

  bool hasYoutubeId() => _youtubeId != null;

  // "viewCount" field.
  int? _viewCount;
  int get viewCount => _viewCount ?? 0;
  set viewCount(int? val) => _viewCount = val;

  void incrementViewCount(int amount) => viewCount = viewCount + amount;

  bool hasViewCount() => _viewCount != null;

  static YoutubeStruct fromMap(Map<String, dynamic> data) => YoutubeStruct(
        title: data['title'] as String?,
        channel: data['channel'] as String?,
        youtubeId: data['youtubeId'] as String?,
        viewCount: castToType<int>(data['viewCount']),
      );

  static YoutubeStruct? maybeFromMap(dynamic data) =>
      data is Map ? YoutubeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'channel': _channel,
        'youtubeId': _youtubeId,
        'viewCount': _viewCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'channel': serializeParam(
          _channel,
          ParamType.String,
        ),
        'youtubeId': serializeParam(
          _youtubeId,
          ParamType.String,
        ),
        'viewCount': serializeParam(
          _viewCount,
          ParamType.int,
        ),
      }.withoutNulls;

  static YoutubeStruct fromSerializableMap(Map<String, dynamic> data) =>
      YoutubeStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        channel: deserializeParam(
          data['channel'],
          ParamType.String,
          false,
        ),
        youtubeId: deserializeParam(
          data['youtubeId'],
          ParamType.String,
          false,
        ),
        viewCount: deserializeParam(
          data['viewCount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'YoutubeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is YoutubeStruct &&
        title == other.title &&
        channel == other.channel &&
        youtubeId == other.youtubeId &&
        viewCount == other.viewCount;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, channel, youtubeId, viewCount]);
}

YoutubeStruct createYoutubeStruct({
  String? title,
  String? channel,
  String? youtubeId,
  int? viewCount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    YoutubeStruct(
      title: title,
      channel: channel,
      youtubeId: youtubeId,
      viewCount: viewCount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

YoutubeStruct? updateYoutubeStruct(
  YoutubeStruct? youtube, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    youtube
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addYoutubeStructData(
  Map<String, dynamic> firestoreData,
  YoutubeStruct? youtube,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (youtube == null) {
    return;
  }
  if (youtube.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && youtube.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final youtubeData = getYoutubeFirestoreData(youtube, forFieldValue);
  final nestedData = youtubeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = youtube.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getYoutubeFirestoreData(
  YoutubeStruct? youtube, [
  bool forFieldValue = false,
]) {
  if (youtube == null) {
    return {};
  }
  final firestoreData = mapToFirestore(youtube.toMap());

  // Add any Firestore field values
  youtube.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getYoutubeListFirestoreData(
  List<YoutubeStruct>? youtubes,
) =>
    youtubes?.map((e) => getYoutubeFirestoreData(e, true)).toList() ?? [];
