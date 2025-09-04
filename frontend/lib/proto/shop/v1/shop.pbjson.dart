// This is a generated file - do not edit.
//
// Generated from shop/v1/shop.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use mediaStatusDescriptor instead')
const MediaStatus$json = {
  '1': 'MediaStatus',
  '2': [
    {'1': 'MEDIA_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_PROCESSING_AUDIO', '2': 1},
    {'1': 'MEDIA_PROCESSING_TRANSCRIPT', '2': 2},
    {'1': 'MEDIA_PROCESSING_SUMMARY', '2': 3},
    {'1': 'MEDIA_READY', '2': 4},
    {'1': 'MEDIA_HIDE', '2': 5},
    {'1': 'MEDIA_DETETED', '2': 6},
  ],
};

/// Descriptor for `MediaStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaStatusDescriptor = $convert.base64Decode(
    'CgtNZWRpYVN0YXR1cxIcChhNRURJQV9TVEFUVVNfVU5TUEVDSUZJRUQQABIaChZNRURJQV9QUk'
    '9DRVNTSU5HX0FVRElPEAESHwobTUVESUFfUFJPQ0VTU0lOR19UUkFOU0NSSVBUEAISHAoYTUVE'
    'SUFfUFJPQ0VTU0lOR19TVU1NQVJZEAMSDwoLTUVESUFfUkVBRFkQBBIOCgpNRURJQV9ISURFEA'
    'USEQoNTUVESUFfREVURVRFRBAG');

@$core.Deprecated('Use aIProviderDescriptor instead')
const AIProvider$json = {
  '1': 'AIProvider',
  '2': [
    {'1': 'AIProvider_NONE', '2': 0},
    {'1': 'AIProvider_AWS', '2': 1},
    {'1': 'AIProvider_LOCAL', '2': 2},
  ],
};

/// Descriptor for `AIProvider`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List aIProviderDescriptor = $convert.base64Decode(
    'CgpBSVByb3ZpZGVyEhMKD0FJUHJvdmlkZXJfTk9ORRAAEhIKDkFJUHJvdmlkZXJfQVdTEAESFA'
    'oQQUlQcm92aWRlcl9MT0NBTBAC');

@$core.Deprecated('Use audiobookDescriptor instead')
const Audiobook$json = {
  '1': 'Audiobook',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'duration_seconds', '3': 4, '4': 1, '5': 3, '10': 'durationSeconds'},
    {'1': 'price_cents', '3': 5, '4': 1, '5': 3, '10': 'priceCents'},
    {'1': 'cover_url', '3': 6, '4': 1, '5': 9, '10': 'coverUrl'},
    {
      '1': 'status',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.shop.v1.MediaStatus',
      '10': 'status'
    },
    {'1': 'categories', '3': 8, '4': 3, '5': 9, '10': 'categories'},
    {'1': 'ai_description', '3': 9, '4': 1, '5': 9, '10': 'aiDescription'},
    {
      '1': 'created_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'content_type', '3': 12, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `Audiobook`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audiobookDescriptor = $convert.base64Decode(
    'CglBdWRpb2Jvb2sSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCgZhdX'
    'Rob3IYAyABKAlSBmF1dGhvchIpChBkdXJhdGlvbl9zZWNvbmRzGAQgASgDUg9kdXJhdGlvblNl'
    'Y29uZHMSHwoLcHJpY2VfY2VudHMYBSABKANSCnByaWNlQ2VudHMSGwoJY292ZXJfdXJsGAYgAS'
    'gJUghjb3ZlclVybBIsCgZzdGF0dXMYByABKA4yFC5zaG9wLnYxLk1lZGlhU3RhdHVzUgZzdGF0'
    'dXMSHgoKY2F0ZWdvcmllcxgIIAMoCVIKY2F0ZWdvcmllcxIlCg5haV9kZXNjcmlwdGlvbhgJIA'
    'EoCVINYWlEZXNjcmlwdGlvbhI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSIQoMY29udGVudF90eXBlGAwgASgJUgtjb250ZW50'
    'VHlwZQ==');

