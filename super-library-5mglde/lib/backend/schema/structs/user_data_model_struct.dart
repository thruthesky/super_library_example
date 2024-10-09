// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserDataModelStruct extends BaseStruct {
  UserDataModelStruct({
    DateTime? createdAt,
    String? displayName,
    String? displayNameLowerCase,
    String? photoUrl,
  })  : _createdAt = createdAt,
        _displayName = displayName,
        _displayNameLowerCase = displayNameLowerCase,
        _photoUrl = photoUrl;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

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

  static UserDataModelStruct fromMap(Map<String, dynamic> data) =>
      UserDataModelStruct(
        createdAt: data['createdAt'] as DateTime?,
        displayName: data['displayName'] as String?,
        displayNameLowerCase: data['displayNameLowerCase'] as String?,
        photoUrl: data['photoUrl'] as String?,
      );

  static UserDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? UserDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'createdAt': _createdAt,
        'displayName': _displayName,
        'displayNameLowerCase': _displayNameLowerCase,
        'photoUrl': _photoUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
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
      }.withoutNulls;

  static UserDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserDataModelStruct(
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
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
      );

  @override
  String toString() => 'UserDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserDataModelStruct &&
        createdAt == other.createdAt &&
        displayName == other.displayName &&
        displayNameLowerCase == other.displayNameLowerCase &&
        photoUrl == other.photoUrl;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, displayName, displayNameLowerCase, photoUrl]);
}

UserDataModelStruct createUserDataModelStruct({
  DateTime? createdAt,
  String? displayName,
  String? displayNameLowerCase,
  String? photoUrl,
}) =>
    UserDataModelStruct(
      createdAt: createdAt,
      displayName: displayName,
      displayNameLowerCase: displayNameLowerCase,
      photoUrl: photoUrl,
    );
