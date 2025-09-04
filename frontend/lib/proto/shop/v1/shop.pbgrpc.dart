// This is a generated file - do not edit.
//
// Generated from shop/v1/shop.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/empty.pb.dart' as $1;
import 'shop.pb.dart' as $0;

export 'shop.pb.dart';

@$pb.GrpcServiceName('shop.v1.ShopService')
class ShopServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ShopServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.UploadAudiobookResponse> uploadAudiobook(
    $async.Stream<$0.UploadChunk> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$uploadAudiobook, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.CreateUploadUrlResponse> createUploadURL(
    $0.CreateUploadUrlRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createUploadURL, request, options: options);
  }

  $grpc.ResponseFuture<$0.CompleteUploadResponse> completeUpload(
    $0.CompleteUploadRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeUpload, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateUploadUrlResponse> getUploadURL(
    $0.GetUploadURLRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUploadURL, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListAudiobooksResponse> listAudiobooks(
    $0.ListAudiobooksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listAudiobooks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAudiobookResponse> getAudiobook(
    $0.GetAudiobookRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAudiobook, request, options: options);
  }

  $grpc.ResponseFuture<$0.ViewCartResponse> viewCart(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$viewCart, request, options: options);
  }

  $grpc.ResponseFuture<$0.ViewCartResponse> addToCart(
    $0.AddToCartRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addToCart, request, options: options);
  }

  $grpc.ResponseFuture<$0.ViewCartResponse> removeFromCart(
    $0.RemoveFromCartRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeFromCart, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckoutResponse> checkout(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPurchasesResponse> listPurchases(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDownloadURLResponse> getDownloadURL(
    $0.GetDownloadURLRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDownloadURL, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTranscriptResponse> getTranscript(
    $0.GetTranscriptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTranscript, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDescriptionResponse> getDescription(
    $0.GetDescriptionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDescription, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAudiobookStatusResponse> getAudiobookStatus(
    $0.GetAudiobookStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAudiobookStatus, request, options: options);
  }

  // method descriptors

  static final _$uploadAudiobook =
      $grpc.ClientMethod<$0.UploadChunk, $0.UploadAudiobookResponse>(
          '/shop.v1.ShopService/UploadAudiobook',
          ($0.UploadChunk value) => value.writeToBuffer(),
          $0.UploadAudiobookResponse.fromBuffer);
  static final _$createUploadURL =
      $grpc.ClientMethod<$0.CreateUploadUrlRequest, $0.CreateUploadUrlResponse>(
          '/shop.v1.ShopService/CreateUploadURL',
          ($0.CreateUploadUrlRequest value) => value.writeToBuffer(),
          $0.CreateUploadUrlResponse.fromBuffer);
  static final _$completeUpload =
      $grpc.ClientMethod<$0.CompleteUploadRequest, $0.CompleteUploadResponse>(
          '/shop.v1.ShopService/CompleteUpload',
          ($0.CompleteUploadRequest value) => value.writeToBuffer(),
          $0.CompleteUploadResponse.fromBuffer);
  static final _$getUploadURL =
      $grpc.ClientMethod<$0.GetUploadURLRequest, $0.CreateUploadUrlResponse>(
          '/shop.v1.ShopService/GetUploadURL',
          ($0.GetUploadURLRequest value) => value.writeToBuffer(),
          $0.CreateUploadUrlResponse.fromBuffer);
  static final _$listAudiobooks =
      $grpc.ClientMethod<$0.ListAudiobooksRequest, $0.ListAudiobooksResponse>(
          '/shop.v1.ShopService/ListAudiobooks',
          ($0.ListAudiobooksRequest value) => value.writeToBuffer(),
          $0.ListAudiobooksResponse.fromBuffer);
  static final _$getAudiobook =
      $grpc.ClientMethod<$0.GetAudiobookRequest, $0.GetAudiobookResponse>(
          '/shop.v1.ShopService/GetAudiobook',
          ($0.GetAudiobookRequest value) => value.writeToBuffer(),
          $0.GetAudiobookResponse.fromBuffer);
  static final _$viewCart = $grpc.ClientMethod<$1.Empty, $0.ViewCartResponse>(
      '/shop.v1.ShopService/ViewCart',
      ($1.Empty value) => value.writeToBuffer(),
      $0.ViewCartResponse.fromBuffer);
  static final _$addToCart =
      $grpc.ClientMethod<$0.AddToCartRequest, $0.ViewCartResponse>(
          '/shop.v1.ShopService/AddToCart',
          ($0.AddToCartRequest value) => value.writeToBuffer(),
          $0.ViewCartResponse.fromBuffer);
  static final _$removeFromCart =
      $grpc.ClientMethod<$0.RemoveFromCartRequest, $0.ViewCartResponse>(
          '/shop.v1.ShopService/RemoveFromCart',
          ($0.RemoveFromCartRequest value) => value.writeToBuffer(),
          $0.ViewCartResponse.fromBuffer);
  static final _$checkout = $grpc.ClientMethod<$1.Empty, $0.CheckoutResponse>(
      '/shop.v1.ShopService/Checkout',
      ($1.Empty value) => value.writeToBuffer(),
      $0.CheckoutResponse.fromBuffer);
  static final _$listPurchases =
      $grpc.ClientMethod<$1.Empty, $0.ListPurchasesResponse>(
          '/shop.v1.ShopService/ListPurchases',
          ($1.Empty value) => value.writeToBuffer(),
          $0.ListPurchasesResponse.fromBuffer);
  static final _$getDownloadURL =
      $grpc.ClientMethod<$0.GetDownloadURLRequest, $0.GetDownloadURLResponse>(
          '/shop.v1.ShopService/GetDownloadURL',
          ($0.GetDownloadURLRequest value) => value.writeToBuffer(),
          $0.GetDownloadURLResponse.fromBuffer);
  static final _$getTranscript =
      $grpc.ClientMethod<$0.GetTranscriptRequest, $0.GetTranscriptResponse>(
          '/shop.v1.ShopService/GetTranscript',
          ($0.GetTranscriptRequest value) => value.writeToBuffer(),
          $0.GetTranscriptResponse.fromBuffer);
  static final _$getDescription =
      $grpc.ClientMethod<$0.GetDescriptionRequest, $0.GetDescriptionResponse>(
          '/shop.v1.ShopService/GetDescription',
          ($0.GetDescriptionRequest value) => value.writeToBuffer(),
          $0.GetDescriptionResponse.fromBuffer);
  static final _$getAudiobookStatus = $grpc.ClientMethod<
          $0.GetAudiobookStatusRequest, $0.GetAudiobookStatusResponse>(
      '/shop.v1.ShopService/GetAudiobookStatus',
      ($0.GetAudiobookStatusRequest value) => value.writeToBuffer(),
      $0.GetAudiobookStatusResponse.fromBuffer);
}

@$pb.GrpcServiceName('shop.v1.ShopService')
abstract class ShopServiceBase extends $grpc.Service {
  $core.String get $name => 'shop.v1.ShopService';

  ShopServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UploadChunk, $0.UploadAudiobookResponse>(
        'UploadAudiobook',
        uploadAudiobook,
        true,
        false,
        ($core.List<$core.int> value) => $0.UploadChunk.fromBuffer(value),
        ($0.UploadAudiobookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUploadUrlRequest,
            $0.CreateUploadUrlResponse>(
        'CreateUploadURL',
        createUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateUploadUrlRequest.fromBuffer(value),
        ($0.CreateUploadUrlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteUploadRequest,
            $0.CompleteUploadResponse>(
        'CompleteUpload',
        completeUpload_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteUploadRequest.fromBuffer(value),
        ($0.CompleteUploadResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUploadURLRequest, $0.CreateUploadUrlResponse>(
            'GetUploadURL',
            getUploadURL_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUploadURLRequest.fromBuffer(value),
            ($0.CreateUploadUrlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAudiobooksRequest,
            $0.ListAudiobooksResponse>(
        'ListAudiobooks',
        listAudiobooks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListAudiobooksRequest.fromBuffer(value),
        ($0.ListAudiobooksResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetAudiobookRequest, $0.GetAudiobookResponse>(
            'GetAudiobook',
            getAudiobook_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetAudiobookRequest.fromBuffer(value),
            ($0.GetAudiobookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ViewCartResponse>(
        'ViewCart',
        viewCart_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ViewCartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddToCartRequest, $0.ViewCartResponse>(
        'AddToCart',
        addToCart_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddToCartRequest.fromBuffer(value),
        ($0.ViewCartResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RemoveFromCartRequest, $0.ViewCartResponse>(
            'RemoveFromCart',
            removeFromCart_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RemoveFromCartRequest.fromBuffer(value),
            ($0.ViewCartResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.CheckoutResponse>(
        'Checkout',
        checkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.CheckoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ListPurchasesResponse>(
        'ListPurchases',
        listPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ListPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDownloadURLRequest,
            $0.GetDownloadURLResponse>(
        'GetDownloadURL',
        getDownloadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDownloadURLRequest.fromBuffer(value),
        ($0.GetDownloadURLResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTranscriptRequest, $0.GetTranscriptResponse>(
            'GetTranscript',
            getTranscript_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTranscriptRequest.fromBuffer(value),
            ($0.GetTranscriptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDescriptionRequest,
            $0.GetDescriptionResponse>(
        'GetDescription',
        getDescription_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDescriptionRequest.fromBuffer(value),
        ($0.GetDescriptionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAudiobookStatusRequest,
            $0.GetAudiobookStatusResponse>(
        'GetAudiobookStatus',
        getAudiobookStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAudiobookStatusRequest.fromBuffer(value),
        ($0.GetAudiobookStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UploadAudiobookResponse> uploadAudiobook(
      $grpc.ServiceCall call, $async.Stream<$0.UploadChunk> request);

  $async.Future<$0.CreateUploadUrlResponse> createUploadURL_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateUploadUrlRequest> $request) async {
    return createUploadURL($call, await $request);
  }

  $async.Future<$0.CreateUploadUrlResponse> createUploadURL(
      $grpc.ServiceCall call, $0.CreateUploadUrlRequest request);

  $async.Future<$0.CompleteUploadResponse> completeUpload_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteUploadRequest> $request) async {
    return completeUpload($call, await $request);
  }

  $async.Future<$0.CompleteUploadResponse> completeUpload(
      $grpc.ServiceCall call, $0.CompleteUploadRequest request);

  $async.Future<$0.CreateUploadUrlResponse> getUploadURL_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUploadURLRequest> $request) async {
    return getUploadURL($call, await $request);
  }

  $async.Future<$0.CreateUploadUrlResponse> getUploadURL(
      $grpc.ServiceCall call, $0.GetUploadURLRequest request);

  $async.Future<$0.ListAudiobooksResponse> listAudiobooks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListAudiobooksRequest> $request) async {
    return listAudiobooks($call, await $request);
  }

  $async.Future<$0.ListAudiobooksResponse> listAudiobooks(
      $grpc.ServiceCall call, $0.ListAudiobooksRequest request);

  $async.Future<$0.GetAudiobookResponse> getAudiobook_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAudiobookRequest> $request) async {
    return getAudiobook($call, await $request);
  }

  $async.Future<$0.GetAudiobookResponse> getAudiobook(
      $grpc.ServiceCall call, $0.GetAudiobookRequest request);

  $async.Future<$0.ViewCartResponse> viewCart_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return viewCart($call, await $request);
  }

  $async.Future<$0.ViewCartResponse> viewCart(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.ViewCartResponse> addToCart_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AddToCartRequest> $request) async {
    return addToCart($call, await $request);
  }

  $async.Future<$0.ViewCartResponse> addToCart(
      $grpc.ServiceCall call, $0.AddToCartRequest request);

  $async.Future<$0.ViewCartResponse> removeFromCart_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RemoveFromCartRequest> $request) async {
    return removeFromCart($call, await $request);
  }

  $async.Future<$0.ViewCartResponse> removeFromCart(
      $grpc.ServiceCall call, $0.RemoveFromCartRequest request);

  $async.Future<$0.CheckoutResponse> checkout_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return checkout($call, await $request);
  }

  $async.Future<$0.CheckoutResponse> checkout(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.ListPurchasesResponse> listPurchases_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return listPurchases($call, await $request);
  }

  $async.Future<$0.ListPurchasesResponse> listPurchases(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.GetDownloadURLResponse> getDownloadURL_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDownloadURLRequest> $request) async {
    return getDownloadURL($call, await $request);
  }

  $async.Future<$0.GetDownloadURLResponse> getDownloadURL(
      $grpc.ServiceCall call, $0.GetDownloadURLRequest request);

  $async.Future<$0.GetTranscriptResponse> getTranscript_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTranscriptRequest> $request) async {
    return getTranscript($call, await $request);
  }

  $async.Future<$0.GetTranscriptResponse> getTranscript(
      $grpc.ServiceCall call, $0.GetTranscriptRequest request);

  $async.Future<$0.GetDescriptionResponse> getDescription_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDescriptionRequest> $request) async {
    return getDescription($call, await $request);
  }

  $async.Future<$0.GetDescriptionResponse> getDescription(
      $grpc.ServiceCall call, $0.GetDescriptionRequest request);

  $async.Future<$0.GetAudiobookStatusResponse> getAudiobookStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAudiobookStatusRequest> $request) async {
    return getAudiobookStatus($call, await $request);
  }

  $async.Future<$0.GetAudiobookStatusResponse> getAudiobookStatus(
      $grpc.ServiceCall call, $0.GetAudiobookStatusRequest request);
}
