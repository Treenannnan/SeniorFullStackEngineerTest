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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $2;
import 'shop.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'shop.pbenum.dart';

class Audiobook extends $pb.GeneratedMessage {
  factory Audiobook({
    $core.String? id,
    $core.String? title,
    $core.String? author,
    $fixnum.Int64? durationSeconds,
    $fixnum.Int64? priceCents,
    $core.String? coverUrl,
    MediaStatus? status,
    $core.Iterable<$core.String>? categories,
    $core.String? aiDescription,
    $2.Timestamp? createdAt,
    $2.Timestamp? updatedAt,
    $core.String? contentType,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (author != null) result.author = author;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (priceCents != null) result.priceCents = priceCents;
    if (coverUrl != null) result.coverUrl = coverUrl;
    if (status != null) result.status = status;
    if (categories != null) result.categories.addAll(categories);
    if (aiDescription != null) result.aiDescription = aiDescription;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  Audiobook._();

  factory Audiobook.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Audiobook.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Audiobook',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aInt64(4, _omitFieldNames ? '' : 'durationSeconds')
    ..aInt64(5, _omitFieldNames ? '' : 'priceCents')
    ..aOS(6, _omitFieldNames ? '' : 'coverUrl')
    ..e<MediaStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: MediaStatus.MEDIA_STATUS_UNSPECIFIED,
        valueOf: MediaStatus.valueOf,
        enumValues: MediaStatus.values)
    ..pPS(8, _omitFieldNames ? '' : 'categories')
    ..aOS(9, _omitFieldNames ? '' : 'aiDescription')
    ..aOM<$2.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(11, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $2.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Audiobook clone() => Audiobook()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Audiobook copyWith(void Function(Audiobook) updates) =>
      super.copyWith((message) => updates(message as Audiobook)) as Audiobook;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Audiobook create() => Audiobook._();
  @$core.override
  Audiobook createEmptyInstance() => create();
  static $pb.PbList<Audiobook> createRepeated() => $pb.PbList<Audiobook>();
  @$core.pragma('dart2js:noInline')
  static Audiobook getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Audiobook>(create);
  static Audiobook? _defaultInstance;

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
  MediaStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(MediaStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get categories => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get aiDescription => $_getSZ(8);
  @$pb.TagNumber(9)
  set aiDescription($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAiDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearAiDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $2.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($2.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $2.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $2.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($2.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $2.Timestamp ensureUpdatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get contentType => $_getSZ(11);
  @$pb.TagNumber(12)
  set contentType($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasContentType() => $_has(11);
  @$pb.TagNumber(12)
  void clearContentType() => $_clearField(12);
}

class UploadHeader extends $pb.GeneratedMessage {
  factory UploadHeader({
    $core.String? title,
    $core.String? author,
    $fixnum.Int64? priceCents,
    $core.String? filename,
    $core.String? contentType,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (author != null) result.author = author;
    if (priceCents != null) result.priceCents = priceCents;
    if (filename != null) result.filename = filename;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  UploadHeader._();

  factory UploadHeader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadHeader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadHeader',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'author')
    ..aInt64(3, _omitFieldNames ? '' : 'priceCents')
    ..aOS(4, _omitFieldNames ? '' : 'filename')
    ..aOS(5, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadHeader clone() => UploadHeader()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadHeader copyWith(void Function(UploadHeader) updates) =>
      super.copyWith((message) => updates(message as UploadHeader))
          as UploadHeader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadHeader create() => UploadHeader._();
  @$core.override
  UploadHeader createEmptyInstance() => create();
  static $pb.PbList<UploadHeader> createRepeated() =>
      $pb.PbList<UploadHeader>();
  @$core.pragma('dart2js:noInline')
  static UploadHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadHeader>(create);
  static UploadHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceCents => $_getI64(2);
  @$pb.TagNumber(3)
  set priceCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get filename => $_getSZ(3);
  @$pb.TagNumber(4)
  set filename($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFilename() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilename() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => $_clearField(5);
}

enum UploadChunk_Payload { header, data, notSet }

class UploadChunk extends $pb.GeneratedMessage {
  factory UploadChunk({
    UploadHeader? header,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (header != null) result.header = header;
    if (data != null) result.data = data;
    return result;
  }

  UploadChunk._();

  factory UploadChunk.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadChunk.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UploadChunk_Payload>
      _UploadChunk_PayloadByTag = {
    1: UploadChunk_Payload.header,
    2: UploadChunk_Payload.data,
    0: UploadChunk_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadChunk',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<UploadHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: UploadHeader.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChunk clone() => UploadChunk()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChunk copyWith(void Function(UploadChunk) updates) =>
      super.copyWith((message) => updates(message as UploadChunk))
          as UploadChunk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadChunk create() => UploadChunk._();
  @$core.override
  UploadChunk createEmptyInstance() => create();
  static $pb.PbList<UploadChunk> createRepeated() => $pb.PbList<UploadChunk>();
  @$core.pragma('dart2js:noInline')
  static UploadChunk getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadChunk>(create);
  static UploadChunk? _defaultInstance;

  UploadChunk_Payload whichPayload() =>
      _UploadChunk_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  UploadHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(UploadHeader value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => $_clearField(1);
  @$pb.TagNumber(1)
  UploadHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
}

class UploadAudiobookResponse extends $pb.GeneratedMessage {
  factory UploadAudiobookResponse({
    Audiobook? book,
  }) {
    final result = create();
    if (book != null) result.book = book;
    return result;
  }

  UploadAudiobookResponse._();

  factory UploadAudiobookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadAudiobookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadAudiobookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOM<Audiobook>(1, _omitFieldNames ? '' : 'book',
        subBuilder: Audiobook.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadAudiobookResponse clone() =>
      UploadAudiobookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadAudiobookResponse copyWith(
          void Function(UploadAudiobookResponse) updates) =>
      super.copyWith((message) => updates(message as UploadAudiobookResponse))
          as UploadAudiobookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadAudiobookResponse create() => UploadAudiobookResponse._();
  @$core.override
  UploadAudiobookResponse createEmptyInstance() => create();
  static $pb.PbList<UploadAudiobookResponse> createRepeated() =>
      $pb.PbList<UploadAudiobookResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadAudiobookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadAudiobookResponse>(create);
  static UploadAudiobookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Audiobook get book => $_getN(0);
  @$pb.TagNumber(1)
  set book(Audiobook value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBook() => $_has(0);
  @$pb.TagNumber(1)
  void clearBook() => $_clearField(1);
  @$pb.TagNumber(1)
  Audiobook ensureBook() => $_ensure(0);
}

class CreateUploadUrlRequest extends $pb.GeneratedMessage {
  factory CreateUploadUrlRequest({
    $core.String? title,
    $core.String? author,
    $fixnum.Int64? priceCents,
    $core.String? filename,
    $core.String? contentType,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (author != null) result.author = author;
    if (priceCents != null) result.priceCents = priceCents;
    if (filename != null) result.filename = filename;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  CreateUploadUrlRequest._();

  factory CreateUploadUrlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUploadUrlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUploadUrlRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'author')
    ..aInt64(3, _omitFieldNames ? '' : 'priceCents')
    ..aOS(4, _omitFieldNames ? '' : 'filename')
    ..aOS(5, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadUrlRequest clone() =>
      CreateUploadUrlRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadUrlRequest copyWith(
          void Function(CreateUploadUrlRequest) updates) =>
      super.copyWith((message) => updates(message as CreateUploadUrlRequest))
          as CreateUploadUrlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUploadUrlRequest create() => CreateUploadUrlRequest._();
  @$core.override
  CreateUploadUrlRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUploadUrlRequest> createRepeated() =>
      $pb.PbList<CreateUploadUrlRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUploadUrlRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUploadUrlRequest>(create);
  static CreateUploadUrlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceCents => $_getI64(2);
  @$pb.TagNumber(3)
  set priceCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get filename => $_getSZ(3);
  @$pb.TagNumber(4)
  set filename($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFilename() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilename() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentType => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => $_clearField(5);
}

class CreateUploadUrlResponse extends $pb.GeneratedMessage {
  factory CreateUploadUrlResponse({
    $core.String? audiobookId,
    $core.String? uploadUrl,
    $fixnum.Int64? maxBytes,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (uploadUrl != null) result.uploadUrl = uploadUrl;
    if (maxBytes != null) result.maxBytes = maxBytes;
    return result;
  }

  CreateUploadUrlResponse._();

  factory CreateUploadUrlResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUploadUrlResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUploadUrlResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..aOS(2, _omitFieldNames ? '' : 'uploadUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'maxBytes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadUrlResponse clone() =>
      CreateUploadUrlResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadUrlResponse copyWith(
          void Function(CreateUploadUrlResponse) updates) =>
      super.copyWith((message) => updates(message as CreateUploadUrlResponse))
          as CreateUploadUrlResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUploadUrlResponse create() => CreateUploadUrlResponse._();
  @$core.override
  CreateUploadUrlResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUploadUrlResponse> createRepeated() =>
      $pb.PbList<CreateUploadUrlResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUploadUrlResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUploadUrlResponse>(create);
  static CreateUploadUrlResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uploadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set uploadUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUploadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUploadUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get maxBytes => $_getI64(2);
  @$pb.TagNumber(3)
  set maxBytes($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaxBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxBytes() => $_clearField(3);
}

class CompleteUploadRequest extends $pb.GeneratedMessage {
  factory CompleteUploadRequest({
    $core.String? audiobookId,
    AIProvider? aiProvider,
    MediaStatus? forceStatus,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    if (aiProvider != null) result.aiProvider = aiProvider;
    if (forceStatus != null) result.forceStatus = forceStatus;
    return result;
  }

  CompleteUploadRequest._();

  factory CompleteUploadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteUploadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteUploadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..e<AIProvider>(2, _omitFieldNames ? '' : 'aiProvider', $pb.PbFieldType.OE,
        defaultOrMaker: AIProvider.AIProvider_NONE,
        valueOf: AIProvider.valueOf,
        enumValues: AIProvider.values)
    ..e<MediaStatus>(
        3, _omitFieldNames ? '' : 'forceStatus', $pb.PbFieldType.OE,
        defaultOrMaker: MediaStatus.MEDIA_STATUS_UNSPECIFIED,
        valueOf: MediaStatus.valueOf,
        enumValues: MediaStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadRequest clone() =>
      CompleteUploadRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadRequest copyWith(
          void Function(CompleteUploadRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteUploadRequest))
          as CompleteUploadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteUploadRequest create() => CompleteUploadRequest._();
  @$core.override
  CompleteUploadRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteUploadRequest> createRepeated() =>
      $pb.PbList<CompleteUploadRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteUploadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteUploadRequest>(create);
  static CompleteUploadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);

  @$pb.TagNumber(2)
  AIProvider get aiProvider => $_getN(1);
  @$pb.TagNumber(2)
  set aiProvider(AIProvider value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAiProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearAiProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  MediaStatus get forceStatus => $_getN(2);
  @$pb.TagNumber(3)
  set forceStatus(MediaStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasForceStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearForceStatus() => $_clearField(3);
}

class CompleteUploadResponse extends $pb.GeneratedMessage {
  factory CompleteUploadResponse({
    Audiobook? book,
  }) {
    final result = create();
    if (book != null) result.book = book;
    return result;
  }

  CompleteUploadResponse._();

  factory CompleteUploadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteUploadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteUploadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOM<Audiobook>(1, _omitFieldNames ? '' : 'book',
        subBuilder: Audiobook.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadResponse clone() =>
      CompleteUploadResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadResponse copyWith(
          void Function(CompleteUploadResponse) updates) =>
      super.copyWith((message) => updates(message as CompleteUploadResponse))
          as CompleteUploadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteUploadResponse create() => CompleteUploadResponse._();
  @$core.override
  CompleteUploadResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteUploadResponse> createRepeated() =>
      $pb.PbList<CompleteUploadResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteUploadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteUploadResponse>(create);
  static CompleteUploadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Audiobook get book => $_getN(0);
  @$pb.TagNumber(1)
  set book(Audiobook value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBook() => $_has(0);
  @$pb.TagNumber(1)
  void clearBook() => $_clearField(1);
  @$pb.TagNumber(1)
  Audiobook ensureBook() => $_ensure(0);
}

class GetUploadURLRequest extends $pb.GeneratedMessage {
  factory GetUploadURLRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  GetUploadURLRequest._();

  factory GetUploadURLRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUploadURLRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUploadURLRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadURLRequest clone() => GetUploadURLRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadURLRequest copyWith(void Function(GetUploadURLRequest) updates) =>
      super.copyWith((message) => updates(message as GetUploadURLRequest))
          as GetUploadURLRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUploadURLRequest create() => GetUploadURLRequest._();
  @$core.override
  GetUploadURLRequest createEmptyInstance() => create();
  static $pb.PbList<GetUploadURLRequest> createRepeated() =>
      $pb.PbList<GetUploadURLRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUploadURLRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUploadURLRequest>(create);
  static GetUploadURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class ListAudiobooksRequest extends $pb.GeneratedMessage {
  factory ListAudiobooksRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $core.String? query,
    $core.String? category,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (query != null) result.query = query;
    if (category != null) result.category = category;
    return result;
  }

  ListAudiobooksRequest._();

  factory ListAudiobooksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAudiobooksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAudiobooksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..aOS(3, _omitFieldNames ? '' : 'query')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudiobooksRequest clone() =>
      ListAudiobooksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudiobooksRequest copyWith(
          void Function(ListAudiobooksRequest) updates) =>
      super.copyWith((message) => updates(message as ListAudiobooksRequest))
          as ListAudiobooksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAudiobooksRequest create() => ListAudiobooksRequest._();
  @$core.override
  ListAudiobooksRequest createEmptyInstance() => create();
  static $pb.PbList<ListAudiobooksRequest> createRepeated() =>
      $pb.PbList<ListAudiobooksRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAudiobooksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAudiobooksRequest>(create);
  static ListAudiobooksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);
}

class ListAudiobooksResponse extends $pb.GeneratedMessage {
  factory ListAudiobooksResponse({
    $core.Iterable<Audiobook>? items,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListAudiobooksResponse._();

  factory ListAudiobooksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAudiobooksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAudiobooksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..pc<Audiobook>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: Audiobook.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudiobooksResponse clone() =>
      ListAudiobooksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudiobooksResponse copyWith(
          void Function(ListAudiobooksResponse) updates) =>
      super.copyWith((message) => updates(message as ListAudiobooksResponse))
          as ListAudiobooksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAudiobooksResponse create() => ListAudiobooksResponse._();
  @$core.override
  ListAudiobooksResponse createEmptyInstance() => create();
  static $pb.PbList<ListAudiobooksResponse> createRepeated() =>
      $pb.PbList<ListAudiobooksResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAudiobooksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAudiobooksResponse>(create);
  static ListAudiobooksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Audiobook> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class GetAudiobookRequest extends $pb.GeneratedMessage {
  factory GetAudiobookRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetAudiobookRequest._();

  factory GetAudiobookRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudiobookRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudiobookRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookRequest clone() => GetAudiobookRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookRequest copyWith(void Function(GetAudiobookRequest) updates) =>
      super.copyWith((message) => updates(message as GetAudiobookRequest))
          as GetAudiobookRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudiobookRequest create() => GetAudiobookRequest._();
  @$core.override
  GetAudiobookRequest createEmptyInstance() => create();
  static $pb.PbList<GetAudiobookRequest> createRepeated() =>
      $pb.PbList<GetAudiobookRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAudiobookRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudiobookRequest>(create);
  static GetAudiobookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetAudiobookResponse extends $pb.GeneratedMessage {
  factory GetAudiobookResponse({
    Audiobook? book,
    $core.String? transcriptPreview,
    $core.String? description,
  }) {
    final result = create();
    if (book != null) result.book = book;
    if (transcriptPreview != null) result.transcriptPreview = transcriptPreview;
    if (description != null) result.description = description;
    return result;
  }

  GetAudiobookResponse._();

  factory GetAudiobookResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudiobookResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudiobookResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOM<Audiobook>(1, _omitFieldNames ? '' : 'book',
        subBuilder: Audiobook.create)
    ..aOS(2, _omitFieldNames ? '' : 'transcriptPreview')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookResponse clone() =>
      GetAudiobookResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookResponse copyWith(void Function(GetAudiobookResponse) updates) =>
      super.copyWith((message) => updates(message as GetAudiobookResponse))
          as GetAudiobookResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudiobookResponse create() => GetAudiobookResponse._();
  @$core.override
  GetAudiobookResponse createEmptyInstance() => create();
  static $pb.PbList<GetAudiobookResponse> createRepeated() =>
      $pb.PbList<GetAudiobookResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAudiobookResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudiobookResponse>(create);
  static GetAudiobookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Audiobook get book => $_getN(0);
  @$pb.TagNumber(1)
  set book(Audiobook value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBook() => $_has(0);
  @$pb.TagNumber(1)
  void clearBook() => $_clearField(1);
  @$pb.TagNumber(1)
  Audiobook ensureBook() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get transcriptPreview => $_getSZ(1);
  @$pb.TagNumber(2)
  set transcriptPreview($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTranscriptPreview() => $_has(1);
  @$pb.TagNumber(2)
  void clearTranscriptPreview() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
}

class CartItem extends $pb.GeneratedMessage {
  factory CartItem({
    Audiobook? book,
    $fixnum.Int64? lineSubtotalCents,
  }) {
    final result = create();
    if (book != null) result.book = book;
    if (lineSubtotalCents != null) result.lineSubtotalCents = lineSubtotalCents;
    return result;
  }

  CartItem._();

  factory CartItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CartItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CartItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOM<Audiobook>(1, _omitFieldNames ? '' : 'book',
        subBuilder: Audiobook.create)
    ..aInt64(2, _omitFieldNames ? '' : 'lineSubtotalCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartItem clone() => CartItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartItem copyWith(void Function(CartItem) updates) =>
      super.copyWith((message) => updates(message as CartItem)) as CartItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CartItem create() => CartItem._();
  @$core.override
  CartItem createEmptyInstance() => create();
  static $pb.PbList<CartItem> createRepeated() => $pb.PbList<CartItem>();
  @$core.pragma('dart2js:noInline')
  static CartItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CartItem>(create);
  static CartItem? _defaultInstance;

  @$pb.TagNumber(1)
  Audiobook get book => $_getN(0);
  @$pb.TagNumber(1)
  set book(Audiobook value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBook() => $_has(0);
  @$pb.TagNumber(1)
  void clearBook() => $_clearField(1);
  @$pb.TagNumber(1)
  Audiobook ensureBook() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lineSubtotalCents => $_getI64(1);
  @$pb.TagNumber(2)
  set lineSubtotalCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLineSubtotalCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearLineSubtotalCents() => $_clearField(2);
}

class ViewCartResponse extends $pb.GeneratedMessage {
  factory ViewCartResponse({
    $core.Iterable<CartItem>? items,
    $fixnum.Int64? subtotalCents,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (subtotalCents != null) result.subtotalCents = subtotalCents;
    return result;
  }

  ViewCartResponse._();

  factory ViewCartResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ViewCartResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ViewCartResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..pc<CartItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: CartItem.create)
    ..aInt64(2, _omitFieldNames ? '' : 'subtotalCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewCartResponse clone() => ViewCartResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewCartResponse copyWith(void Function(ViewCartResponse) updates) =>
      super.copyWith((message) => updates(message as ViewCartResponse))
          as ViewCartResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewCartResponse create() => ViewCartResponse._();
  @$core.override
  ViewCartResponse createEmptyInstance() => create();
  static $pb.PbList<ViewCartResponse> createRepeated() =>
      $pb.PbList<ViewCartResponse>();
  @$core.pragma('dart2js:noInline')
  static ViewCartResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ViewCartResponse>(create);
  static ViewCartResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CartItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get subtotalCents => $_getI64(1);
  @$pb.TagNumber(2)
  set subtotalCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubtotalCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubtotalCents() => $_clearField(2);
}

class AddToCartRequest extends $pb.GeneratedMessage {
  factory AddToCartRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  AddToCartRequest._();

  factory AddToCartRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddToCartRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddToCartRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToCartRequest clone() => AddToCartRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToCartRequest copyWith(void Function(AddToCartRequest) updates) =>
      super.copyWith((message) => updates(message as AddToCartRequest))
          as AddToCartRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddToCartRequest create() => AddToCartRequest._();
  @$core.override
  AddToCartRequest createEmptyInstance() => create();
  static $pb.PbList<AddToCartRequest> createRepeated() =>
      $pb.PbList<AddToCartRequest>();
  @$core.pragma('dart2js:noInline')
  static AddToCartRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddToCartRequest>(create);
  static AddToCartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class RemoveFromCartRequest extends $pb.GeneratedMessage {
  factory RemoveFromCartRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  RemoveFromCartRequest._();

  factory RemoveFromCartRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFromCartRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFromCartRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromCartRequest clone() =>
      RemoveFromCartRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromCartRequest copyWith(
          void Function(RemoveFromCartRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveFromCartRequest))
          as RemoveFromCartRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFromCartRequest create() => RemoveFromCartRequest._();
  @$core.override
  RemoveFromCartRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFromCartRequest> createRepeated() =>
      $pb.PbList<RemoveFromCartRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFromCartRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFromCartRequest>(create);
  static RemoveFromCartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class CheckoutResponse extends $pb.GeneratedMessage {
  factory CheckoutResponse({
    $core.String? orderId,
    $fixnum.Int64? totalCents,
    $2.Timestamp? createdAt,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (totalCents != null) result.totalCents = totalCents;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  CheckoutResponse._();

  factory CheckoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aInt64(2, _omitFieldNames ? '' : 'totalCents')
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutResponse clone() => CheckoutResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutResponse copyWith(void Function(CheckoutResponse) updates) =>
      super.copyWith((message) => updates(message as CheckoutResponse))
          as CheckoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckoutResponse create() => CheckoutResponse._();
  @$core.override
  CheckoutResponse createEmptyInstance() => create();
  static $pb.PbList<CheckoutResponse> createRepeated() =>
      $pb.PbList<CheckoutResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckoutResponse>(create);
  static CheckoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalCents => $_getI64(1);
  @$pb.TagNumber(2)
  set totalCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCents() => $_clearField(2);

  @$pb.TagNumber(3)
  $2.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($2.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureCreatedAt() => $_ensure(2);
}

class ListPurchasesResponse_PurchasedItem extends $pb.GeneratedMessage {
  factory ListPurchasesResponse_PurchasedItem({
    $core.String? orderId,
    Audiobook? book,
    $fixnum.Int64? priceCents,
    $2.Timestamp? purchasedAt,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (book != null) result.book = book;
    if (priceCents != null) result.priceCents = priceCents;
    if (purchasedAt != null) result.purchasedAt = purchasedAt;
    return result;
  }

  ListPurchasesResponse_PurchasedItem._();

  factory ListPurchasesResponse_PurchasedItem.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPurchasesResponse_PurchasedItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPurchasesResponse.PurchasedItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOM<Audiobook>(2, _omitFieldNames ? '' : 'book',
        subBuilder: Audiobook.create)
    ..aInt64(3, _omitFieldNames ? '' : 'priceCents')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'purchasedAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchasesResponse_PurchasedItem clone() =>
      ListPurchasesResponse_PurchasedItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchasesResponse_PurchasedItem copyWith(
          void Function(ListPurchasesResponse_PurchasedItem) updates) =>
      super.copyWith((message) =>
              updates(message as ListPurchasesResponse_PurchasedItem))
          as ListPurchasesResponse_PurchasedItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPurchasesResponse_PurchasedItem create() =>
      ListPurchasesResponse_PurchasedItem._();
  @$core.override
  ListPurchasesResponse_PurchasedItem createEmptyInstance() => create();
  static $pb.PbList<ListPurchasesResponse_PurchasedItem> createRepeated() =>
      $pb.PbList<ListPurchasesResponse_PurchasedItem>();
  @$core.pragma('dart2js:noInline')
  static ListPurchasesResponse_PurchasedItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListPurchasesResponse_PurchasedItem>(create);
  static ListPurchasesResponse_PurchasedItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  Audiobook get book => $_getN(1);
  @$pb.TagNumber(2)
  set book(Audiobook value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBook() => $_has(1);
  @$pb.TagNumber(2)
  void clearBook() => $_clearField(2);
  @$pb.TagNumber(2)
  Audiobook ensureBook() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get priceCents => $_getI64(2);
  @$pb.TagNumber(3)
  set priceCents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriceCents() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriceCents() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get purchasedAt => $_getN(3);
  @$pb.TagNumber(4)
  set purchasedAt($2.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPurchasedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearPurchasedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensurePurchasedAt() => $_ensure(3);
}

class ListPurchasesResponse extends $pb.GeneratedMessage {
  factory ListPurchasesResponse({
    $core.Iterable<ListPurchasesResponse_PurchasedItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListPurchasesResponse._();

  factory ListPurchasesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPurchasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPurchasesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..pc<ListPurchasesResponse_PurchasedItem>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: ListPurchasesResponse_PurchasedItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchasesResponse clone() =>
      ListPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchasesResponse copyWith(
          void Function(ListPurchasesResponse) updates) =>
      super.copyWith((message) => updates(message as ListPurchasesResponse))
          as ListPurchasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPurchasesResponse create() => ListPurchasesResponse._();
  @$core.override
  ListPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<ListPurchasesResponse> createRepeated() =>
      $pb.PbList<ListPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPurchasesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPurchasesResponse>(create);
  static ListPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ListPurchasesResponse_PurchasedItem> get items => $_getList(0);
}

class GetDownloadURLRequest extends $pb.GeneratedMessage {
  factory GetDownloadURLRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  GetDownloadURLRequest._();

  factory GetDownloadURLRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDownloadURLRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDownloadURLRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadURLRequest clone() =>
      GetDownloadURLRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadURLRequest copyWith(
          void Function(GetDownloadURLRequest) updates) =>
      super.copyWith((message) => updates(message as GetDownloadURLRequest))
          as GetDownloadURLRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDownloadURLRequest create() => GetDownloadURLRequest._();
  @$core.override
  GetDownloadURLRequest createEmptyInstance() => create();
  static $pb.PbList<GetDownloadURLRequest> createRepeated() =>
      $pb.PbList<GetDownloadURLRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDownloadURLRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDownloadURLRequest>(create);
  static GetDownloadURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class GetDownloadURLResponse extends $pb.GeneratedMessage {
  factory GetDownloadURLResponse({
    $core.String? downloadUrl,
  }) {
    final result = create();
    if (downloadUrl != null) result.downloadUrl = downloadUrl;
    return result;
  }

  GetDownloadURLResponse._();

  factory GetDownloadURLResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDownloadURLResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDownloadURLResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'downloadUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadURLResponse clone() =>
      GetDownloadURLResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadURLResponse copyWith(
          void Function(GetDownloadURLResponse) updates) =>
      super.copyWith((message) => updates(message as GetDownloadURLResponse))
          as GetDownloadURLResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDownloadURLResponse create() => GetDownloadURLResponse._();
  @$core.override
  GetDownloadURLResponse createEmptyInstance() => create();
  static $pb.PbList<GetDownloadURLResponse> createRepeated() =>
      $pb.PbList<GetDownloadURLResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDownloadURLResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDownloadURLResponse>(create);
  static GetDownloadURLResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get downloadUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set downloadUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDownloadUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearDownloadUrl() => $_clearField(1);
}

class GetTranscriptRequest extends $pb.GeneratedMessage {
  factory GetTranscriptRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  GetTranscriptRequest._();

  factory GetTranscriptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTranscriptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTranscriptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTranscriptRequest clone() =>
      GetTranscriptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTranscriptRequest copyWith(void Function(GetTranscriptRequest) updates) =>
      super.copyWith((message) => updates(message as GetTranscriptRequest))
          as GetTranscriptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTranscriptRequest create() => GetTranscriptRequest._();
  @$core.override
  GetTranscriptRequest createEmptyInstance() => create();
  static $pb.PbList<GetTranscriptRequest> createRepeated() =>
      $pb.PbList<GetTranscriptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTranscriptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTranscriptRequest>(create);
  static GetTranscriptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class GetTranscriptResponse extends $pb.GeneratedMessage {
  factory GetTranscriptResponse({
    $core.String? transcript,
  }) {
    final result = create();
    if (transcript != null) result.transcript = transcript;
    return result;
  }

  GetTranscriptResponse._();

  factory GetTranscriptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTranscriptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTranscriptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transcript')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTranscriptResponse clone() =>
      GetTranscriptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTranscriptResponse copyWith(
          void Function(GetTranscriptResponse) updates) =>
      super.copyWith((message) => updates(message as GetTranscriptResponse))
          as GetTranscriptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTranscriptResponse create() => GetTranscriptResponse._();
  @$core.override
  GetTranscriptResponse createEmptyInstance() => create();
  static $pb.PbList<GetTranscriptResponse> createRepeated() =>
      $pb.PbList<GetTranscriptResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTranscriptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTranscriptResponse>(create);
  static GetTranscriptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transcript => $_getSZ(0);
  @$pb.TagNumber(1)
  set transcript($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTranscript() => $_has(0);
  @$pb.TagNumber(1)
  void clearTranscript() => $_clearField(1);
}

class GetDescriptionRequest extends $pb.GeneratedMessage {
  factory GetDescriptionRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  GetDescriptionRequest._();

  factory GetDescriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDescriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDescriptionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDescriptionRequest clone() =>
      GetDescriptionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDescriptionRequest copyWith(
          void Function(GetDescriptionRequest) updates) =>
      super.copyWith((message) => updates(message as GetDescriptionRequest))
          as GetDescriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDescriptionRequest create() => GetDescriptionRequest._();
  @$core.override
  GetDescriptionRequest createEmptyInstance() => create();
  static $pb.PbList<GetDescriptionRequest> createRepeated() =>
      $pb.PbList<GetDescriptionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDescriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDescriptionRequest>(create);
  static GetDescriptionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class GetDescriptionResponse extends $pb.GeneratedMessage {
  factory GetDescriptionResponse({
    $core.String? description,
  }) {
    final result = create();
    if (description != null) result.description = description;
    return result;
  }

  GetDescriptionResponse._();

  factory GetDescriptionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDescriptionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDescriptionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDescriptionResponse clone() =>
      GetDescriptionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDescriptionResponse copyWith(
          void Function(GetDescriptionResponse) updates) =>
      super.copyWith((message) => updates(message as GetDescriptionResponse))
          as GetDescriptionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDescriptionResponse create() => GetDescriptionResponse._();
  @$core.override
  GetDescriptionResponse createEmptyInstance() => create();
  static $pb.PbList<GetDescriptionResponse> createRepeated() =>
      $pb.PbList<GetDescriptionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDescriptionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDescriptionResponse>(create);
  static GetDescriptionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);
}

class GetAudiobookStatusRequest extends $pb.GeneratedMessage {
  factory GetAudiobookStatusRequest({
    $core.String? audiobookId,
  }) {
    final result = create();
    if (audiobookId != null) result.audiobookId = audiobookId;
    return result;
  }

  GetAudiobookStatusRequest._();

  factory GetAudiobookStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudiobookStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudiobookStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audiobookId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookStatusRequest clone() =>
      GetAudiobookStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookStatusRequest copyWith(
          void Function(GetAudiobookStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetAudiobookStatusRequest))
          as GetAudiobookStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudiobookStatusRequest create() => GetAudiobookStatusRequest._();
  @$core.override
  GetAudiobookStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetAudiobookStatusRequest> createRepeated() =>
      $pb.PbList<GetAudiobookStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAudiobookStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudiobookStatusRequest>(create);
  static GetAudiobookStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audiobookId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audiobookId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudiobookId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudiobookId() => $_clearField(1);
}

class GetAudiobookStatusResponse extends $pb.GeneratedMessage {
  factory GetAudiobookStatusResponse({
    MediaStatus? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  GetAudiobookStatusResponse._();

  factory GetAudiobookStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudiobookStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudiobookStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'shop.v1'),
      createEmptyInstance: create)
    ..e<MediaStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: MediaStatus.MEDIA_STATUS_UNSPECIFIED,
        valueOf: MediaStatus.valueOf,
        enumValues: MediaStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookStatusResponse clone() =>
      GetAudiobookStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudiobookStatusResponse copyWith(
          void Function(GetAudiobookStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAudiobookStatusResponse))
          as GetAudiobookStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudiobookStatusResponse create() => GetAudiobookStatusResponse._();
  @$core.override
  GetAudiobookStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetAudiobookStatusResponse> createRepeated() =>
      $pb.PbList<GetAudiobookStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAudiobookStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudiobookStatusResponse>(create);
  static GetAudiobookStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MediaStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(MediaStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
