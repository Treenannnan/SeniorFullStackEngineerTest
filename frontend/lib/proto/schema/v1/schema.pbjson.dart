// This is a generated file - do not edit.
//
// Generated from schema/v1/schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use providerDescriptor instead')
const Provider$json = {
  '1': 'Provider',
  '2': [
    {'1': 'PROVIDER_UNSPECIFIED', '2': 0},
    {'1': 'PROVIDER_CUSTOM', '2': 1},
    {'1': 'PROVIDER_GOOGLE', '2': 2},
  ],
};

/// Descriptor for `Provider`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List providerDescriptor = $convert.base64Decode(
    'CghQcm92aWRlchIYChRQUk9WSURFUl9VTlNQRUNJRklFRBAAEhMKD1BST1ZJREVSX0NVU1RPTR'
    'ABEhMKD1BST1ZJREVSX0dPT0dMRRAC');

@$core.Deprecated('Use roleDescriptor instead')
const Role$json = {
  '1': 'Role',
  '2': [
    {'1': 'ROLE_UNSPECIFIED', '2': 0},
    {'1': 'ROLE_USER', '2': 1},
    {'1': 'ROLE_ADMIN', '2': 2},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert.base64Decode(
    'CgRSb2xlEhQKEFJPTEVfVU5TUEVDSUZJRUQQABINCglST0xFX1VTRVIQARIOCgpST0xFX0FETU'
    'lOEAI=');

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

@$core.Deprecated('Use userRecordDescriptor instead')
const UserRecord$json = {
  '1': 'UserRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'provider',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.schema.v1.Provider',
      '10': 'provider'
    },
    {'1': 'email_verified', '3': 4, '4': 1, '5': 8, '10': 'emailVerified'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'password_hash', '3': 7, '4': 1, '5': 12, '10': 'passwordHash'},
    {
      '1': 'role',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.schema.v1.Role',
      '10': 'role'
    },
  ],
};

/// Descriptor for `UserRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRecordDescriptor = $convert.base64Decode(
    'CgpVc2VyUmVjb3JkEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSLwoIcH'
    'JvdmlkZXIYAyABKA4yEy5zY2hlbWEudjEuUHJvdmlkZXJSCHByb3ZpZGVyEiUKDmVtYWlsX3Zl'
    'cmlmaWVkGAQgASgIUg1lbWFpbFZlcmlmaWVkEjkKCmNyZWF0ZWRfYXQYBSABKAsyGi5nb29nbG'
    'UucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgGIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIjCg1wYXNzd29yZF9oYXNoGAcgAS'
    'gMUgxwYXNzd29yZEhhc2gSIwoEcm9sZRgIIAEoDjIPLnNjaGVtYS52MS5Sb2xlUgRyb2xl');

