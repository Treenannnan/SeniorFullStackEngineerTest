// This is a generated file - do not edit.
//
// Generated from schema/v1/schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $0;
import 'schema.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'schema.pbenum.dart';

class UserRecord extends $pb.GeneratedMessage {
  factory UserRecord({
    $core.String? id,
    $core.String? email,
    Provider? provider,
    $core.bool? emailVerified,
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
    $core.List<$core.int>? passwordHash,
    Role? role,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (email != null) result.email = email;
    if (provider != null) result.provider = provider;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (passwordHash != null) result.passwordHash = passwordHash;
    if (role != null) result.role = role;
    return result;
  }

  UserRecord._();

  factory UserRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..e<Provider>(3, _omitFieldNames ? '' : 'provider', $pb.PbFieldType.OE,
        defaultOrMaker: Provider.PROVIDER_UNSPECIFIED,
        valueOf: Provider.valueOf,
        enumValues: Provider.values)
    ..aOB(4, _omitFieldNames ? '' : 'emailVerified')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $0.Timestamp.create)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'passwordHash', $pb.PbFieldType.OY)
    ..e<Role>(8, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE,
        defaultOrMaker: Role.ROLE_UNSPECIFIED,
        valueOf: Role.valueOf,
        enumValues: Role.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRecord clone() => UserRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRecord copyWith(void Function(UserRecord) updates) =>
      super.copyWith((message) => updates(message as UserRecord)) as UserRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRecord create() => UserRecord._();
  @$core.override
  UserRecord createEmptyInstance() => create();
  static $pb.PbList<UserRecord> createRepeated() => $pb.PbList<UserRecord>();
  @$core.pragma('dart2js:noInline')
  static UserRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRecord>(create);
  static UserRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  Provider get provider => $_getN(2);
  @$pb.TagNumber(3)
  set provider(Provider value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailVerified => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerified($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmailVerified() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerified() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureUpdatedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get passwordHash => $_getN(6);
  @$pb.TagNumber(7)
  set passwordHash($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPasswordHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearPasswordHash() => $_clearField(7);

  @$pb.TagNumber(8)
  Role get role => $_getN(7);
  @$pb.TagNumber(8)
  set role(Role value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasRole() => $_has(7);
  @$pb.TagNumber(8)
  void clearRole() => $_clearField(8);
}

class RefreshTokenRecord extends $pb.GeneratedMessage {
  factory RefreshTokenRecord({
    $core.String? token,
    $core.String? userId,
    $0.Timestamp? expiresAt,
    $core.bool? revoked,
    $0.Timestamp? createdAt,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (userId != null) result.userId = userId;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (revoked != null) result.revoked = revoked;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  RefreshTokenRecord._();

  factory RefreshTokenRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokenRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokenRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $0.Timestamp.create)
    ..aOB(4, _omitFieldNames ? '' : 'revoked')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRecord clone() => RefreshTokenRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRecord copyWith(void Function(RefreshTokenRecord) updates) =>
      super.copyWith((message) => updates(message as RefreshTokenRecord))
          as RefreshTokenRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokenRecord create() => RefreshTokenRecord._();
  @$core.override
  RefreshTokenRecord createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenRecord> createRepeated() =>
      $pb.PbList<RefreshTokenRecord>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokenRecord>(create);
  static RefreshTokenRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureExpiresAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get revoked => $_getBF(3);
  @$pb.TagNumber(4)
  set revoked($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRevoked() => $_has(3);
  @$pb.TagNumber(4)
  void clearRevoked() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);
}

class ResetTokenRecord extends $pb.GeneratedMessage {
  factory ResetTokenRecord({
    $core.String? token,
    $core.String? userId,
    $0.Timestamp? expiresAt,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (userId != null) result.userId = userId;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  ResetTokenRecord._();

  factory ResetTokenRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResetTokenRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetTokenRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetTokenRecord clone() => ResetTokenRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetTokenRecord copyWith(void Function(ResetTokenRecord) updates) =>
      super.copyWith((message) => updates(message as ResetTokenRecord))
          as ResetTokenRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetTokenRecord create() => ResetTokenRecord._();
  @$core.override
  ResetTokenRecord createEmptyInstance() => create();
  static $pb.PbList<ResetTokenRecord> createRepeated() =>
      $pb.PbList<ResetTokenRecord>();
  @$core.pragma('dart2js:noInline')
  static ResetTokenRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetTokenRecord>(create);
  static ResetTokenRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureExpiresAt() => $_ensure(2);
}

class UserCreated extends $pb.GeneratedMessage {
  factory UserCreated({
    $core.String? id,
    $core.String? email,
    Provider? provider,
    $core.bool? emailVerified,
    $0.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (email != null) result.email = email;
    if (provider != null) result.provider = provider;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  UserCreated._();

  factory UserCreated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserCreated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserCreated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..e<Provider>(3, _omitFieldNames ? '' : 'provider', $pb.PbFieldType.OE,
        defaultOrMaker: Provider.PROVIDER_UNSPECIFIED,
        valueOf: Provider.valueOf,
        enumValues: Provider.values)
    ..aOB(4, _omitFieldNames ? '' : 'emailVerified')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserCreated clone() => UserCreated()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserCreated copyWith(void Function(UserCreated) updates) =>
      super.copyWith((message) => updates(message as UserCreated))
          as UserCreated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserCreated create() => UserCreated._();
  @$core.override
  UserCreated createEmptyInstance() => create();
  static $pb.PbList<UserCreated> createRepeated() => $pb.PbList<UserCreated>();
  @$core.pragma('dart2js:noInline')
  static UserCreated getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserCreated>(create);
  static UserCreated? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  Provider get provider => $_getN(2);
  @$pb.TagNumber(3)
  set provider(Provider value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailVerified => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerified($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmailVerified() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerified() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);
}

class UserPasswordChanged extends $pb.GeneratedMessage {
  factory UserPasswordChanged({
    $core.String? id,
    $0.Timestamp? changedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (changedAt != null) result.changedAt = changedAt;
    return result;
  }

  UserPasswordChanged._();

  factory UserPasswordChanged.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserPasswordChanged.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPasswordChanged',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'changedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPasswordChanged clone() => UserPasswordChanged()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPasswordChanged copyWith(void Function(UserPasswordChanged) updates) =>
      super.copyWith((message) => updates(message as UserPasswordChanged))
          as UserPasswordChanged;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserPasswordChanged create() => UserPasswordChanged._();
  @$core.override
  UserPasswordChanged createEmptyInstance() => create();
  static $pb.PbList<UserPasswordChanged> createRepeated() =>
      $pb.PbList<UserPasswordChanged>();
  @$core.pragma('dart2js:noInline')
  static UserPasswordChanged getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserPasswordChanged>(create);
  static UserPasswordChanged? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get changedAt => $_getN(1);
  @$pb.TagNumber(2)
  set changedAt($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChangedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearChangedAt() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureChangedAt() => $_ensure(1);
}

class RefreshTokenIssued extends $pb.GeneratedMessage {
  factory RefreshTokenIssued({
    $core.String? token,
    $core.String? userId,
    $0.Timestamp? expiresAt,
    $0.Timestamp? issuedAt,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (userId != null) result.userId = userId;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (issuedAt != null) result.issuedAt = issuedAt;
    return result;
  }

  RefreshTokenIssued._();

  factory RefreshTokenIssued.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokenIssued.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokenIssued',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'issuedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenIssued clone() => RefreshTokenIssued()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenIssued copyWith(void Function(RefreshTokenIssued) updates) =>
      super.copyWith((message) => updates(message as RefreshTokenIssued))
          as RefreshTokenIssued;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokenIssued create() => RefreshTokenIssued._();
  @$core.override
  RefreshTokenIssued createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenIssued> createRepeated() =>
      $pb.PbList<RefreshTokenIssued>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenIssued getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokenIssued>(create);
  static RefreshTokenIssued? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureExpiresAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get issuedAt => $_getN(3);
  @$pb.TagNumber(4)
  set issuedAt($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasIssuedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearIssuedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureIssuedAt() => $_ensure(3);
}

class RefreshTokenRevoked extends $pb.GeneratedMessage {
  factory RefreshTokenRevoked({
    $core.String? token,
    $core.String? userId,
    $core.String? reason,
    $0.Timestamp? revokedAt,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (userId != null) result.userId = userId;
    if (reason != null) result.reason = reason;
    if (revokedAt != null) result.revokedAt = revokedAt;
    return result;
  }

  RefreshTokenRevoked._();

  factory RefreshTokenRevoked.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokenRevoked.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokenRevoked',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'revokedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRevoked clone() => RefreshTokenRevoked()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRevoked copyWith(void Function(RefreshTokenRevoked) updates) =>
      super.copyWith((message) => updates(message as RefreshTokenRevoked))
          as RefreshTokenRevoked;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokenRevoked create() => RefreshTokenRevoked._();
  @$core.override
  RefreshTokenRevoked createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenRevoked> createRepeated() =>
      $pb.PbList<RefreshTokenRevoked>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRevoked getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokenRevoked>(create);
  static RefreshTokenRevoked? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get revokedAt => $_getN(3);
  @$pb.TagNumber(4)
  set revokedAt($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRevokedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearRevokedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureRevokedAt() => $_ensure(3);
}

class AudiobookRecord extends $pb.GeneratedMessage {
  factory AudiobookRecord({
    $core.String? id,
    $core.String? title,
    $core.String? author,
    $fixnum.Int64? durationSeconds,
    $fixnum.Int64? priceCents,
    $core.String? coverUrl,
    $core.String? audioPath,
    $core.String? status,
    $core.String? aiDescription,
    $core.String? transcript,
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
    $core.String? contentType,
    AIProvider? aiProvider,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (author != null) result.author = author;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (priceCents != null) result.priceCents = priceCents;
    if (coverUrl != null) result.coverUrl = coverUrl;
    if (audioPath != null) result.audioPath = audioPath;
    if (status != null) result.status = status;
    if (aiDescription != null) result.aiDescription = aiDescription;
    if (transcript != null) result.transcript = transcript;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (contentType != null) result.contentType = contentType;
    if (aiProvider != null) result.aiProvider = aiProvider;
    return result;
  }

  AudiobookRecord._();

  factory AudiobookRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudiobookRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudiobookRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aInt64(4, _omitFieldNames ? '' : 'durationSeconds')
    ..aInt64(5, _omitFieldNames ? '' : 'priceCents')
    ..aOS(6, _omitFieldNames ? '' : 'coverUrl')
    ..aOS(7, _omitFieldNames ? '' : 'audioPath')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'aiDescription')
    ..aOS(10, _omitFieldNames ? '' : 'transcript')
    ..aOM<$0.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $0.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'contentType')
    ..e<AIProvider>(14, _omitFieldNames ? '' : 'aiProvider', $pb.PbFieldType.OE,
        defaultOrMaker: AIProvider.AIProvider_NONE,
        valueOf: AIProvider.valueOf,
        enumValues: AIProvider.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudiobookRecord clone() => AudiobookRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudiobookRecord copyWith(void Function(AudiobookRecord) updates) =>
      super.copyWith((message) => updates(message as AudiobookRecord))
          as AudiobookRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudiobookRecord create() => AudiobookRecord._();
  @$core.override
  AudiobookRecord createEmptyInstance() => create();
  static $pb.PbList<AudiobookRecord> createRepeated() =>
      $pb.PbList<AudiobookRecord>();
  @$core.pragma('dart2js:noInline')
  static AudiobookRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudiobookRecord>(create);
  static AudiobookRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get durationSeconds => $_getI64(3);
  @$pb.TagNumber(4)
  set durationSeconds($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDurationSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearDurationSeconds() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get priceCents => $_getI64(4);
  @$pb.TagNumber(5)
  set priceCents($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPriceCents() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriceCents() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get coverUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set coverUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCoverUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearCoverUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get audioPath => $_getSZ(6);
  @$pb.TagNumber(7)
  set audioPath($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAudioPath() => $_has(6);
  @$pb.TagNumber(7)
  void clearAudioPath() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get aiDescription => $_getSZ(8);
  @$pb.TagNumber(9)
  set aiDescription($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAiDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearAiDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get transcript => $_getSZ(9);
  @$pb.TagNumber(10)
  set transcript($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTranscript() => $_has(9);
  @$pb.TagNumber(10)
  void clearTranscript() => $_clearField(10);

  @$pb.TagNumber(11)
  $0.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($0.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $0.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $0.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($0.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get contentType => $_getSZ(12);
  @$pb.TagNumber(13)
  set contentType($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasContentType() => $_has(12);
  @$pb.TagNumber(13)
  void clearContentType() => $_clearField(13);

  @$pb.TagNumber(14)
  AIProvider get aiProvider => $_getN(13);
  @$pb.TagNumber(14)
  set aiProvider(AIProvider value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasAiProvider() => $_has(13);
  @$pb.TagNumber(14)
  void clearAiProvider() => $_clearField(14);
}

class AudiobookCategoryRecord extends $pb.GeneratedMessage {
  factory AudiobookCategoryRecord({
    $core.String? audiobookId,
    $core.String? category,
    $core.int? idxPos,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (category != null) result.category = category;
    if (idxPos != null) result.idxPos = idxPos;
    return result;
  }

  AudiobookCategoryRecord._();

  factory AudiobookCategoryRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudiobookCategoryRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudiobookCategoryRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'idxPos', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudiobookCategoryRecord clone() =>
      AudiobookCategoryRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudiobookCategoryRecord copyWith(
          void Function(AudiobookCategoryRecord) updates) =>
      super.copyWith((message) => updates(message as AudiobookCategoryRecord))
          as AudiobookCategoryRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudiobookCategoryRecord create() => AudiobookCategoryRecord._();
  @$core.override
  AudiobookCategoryRecord createEmptyInstance() => create();
  static $pb.PbList<AudiobookCategoryRecord> createRepeated() =>
      $pb.PbList<AudiobookCategoryRecord>();
  @$core.pragma('dart2js:noInline')
  static AudiobookCategoryRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudiobookCategoryRecord>(create);
  static AudiobookCategoryRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get idxPos => $_getIZ(2);
  @$pb.TagNumber(3)
  set idxPos($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdxPos() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdxPos() => $_clearField(3);
}

class CartItemRecord extends $pb.GeneratedMessage {
  factory CartItemRecord({
    $core.String? userId,
    $core.String? audiobookId,
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  CartItemRecord._();

  factory CartItemRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CartItemRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CartItemRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'audiobookId')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartItemRecord clone() => CartItemRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartItemRecord copyWith(void Function(CartItemRecord) updates) =>
      super.copyWith((message) => updates(message as CartItemRecord))
          as CartItemRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CartItemRecord create() => CartItemRecord._();
  @$core.override
  CartItemRecord createEmptyInstance() => create();
  static $pb.PbList<CartItemRecord> createRepeated() =>
      $pb.PbList<CartItemRecord>();
  @$core.pragma('dart2js:noInline')
  static CartItemRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CartItemRecord>(create);
  static CartItemRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get audiobookId => $_getSZ(1);
  @$pb.TagNumber(2)
  set audiobookId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudiobookId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudiobookId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureCreatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get updatedAt => $_getN(3);
  @$pb.TagNumber(4)
  set updatedAt($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUpdatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureUpdatedAt() => $_ensure(3);
}

class OrderRecord extends $pb.GeneratedMessage {
  factory OrderRecord({
    $fixnum.Int64? id,
    $core.String? orderUid,
    $core.String? userId,
    $fixnum.Int64? totalCents,
    $0.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (orderUid != null) result.orderUid = orderUid;
    if (userId != null) result.userId = userId;
    if (totalCents != null) result.totalCents = totalCents;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  OrderRecord._();

  factory OrderRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'orderUid')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aInt64(4, _omitFieldNames ? '' : 'totalCents')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderRecord clone() => OrderRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderRecord copyWith(void Function(OrderRecord) updates) =>
      super.copyWith((message) => updates(message as OrderRecord))
          as OrderRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderRecord create() => OrderRecord._();
  @$core.override
  OrderRecord createEmptyInstance() => create();
  static $pb.PbList<OrderRecord> createRepeated() => $pb.PbList<OrderRecord>();
  @$core.pragma('dart2js:noInline')
  static OrderRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderRecord>(create);
  static OrderRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get orderUid => $_getSZ(1);
  @$pb.TagNumber(2)
  set orderUid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrderUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderUid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalCents => $_getI64(3);
  @$pb.TagNumber(4)
  set totalCents($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCents() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCents() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);
}

class OrderItemRecord extends $pb.GeneratedMessage {
  factory OrderItemRecord({
    $fixnum.Int64? orderId,
    $core.String? audiobookId,
    $fixnum.Int64? priceCents,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (priceCents != null) result.priceCents = priceCents;
    return result;
  }

  OrderItemRecord._();

  factory OrderItemRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderItemRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderItemRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'audiobookId')
    ..aInt64(3, _omitFieldNames ? '' : 'priceCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderItemRecord clone() => OrderItemRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderItemRecord copyWith(void Function(OrderItemRecord) updates) =>
      super.copyWith((message) => updates(message as OrderItemRecord))
          as OrderItemRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderItemRecord create() => OrderItemRecord._();
  @$core.override
  OrderItemRecord createEmptyInstance() => create();
  static $pb.PbList<OrderItemRecord> createRepeated() =>
      $pb.PbList<OrderItemRecord>();
  @$core.pragma('dart2js:noInline')
  static OrderItemRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderItemRecord>(create);
  static OrderItemRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get orderId => $_getI64(0);
  @$pb.TagNumber(1)
  set orderId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get audiobookId => $_getSZ(1);
  @$pb.TagNumber(2)
  set audiobookId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudiobookId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudiobookId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceCents => $_getI64(2);
  @$pb.TagNumber(3)
  set priceCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceCents() => $_clearField(3);
}

class PurchaseRecord extends $pb.GeneratedMessage {
  factory PurchaseRecord({
    $core.String? userId,
    $core.String? audiobookId,
    $fixnum.Int64? priceCents,
    $0.Timestamp? purchasedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (priceCents != null) result.priceCents = priceCents;
    if (purchasedAt != null) result.purchasedAt = purchasedAt;
    return result;
  }

  PurchaseRecord._();

  factory PurchaseRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'schema.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'audiobookId')
    ..aInt64(3, _omitFieldNames ? '' : 'priceCents')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'purchasedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseRecord clone() => PurchaseRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseRecord copyWith(void Function(PurchaseRecord) updates) =>
      super.copyWith((message) => updates(message as PurchaseRecord))
          as PurchaseRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseRecord create() => PurchaseRecord._();
  @$core.override
  PurchaseRecord createEmptyInstance() => create();
  static $pb.PbList<PurchaseRecord> createRepeated() =>
      $pb.PbList<PurchaseRecord>();
  @$core.pragma('dart2js:noInline')
  static PurchaseRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseRecord>(create);
  static PurchaseRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get audiobookId => $_getSZ(1);
  @$pb.TagNumber(2)
  set audiobookId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAudiobookId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudiobookId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceCents => $_getI64(2);
  @$pb.TagNumber(3)
  set priceCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get purchasedAt => $_getN(3);
  @$pb.TagNumber(4)
  set purchasedAt($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPurchasedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearPurchasedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensurePurchasedAt() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
