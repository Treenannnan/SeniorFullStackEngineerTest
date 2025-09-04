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

import 'package:protobuf/protobuf.dart' as $pb;

class Provider extends $pb.ProtobufEnum {
  static const Provider PROVIDER_UNSPECIFIED =
      Provider._(0, _omitEnumNames ? '' : 'PROVIDER_UNSPECIFIED');
  static const Provider PROVIDER_CUSTOM =
      Provider._(1, _omitEnumNames ? '' : 'PROVIDER_CUSTOM');
  static const Provider PROVIDER_GOOGLE =
      Provider._(2, _omitEnumNames ? '' : 'PROVIDER_GOOGLE');

  static const $core.List<Provider> values = <Provider>[
    PROVIDER_UNSPECIFIED,
    PROVIDER_CUSTOM,
    PROVIDER_GOOGLE,
  ];

  static final $core.List<Provider?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Provider? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Provider._(super.value, super.name);
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

class AIProvider extends $pb.ProtobufEnum {
  static const AIProvider AIProvider_NONE =
      AIProvider._(0, _omitEnumNames ? '' : 'AIProvider_NONE');
  static const AIProvider AIProvider_AWS =
      AIProvider._(1, _omitEnumNames ? '' : 'AIProvider_AWS');
  static const AIProvider AIProvider_LOCAL =
      AIProvider._(2, _omitEnumNames ? '' : 'AIProvider_LOCAL');

  static const $core.List<AIProvider> values = <AIProvider>[
    AIProvider_NONE,
    AIProvider_AWS,
    AIProvider_LOCAL,
  ];

  static final $core.List<AIProvider?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AIProvider? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AIProvider._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