@$core.Deprecated('Use uploadHeaderDescriptor instead')
const UploadHeader$json = {
  '1': 'UploadHeader',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
    {'1': 'price_cents', '3': 3, '4': 1, '5': 3, '10': 'priceCents'},
    {'1': 'filename', '3': 4, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `UploadHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadHeaderDescriptor = $convert.base64Decode(
    'CgxVcGxvYWRIZWFkZXISFAoFdGl0bGUYASABKAlSBXRpdGxlEhYKBmF1dGhvchgCIAEoCVIGYX'
    'V0aG9yEh8KC3ByaWNlX2NlbnRzGAMgASgDUgpwcmljZUNlbnRzEhoKCGZpbGVuYW1lGAQgASgJ'
    'UghmaWxlbmFtZRIhCgxjb250ZW50X3R5cGUYBSABKAlSC2NvbnRlbnRUeXBl');

@$core.Deprecated('Use uploadChunkDescriptor instead')
const UploadChunk$json = {
  '1': 'UploadChunk',
  '2': [
    {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.UploadHeader',
      '9': 0,
      '10': 'header'
    },
    {'1': 'data', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'data'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `UploadChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadChunkDescriptor = $convert.base64Decode(
    'CgtVcGxvYWRDaHVuaxIvCgZoZWFkZXIYASABKAsyFS5zaG9wLnYxLlVwbG9hZEhlYWRlckgAUg'
    'ZoZWFkZXISFAoEZGF0YRgCIAEoDEgAUgRkYXRhQgkKB3BheWxvYWQ=');

@$core.Deprecated('Use uploadAudiobookResponseDescriptor instead')
const UploadAudiobookResponse$json = {
  '1': 'UploadAudiobookResponse',
  '2': [
    {
      '1': 'book',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'book'
    },
  ],
};

/// Descriptor for `UploadAudiobookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadAudiobookResponseDescriptor =
    $convert.base64Decode(
        'ChdVcGxvYWRBdWRpb2Jvb2tSZXNwb25zZRImCgRib29rGAEgASgLMhIuc2hvcC52MS5BdWRpb2'
        'Jvb2tSBGJvb2s=');

@$core.Deprecated('Use createUploadUrlRequestDescriptor instead')
const CreateUploadUrlRequest$json = {
  '1': 'CreateUploadUrlRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
    {'1': 'price_cents', '3': 3, '4': 1, '5': 3, '10': 'priceCents'},
    {'1': 'filename', '3': 4, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `CreateUploadUrlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUploadUrlRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVVcGxvYWRVcmxSZXF1ZXN0EhQKBXRpdGxlGAEgASgJUgV0aXRsZRIWCgZhdXRob3'
    'IYAiABKAlSBmF1dGhvchIfCgtwcmljZV9jZW50cxgDIAEoA1IKcHJpY2VDZW50cxIaCghmaWxl'
    'bmFtZRgEIAEoCVIIZmlsZW5hbWUSIQoMY29udGVudF90eXBlGAUgASgJUgtjb250ZW50VHlwZQ'
    '==');

@$core.Deprecated('Use createUploadUrlResponseDescriptor instead')
const CreateUploadUrlResponse$json = {
  '1': 'CreateUploadUrlResponse',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
    {'1': 'upload_url', '3': 2, '4': 1, '5': 9, '10': 'uploadUrl'},
    {'1': 'max_bytes', '3': 3, '4': 1, '5': 3, '10': 'maxBytes'},
  ],
};

/// Descriptor for `CreateUploadUrlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUploadUrlResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVVcGxvYWRVcmxSZXNwb25zZRIhCgxhdWRpb2Jvb2tfaWQYASABKAlSC2F1ZGlvYm'
    '9va0lkEh0KCnVwbG9hZF91cmwYAiABKAlSCXVwbG9hZFVybBIbCgltYXhfYnl0ZXMYAyABKANS'
    'CG1heEJ5dGVz');

@$core.Deprecated('Use completeUploadRequestDescriptor instead')
const CompleteUploadRequest$json = {
  '1': 'CompleteUploadRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
    {
      '1': 'ai_provider',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.shop.v1.AIProvider',
      '10': 'aiProvider'
    },
    {
      '1': 'force_status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.shop.v1.MediaStatus',
      '10': 'forceStatus'
    },
  ],
};

/// Descriptor for `CompleteUploadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUploadRequestDescriptor = $convert.base64Decode(
    'ChVDb21wbGV0ZVVwbG9hZFJlcXVlc3QSIQoMYXVkaW9ib29rX2lkGAEgASgJUgthdWRpb2Jvb2'
    'tJZBI0CgthaV9wcm92aWRlchgCIAEoDjITLnNob3AudjEuQUlQcm92aWRlclIKYWlQcm92aWRl'
    'chI3Cgxmb3JjZV9zdGF0dXMYAyABKA4yFC5zaG9wLnYxLk1lZGlhU3RhdHVzUgtmb3JjZVN0YX'
    'R1cw==');

@$core.Deprecated('Use completeUploadResponseDescriptor instead')
const CompleteUploadResponse$json = {
  '1': 'CompleteUploadResponse',
  '2': [
    {
      '1': 'book',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'book'
    },
  ],
};

/// Descriptor for `CompleteUploadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUploadResponseDescriptor =
    $convert.base64Decode(
        'ChZDb21wbGV0ZVVwbG9hZFJlc3BvbnNlEiYKBGJvb2sYASABKAsyEi5zaG9wLnYxLkF1ZGlvYm'
        '9va1IEYm9vaw==');

@$core.Deprecated('Use getUploadURLRequestDescriptor instead')
const GetUploadURLRequest$json = {
  '1': 'GetUploadURLRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `GetUploadURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUploadURLRequestDescriptor = $convert.base64Decode(
    'ChNHZXRVcGxvYWRVUkxSZXF1ZXN0EiEKDGF1ZGlvYm9va19pZBgBIAEoCVILYXVkaW9ib29rSW'
    'Q=');

@$core.Deprecated('Use listAudiobooksRequestDescriptor instead')
const ListAudiobooksRequest$json = {
  '1': 'ListAudiobooksRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `ListAudiobooksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAudiobooksRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0QXVkaW9ib29rc1JlcXVlc3QSGwoJcGFnZV9zaXplGAEgASgFUghwYWdlU2l6ZRIdCg'
    'pwYWdlX3Rva2VuGAIgASgJUglwYWdlVG9rZW4SFAoFcXVlcnkYAyABKAlSBXF1ZXJ5EhoKCGNh'
    'dGVnb3J5GAQgASgJUghjYXRlZ29yeQ==');

@$core.Deprecated('Use listAudiobooksResponseDescriptor instead')
const ListAudiobooksResponse$json = {
  '1': 'ListAudiobooksResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'items'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListAudiobooksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAudiobooksResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0QXVkaW9ib29rc1Jlc3BvbnNlEigKBWl0ZW1zGAEgAygLMhIuc2hvcC52MS5BdWRpb2'
    'Jvb2tSBWl0ZW1zEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use getAudiobookRequestDescriptor instead')
const GetAudiobookRequest$json = {
  '1': 'GetAudiobookRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetAudiobookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudiobookRequestDescriptor = $convert
    .base64Decode('ChNHZXRBdWRpb2Jvb2tSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use getAudiobookResponseDescriptor instead')
const GetAudiobookResponse$json = {
  '1': 'GetAudiobookResponse',
  '2': [
    {
      '1': 'book',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'book'
    },
    {
      '1': 'transcript_preview',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'transcriptPreview'
    },
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `GetAudiobookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudiobookResponseDescriptor = $convert.base64Decode(
    'ChRHZXRBdWRpb2Jvb2tSZXNwb25zZRImCgRib29rGAEgASgLMhIuc2hvcC52MS5BdWRpb2Jvb2'
    'tSBGJvb2sSLQoSdHJhbnNjcmlwdF9wcmV2aWV3GAIgASgJUhF0cmFuc2NyaXB0UHJldmlldxIg'
    'CgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24=');

@$core.Deprecated('Use cartItemDescriptor instead')
const CartItem$json = {
  '1': 'CartItem',
  '2': [
    {
      '1': 'book',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'book'
    },
    {
      '1': 'line_subtotal_cents',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'lineSubtotalCents'
    },
  ],
};

/// Descriptor for `CartItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cartItemDescriptor = $convert.base64Decode(
    'CghDYXJ0SXRlbRImCgRib29rGAEgASgLMhIuc2hvcC52MS5BdWRpb2Jvb2tSBGJvb2sSLgoTbG'
    'luZV9zdWJ0b3RhbF9jZW50cxgCIAEoA1IRbGluZVN1YnRvdGFsQ2VudHM=');

@$core.Deprecated('Use viewCartResponseDescriptor instead')
const ViewCartResponse$json = {
  '1': 'ViewCartResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.shop.v1.CartItem',
      '10': 'items'
    },
    {'1': 'subtotal_cents', '3': 2, '4': 1, '5': 3, '10': 'subtotalCents'},
  ],
};

/// Descriptor for `ViewCartResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewCartResponseDescriptor = $convert.base64Decode(
    'ChBWaWV3Q2FydFJlc3BvbnNlEicKBWl0ZW1zGAEgAygLMhEuc2hvcC52MS5DYXJ0SXRlbVIFaX'
    'RlbXMSJQoOc3VidG90YWxfY2VudHMYAiABKANSDXN1YnRvdGFsQ2VudHM=');

@$core.Deprecated('Use addToCartRequestDescriptor instead')
const AddToCartRequest$json = {
  '1': 'AddToCartRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `AddToCartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToCartRequestDescriptor = $convert.base64Decode(
    'ChBBZGRUb0NhcnRSZXF1ZXN0EiEKDGF1ZGlvYm9va19pZBgBIAEoCVILYXVkaW9ib29rSWQ=');

@$core.Deprecated('Use removeFromCartRequestDescriptor instead')
const RemoveFromCartRequest$json = {
  '1': 'RemoveFromCartRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `RemoveFromCartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromCartRequestDescriptor = $convert.base64Decode(
    'ChVSZW1vdmVGcm9tQ2FydFJlcXVlc3QSIQoMYXVkaW9ib29rX2lkGAEgASgJUgthdWRpb2Jvb2'
    'tJZA==');

@$core.Deprecated('Use checkoutResponseDescriptor instead')
const CheckoutResponse$json = {
  '1': 'CheckoutResponse',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    {'1': 'total_cents', '3': 2, '4': 1, '5': 3, '10': 'totalCents'},
    {
      '1': 'created_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `CheckoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkoutResponseDescriptor = $convert.base64Decode(
    'ChBDaGVja291dFJlc3BvbnNlEhkKCG9yZGVyX2lkGAEgASgJUgdvcmRlcklkEh8KC3RvdGFsX2'
    'NlbnRzGAIgASgDUgp0b3RhbENlbnRzEjkKCmNyZWF0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use listPurchasesResponseDescriptor instead')
const ListPurchasesResponse$json = {
  '1': 'ListPurchasesResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.shop.v1.ListPurchasesResponse.PurchasedItem',
      '10': 'items'
    },
  ],
  '3': [ListPurchasesResponse_PurchasedItem$json],
};

