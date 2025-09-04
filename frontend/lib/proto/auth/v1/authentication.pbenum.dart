// This is a generated file - do not edit.
//
// Generated from auth/v1/authentication.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AuthProvider extends $pb.ProtobufEnum {
  static const AuthProvider AUTH_PROVIDER_UNSPECIFIED =
      AuthProvider._(0, _omitEnumNames ? '' : 'AUTH_PROVIDER_UNSPECIFIED');
  static const AuthProvider AUTH_PROVIDER_CUSTOM =
      AuthProvider._(1, _omitEnumNames ? '' : 'AUTH_PROVIDER_CUSTOM');
  static const AuthProvider AUTH_PROVIDER_GOOGLE =
      AuthProvider._(2, _omitEnumNames ? '' : 'AUTH_PROVIDER_GOOGLE');

  static const $core.List<AuthProvider> values = <AuthProvider>[
    AUTH_PROVIDER_UNSPECIFIED,
    AUTH_PROVIDER_CUSTOM,
    AUTH_PROVIDER_GOOGLE,
  ];

  static final $core.List<AuthProvider?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AuthProvider? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AuthProvider._(super.value, super.name);
}

class Role extends $pb.ProtobufEnum {
  static const Role ROLE_UNSPECIFIED =
      Role._(0, _omitEnumNames ? '' : 'ROLE_UNSPECIFIED');
  static const Role ROLE_USER = Role._(1, _omitEnumNames ? '' : 'ROLE_USER');
  static const Role ROLE_ADMIN = Role._(2, _omitEnumNames ? '' : 'ROLE_ADMIN');

  static const $core.List<Role> values = <Role>[
    ROLE_UNSPECIFIED,
    ROLE_USER,
    ROLE_ADMIN,
  ];

  static final $core.List<Role?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Role? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Role._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