@$core.Deprecated('Use refreshTokenRecordDescriptor instead')
const RefreshTokenRecord$json = {
  '1': 'RefreshTokenRecord',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'expires_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
    {'1': 'revoked', '3': 4, '4': 1, '5': 8, '10': 'revoked'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `RefreshTokenRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRecordDescriptor = $convert.base64Decode(
    'ChJSZWZyZXNoVG9rZW5SZWNvcmQSFAoFdG9rZW4YASABKAlSBXRva2VuEhcKB3VzZXJfaWQYAi'
    'ABKAlSBnVzZXJJZBI5CgpleHBpcmVzX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVz'
    'dGFtcFIJZXhwaXJlc0F0EhgKB3Jldm9rZWQYBCABKAhSB3Jldm9rZWQSOQoKY3JlYXRlZF9hdB'
    'gFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use resetTokenRecordDescriptor instead')
const ResetTokenRecord$json = {
  '1': 'ResetTokenRecord',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'expires_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
  ],
};

/// Descriptor for `ResetTokenRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetTokenRecordDescriptor = $convert.base64Decode(
    'ChBSZXNldFRva2VuUmVjb3JkEhQKBXRva2VuGAEgASgJUgV0b2tlbhIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSOQoKZXhwaXJlc19hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSCWV4cGlyZXNBdA==');

@$core.Deprecated('Use userCreatedDescriptor instead')
const UserCreated$json = {
  '1': 'UserCreated',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'provider',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.schema.v1.Provider',
      '10': 'provider'
    },
    {'1': 'email_verified', '3': 4, '4': 1, '5': 8, '10': 'emailVerified'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `UserCreated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userCreatedDescriptor = $convert.base64Decode(
    'CgtVc2VyQ3JlYXRlZBIOCgJpZBgBIAEoCVICaWQSFAoFZW1haWwYAiABKAlSBWVtYWlsEi8KCH'
    'Byb3ZpZGVyGAMgASgOMhMuc2NoZW1hLnYxLlByb3ZpZGVyUghwcm92aWRlchIlCg5lbWFpbF92'
    'ZXJpZmllZBgEIAEoCFINZW1haWxWZXJpZmllZBI5CgpjcmVhdGVkX2F0GAUgASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use userPasswordChangedDescriptor instead')
const UserPasswordChanged$json = {
  '1': 'UserPasswordChanged',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'changed_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'changedAt'
    },
  ],
};

/// Descriptor for `UserPasswordChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPasswordChangedDescriptor = $convert.base64Decode(
    'ChNVc2VyUGFzc3dvcmRDaGFuZ2VkEg4KAmlkGAEgASgJUgJpZBI5CgpjaGFuZ2VkX2F0GAIgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY2hhbmdlZEF0');

@$core.Deprecated('Use refreshTokenIssuedDescriptor instead')
const RefreshTokenIssued$json = {
  '1': 'RefreshTokenIssued',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'expires_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
    {
      '1': 'issued_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'issuedAt'
    },
  ],
};

/// Descriptor for `RefreshTokenIssued`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenIssuedDescriptor = $convert.base64Decode(
    'ChJSZWZyZXNoVG9rZW5Jc3N1ZWQSFAoFdG9rZW4YASABKAlSBXRva2VuEhcKB3VzZXJfaWQYAi'
    'ABKAlSBnVzZXJJZBI5CgpleHBpcmVzX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVz'
    'dGFtcFIJZXhwaXJlc0F0EjcKCWlzc3VlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSCGlzc3VlZEF0');

@$core.Deprecated('Use refreshTokenRevokedDescriptor instead')
const RefreshTokenRevoked$json = {
  '1': 'RefreshTokenRevoked',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {
      '1': 'revoked_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'revokedAt'
    },
  ],
};

/// Descriptor for `RefreshTokenRevoked`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRevokedDescriptor = $convert.base64Decode(
    'ChNSZWZyZXNoVG9rZW5SZXZva2VkEhQKBXRva2VuGAEgASgJUgV0b2tlbhIXCgd1c2VyX2lkGA'
    'IgASgJUgZ1c2VySWQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24SOQoKcmV2b2tlZF9hdBgEIAEo'
    'CzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXJldm9rZWRBdA==');

@$core.Deprecated('Use audiobookRecordDescriptor instead')
const AudiobookRecord$json = {
  '1': 'AudiobookRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'duration_seconds', '3': 4, '4': 1, '5': 3, '10': 'durationSeconds'},
    {'1': 'price_cents', '3': 5, '4': 1, '5': 3, '10': 'priceCents'},
    {'1': 'cover_url', '3': 6, '4': 1, '5': 9, '10': 'coverUrl'},
    {'1': 'audio_path', '3': 7, '4': 1, '5': 9, '10': 'audioPath'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'ai_description', '3': 9, '4': 1, '5': 9, '10': 'aiDescription'},
    {'1': 'transcript', '3': 10, '4': 1, '5': 9, '10': 'transcript'},
    {
      '1': 'created_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'content_type', '3': 13, '4': 1, '5': 9, '10': 'contentType'},
    {
      '1': 'ai_provider',
      '3': 14,
      '4': 1,
      '5': 14,
      '6': '.schema.v1.AIProvider',
      '10': 'aiProvider'
    },
  ],
};

/// Descriptor for `AudiobookRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audiobookRecordDescriptor = $convert.base64Decode(
    'Cg9BdWRpb2Jvb2tSZWNvcmQSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZR'
    'IWCgZhdXRob3IYAyABKAlSBmF1dGhvchIpChBkdXJhdGlvbl9zZWNvbmRzGAQgASgDUg9kdXJh'
    'dGlvblNlY29uZHMSHwoLcHJpY2VfY2VudHMYBSABKANSCnByaWNlQ2VudHMSGwoJY292ZXJfdX'
    'JsGAYgASgJUghjb3ZlclVybBIdCgphdWRpb19wYXRoGAcgASgJUglhdWRpb1BhdGgSFgoGc3Rh'
    'dHVzGAggASgJUgZzdGF0dXMSJQoOYWlfZGVzY3JpcHRpb24YCSABKAlSDWFpRGVzY3JpcHRpb2'
    '4SHgoKdHJhbnNjcmlwdBgKIAEoCVIKdHJhbnNjcmlwdBI5CgpjcmVhdGVkX2F0GAsgASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDCABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSIQoMY29udGVudF90eXBl'
    'GA0gASgJUgtjb250ZW50VHlwZRI2CgthaV9wcm92aWRlchgOIAEoDjIVLnNjaGVtYS52MS5BSV'
    'Byb3ZpZGVyUgphaVByb3ZpZGVy');