@$core.Deprecated('Use listPurchasesResponseDescriptor instead')
const ListPurchasesResponse_PurchasedItem$json = {
  '1': 'PurchasedItem',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    {
      '1': 'book',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.shop.v1.Audiobook',
      '10': 'book'
    },
    {'1': 'price_cents', '3': 3, '4': 1, '5': 3, '10': 'priceCents'},
    {
      '1': 'purchased_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'purchasedAt'
    },
  ],
};

/// Descriptor for `ListPurchasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPurchasesResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0UHVyY2hhc2VzUmVzcG9uc2USQgoFaXRlbXMYASADKAsyLC5zaG9wLnYxLkxpc3RQdX'
    'JjaGFzZXNSZXNwb25zZS5QdXJjaGFzZWRJdGVtUgVpdGVtcxqyAQoNUHVyY2hhc2VkSXRlbRIZ'
    'CghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZBImCgRib29rGAIgASgLMhIuc2hvcC52MS5BdWRpb2'
    'Jvb2tSBGJvb2sSHwoLcHJpY2VfY2VudHMYAyABKANSCnByaWNlQ2VudHMSPQoMcHVyY2hhc2Vk'
    'X2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcHVyY2hhc2VkQXQ=');

@$core.Deprecated('Use getDownloadURLRequestDescriptor instead')
const GetDownloadURLRequest$json = {
  '1': 'GetDownloadURLRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `GetDownloadURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDownloadURLRequestDescriptor = $convert.base64Decode(
    'ChVHZXREb3dubG9hZFVSTFJlcXVlc3QSIQoMYXVkaW9ib29rX2lkGAEgASgJUgthdWRpb2Jvb2'
    'tJZA==');

