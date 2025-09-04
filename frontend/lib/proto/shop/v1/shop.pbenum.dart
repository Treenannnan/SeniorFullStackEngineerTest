// This is a generated file - do not edit.
//
// Generated from shop/v1/shop.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MediaStatus extends $pb.ProtobufEnum {
  static const MediaStatus MEDIA_STATUS_UNSPECIFIED =
      MediaStatus._(0, _omitEnumNames ? '' : 'MEDIA_STATUS_UNSPECIFIED');
  static const MediaStatus MEDIA_PROCESSING_AUDIO =
      MediaStatus._(1, _omitEnumNames ? '' : 'MEDIA_PROCESSING_AUDIO');
  static const MediaStatus MEDIA_PROCESSING_TRANSCRIPT =
      MediaStatus._(2, _omitEnumNames ? '' : 'MEDIA_PROCESSING_TRANSCRIPT');
  static const MediaStatus MEDIA_PROCESSING_SUMMARY =
      MediaStatus._(3, _omitEnumNames ? '' : 'MEDIA_PROCESSING_SUMMARY');
  static const MediaStatus MEDIA_READY =
      MediaStatus._(4, _omitEnumNames ? '' : 'MEDIA_READY');
  static const MediaStatus MEDIA_HIDE =
      MediaStatus._(5, _omitEnumNames ? '' : 'MEDIA_HIDE');
  static const MediaStatus MEDIA_DETETED =
      MediaStatus._(6, _omitEnumNames ? '' : 'MEDIA_DETETED');

  static const $core.List<MediaStatus> values = <MediaStatus>[
    MEDIA_STATUS_UNSPECIFIED,
    MEDIA_PROCESSING_AUDIO,
    MEDIA_PROCESSING_TRANSCRIPT,
    MEDIA_PROCESSING_SUMMARY,
    MEDIA_READY,
    MEDIA_HIDE,
    MEDIA_DETETED,
  ];

  static final $core.List<MediaStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MediaStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaStatus._(super.value, super.name);
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