@$core.Deprecated('Use audiobookCategoryRecordDescriptor instead')
const AudiobookCategoryRecord$json = {
  '1': 'AudiobookCategoryRecord',
  '2': [
    {'1': 'audiobook_id', '3': 1, '4': 1, '5': 9, '10': 'audiobookId'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'idx_pos', '3': 3, '4': 1, '5': 5, '10': 'idxPos'},
  ],
};

/// Descriptor for `AudiobookCategoryRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audiobookCategoryRecordDescriptor = $convert.base64Decode(
    'ChdBdWRpb2Jvb2tDYXRlZ29yeVJlY29yZBIhCgxhdWRpb2Jvb2tfaWQYASABKAlSC2F1ZGlvYm'
    '9va0lkEhoKCGNhdGVnb3J5GAIgASgJUghjYXRlZ29yeRIXCgdpZHhfcG9zGAMgASgFUgZpZHhQ'
    'b3M=');

@$core.Deprecated('Use cartItemRecordDescriptor instead')
const CartItemRecord$json = {
  '1': 'CartItemRecord',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'audiobook_id', '3': 2, '4': 1, '5': 9, '10': 'audiobookId'},
    {
      '1': 'created_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `CartItemRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cartItemRecordDescriptor = $convert.base64Decode(
    'Cg5DYXJ0SXRlbVJlY29yZBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSIQoMYXVkaW9ib29rX2'
    'lkGAIgASgJUgthdWRpb2Jvb2tJZBI5CgpjcmVhdGVkX2F0GAMgASgLMhouZ29vZ2xlLnByb3Rv'
    'YnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYBCABKAsyGi5nb29nbGUucH'
    'JvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use orderRecordDescriptor instead')
const OrderRecord$json = {
  '1': 'OrderRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'order_uid', '3': 2, '4': 1, '5': 9, '10': 'orderUid'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'total_cents', '3': 4, '4': 1, '5': 3, '10': 'totalCents'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `OrderRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderRecordDescriptor = $convert.base64Decode(
    'CgtPcmRlclJlY29yZBIOCgJpZBgBIAEoA1ICaWQSGwoJb3JkZXJfdWlkGAIgASgJUghvcmRlcl'
    'VpZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSHwoLdG90YWxfY2VudHMYBCABKANSCnRvdGFs'
    'Q2VudHMSOQoKY3JlYXRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCW'
    'NyZWF0ZWRBdA==');

@$core.Deprecated('Use orderItemRecordDescriptor instead')
const OrderItemRecord$json = {
  '1': 'OrderItemRecord',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 3, '10': 'orderId'},
    {'1': 'audiobook_id', '3': 2, '4': 1, '5': 9, '10': 'audiobookId'},
    {'1': 'price_cents', '3': 3, '4': 1, '5': 3, '10': 'priceCents'},
  ],
};

/// Descriptor for `OrderItemRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderItemRecordDescriptor = $convert.base64Decode(
    'Cg9PcmRlckl0ZW1SZWNvcmQSGQoIb3JkZXJfaWQYASABKANSB29yZGVySWQSIQoMYXVkaW9ib2'
    '9rX2lkGAIgASgJUgthdWRpb2Jvb2tJZBIfCgtwcmljZV9jZW50cxgDIAEoA1IKcHJpY2VDZW50'
    'cw==');

@$core.Deprecated('Use purchaseRecordDescriptor instead')
const PurchaseRecord$json = {
  '1': 'PurchaseRecord',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'audiobook_id', '3': 2, '4': 1, '5': 9, '10': 'audiobookId'},
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

/// Descriptor for `PurchaseRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseRecordDescriptor = $convert.base64Decode(
    'Cg5QdXJjaGFzZVJlY29yZBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSIQoMYXVkaW9ib29rX2'
    'lkGAIgASgJUgthdWRpb2Jvb2tJZBIfCgtwcmljZV9jZW50cxgDIAEoA1IKcHJpY2VDZW50cxI9'
    'CgxwdXJjaGFzZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtwdXJjaG'
    'FzZWRBdA==');