@$core.Deprecated('Use getDownloadURLResponseDescriptor instead')
const GetDownloadURLResponse$json = {
  '1': 'GetDownloadURLResponse',
  '2': [
    {'1': 'download_url', '3': 1, '4': 1, '5': 9, '10': 'downloadUrl'},
  ],
};

/// Descriptor for `GetDownloadURLResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDownloadURLResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXREb3dubG9hZFVSTFJlc3BvbnNlEiEKDGRvd25sb2FkX3VybBgBIAEoCVILZG93bmxvYW'
        'RVcmw=');

@$core.Deprecated('Use getTranscriptRequestDescriptor instead')
const GetTranscriptRequest$json = {
  '1': 'GetTranscriptRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `GetTranscriptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTranscriptRequestDescriptor = $convert.base64Decode(
    'ChRHZXRUcmFuc2NyaXB0UmVxdWVzdBIhCgxhdWRpb2Jvb2tfaWQYASABKAlSC2F1ZGlvYm9va0'
    'lk');

@$core.Deprecated('Use getTranscriptResponseDescriptor instead')
const GetTranscriptResponse$json = {
  '1': 'GetTranscriptResponse',
  '2': [
    {'1': 'transcript', '3': 1, '4': 1, '5': 9, '10': 'transcript'},
  ],
};

/// Descriptor for `GetTranscriptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTranscriptResponseDescriptor = $convert.base64Decode(
    'ChVHZXRUcmFuc2NyaXB0UmVzcG9uc2USHgoKdHJhbnNjcmlwdBgBIAEoCVIKdHJhbnNjcmlwdA'
    '==');

@$core.Deprecated('Use getDescriptionRequestDescriptor instead')
const GetDescriptionRequest$json = {
  '1': 'GetDescriptionRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `GetDescriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDescriptionRequestDescriptor = $convert.base64Decode(
    'ChVHZXREZXNjcmlwdGlvblJlcXVlc3QSIQoMYXVkaW9ib29rX2lkGAEgASgJUgthdWRpb2Jvb2'
    'tJZA==');

@$core.Deprecated('Use getDescriptionResponseDescriptor instead')
const GetDescriptionResponse$json = {
  '1': 'GetDescriptionResponse',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `GetDescriptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDescriptionResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXREZXNjcmlwdGlvblJlc3BvbnNlEiAKC2Rlc2NyaXB0aW9uGAEgASgJUgtkZXNjcmlwdG'
        'lvbg==');

@$core.Deprecated('Use getAudiobookStatusRequestDescriptor instead')
const GetAudiobookStatusRequest$json = {
  '1': 'GetAudiobookStatusRequest',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
  ],
};

/// Descriptor for `GetAudiobookStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudiobookStatusRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRBdWRpb2Jvb2tTdGF0dXNSZXF1ZXN0EiEKDGF1ZGlvYm9va19pZBgBIAEoCVILYXVkaW'
        '9ib29rSWQ=');

@$core.Deprecated('Use getAudiobookStatusResponseDescriptor instead')
const GetAudiobookStatusResponse$json = {
  '1': 'GetAudiobookStatusResponse',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.shop.v1.MediaStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `GetAudiobookStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudiobookStatusResponseDescriptor =
    $convert.base64Decode(
        'ChpHZXRBdWRpb2Jvb2tTdGF0dXNSZXNwb25zZRIsCgZzdGF0dXMYASABKA4yFC5zaG9wLnYxLk'
        '1lZGlhU3RhdHVzUgZzdGF0dXM=');
