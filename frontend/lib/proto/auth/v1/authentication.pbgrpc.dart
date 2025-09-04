// This is a generated file - do not edit.
//
// Generated from auth/v1/authentication.proto.

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

import 'authentication.pb.dart' as $0;

export 'authentication.pb.dart';

@$pb.GrpcServiceName('auth.v1.AuthenticationService')
class AuthenticationServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AuthenticationServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.AuthResponse> signUp(
    $0.SignUpRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signUp, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> signIn(
    $0.SignInRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signIn, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> googleSignIn(
    $0.GoogleSignInRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$googleSignIn, request, options: options);
  }

  $grpc.ResponseFuture<$0.AuthResponse> refreshToken(
    $0.RefreshTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateTokenResponse> validateToken(
    $0.ValidateTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestPasswordResetResponse> requestPasswordReset(
    $0.RequestPasswordResetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResetPasswordResponse> resetPassword(
    $0.ResetPasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.RevokeTokenResponse> revokeToken(
    $0.RevokeTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$revokeToken, request, options: options);
  }

  // method descriptors

  static final _$signUp = $grpc.ClientMethod<$0.SignUpRequest, $0.AuthResponse>(
      '/auth.v1.AuthenticationService/SignUp',
      ($0.SignUpRequest value) => value.writeToBuffer(),
      $0.AuthResponse.fromBuffer);
  static final _$signIn = $grpc.ClientMethod<$0.SignInRequest, $0.AuthResponse>(
      '/auth.v1.AuthenticationService/SignIn',
      ($0.SignInRequest value) => value.writeToBuffer(),
      $0.AuthResponse.fromBuffer);
  static final _$googleSignIn =
      $grpc.ClientMethod<$0.GoogleSignInRequest, $0.AuthResponse>(
          '/auth.v1.AuthenticationService/GoogleSignIn',
          ($0.GoogleSignInRequest value) => value.writeToBuffer(),
          $0.AuthResponse.fromBuffer);
  static final _$refreshToken =
      $grpc.ClientMethod<$0.RefreshTokenRequest, $0.AuthResponse>(
          '/auth.v1.AuthenticationService/RefreshToken',
          ($0.RefreshTokenRequest value) => value.writeToBuffer(),
          $0.AuthResponse.fromBuffer);
  static final _$validateToken =
      $grpc.ClientMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
          '/auth.v1.AuthenticationService/ValidateToken',
          ($0.ValidateTokenRequest value) => value.writeToBuffer(),
          $0.ValidateTokenResponse.fromBuffer);
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $0.RequestPasswordResetRequest, $0.RequestPasswordResetResponse>(
      '/auth.v1.AuthenticationService/RequestPasswordReset',
      ($0.RequestPasswordResetRequest value) => value.writeToBuffer(),
      $0.RequestPasswordResetResponse.fromBuffer);
  static final _$resetPassword =
      $grpc.ClientMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
          '/auth.v1.AuthenticationService/ResetPassword',
          ($0.ResetPasswordRequest value) => value.writeToBuffer(),
          $0.ResetPasswordResponse.fromBuffer);
  static final _$revokeToken =
      $grpc.ClientMethod<$0.RevokeTokenRequest, $0.RevokeTokenResponse>(
          '/auth.v1.AuthenticationService/RevokeToken',
          ($0.RevokeTokenRequest value) => value.writeToBuffer(),
          $0.RevokeTokenResponse.fromBuffer);
}

@$pb.GrpcServiceName('auth.v1.AuthenticationService')
abstract class AuthenticationServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthenticationService';

  AuthenticationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignUpRequest, $0.AuthResponse>(
        'SignUp',
        signUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignUpRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignInRequest, $0.AuthResponse>(
        'SignIn',
        signIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignInRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GoogleSignInRequest, $0.AuthResponse>(
        'GoogleSignIn',
        googleSignIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GoogleSignInRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefreshTokenRequest, $0.AuthResponse>(
        'RefreshToken',
        refreshToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshTokenRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
            'ValidateToken',
            validateToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ValidateTokenRequest.fromBuffer(value),
            ($0.ValidateTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPasswordResetRequest,
            $0.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPasswordResetRequest.fromBuffer(value),
        ($0.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
            'ResetPassword',
            resetPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ResetPasswordRequest.fromBuffer(value),
            ($0.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RevokeTokenRequest, $0.RevokeTokenResponse>(
            'RevokeToken',
            revokeToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RevokeTokenRequest.fromBuffer(value),
            ($0.RevokeTokenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthResponse> signUp_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SignUpRequest> $request) async {
    return signUp($call, await $request);
  }

  $async.Future<$0.AuthResponse> signUp(
      $grpc.ServiceCall call, $0.SignUpRequest request);

  $async.Future<$0.AuthResponse> signIn_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SignInRequest> $request) async {
    return signIn($call, await $request);
  }

  $async.Future<$0.AuthResponse> signIn(
      $grpc.ServiceCall call, $0.SignInRequest request);

  $async.Future<$0.AuthResponse> googleSignIn_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GoogleSignInRequest> $request) async {
    return googleSignIn($call, await $request);
  }

  $async.Future<$0.AuthResponse> googleSignIn(
      $grpc.ServiceCall call, $0.GoogleSignInRequest request);

  $async.Future<$0.AuthResponse> refreshToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RefreshTokenRequest> $request) async {
    return refreshToken($call, await $request);
  }

  $async.Future<$0.AuthResponse> refreshToken(
      $grpc.ServiceCall call, $0.RefreshTokenRequest request);

  $async.Future<$0.ValidateTokenResponse> validateToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidateTokenRequest> $request) async {
    return validateToken($call, await $request);
  }

  $async.Future<$0.ValidateTokenResponse> validateToken(
      $grpc.ServiceCall call, $0.ValidateTokenRequest request);

  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestPasswordResetRequest> $request) async {
    return requestPasswordReset($call, await $request);
  }

  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $0.RequestPasswordResetRequest request);

  $async.Future<$0.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResetPasswordRequest> $request) async {
    return resetPassword($call, await $request);
  }

  $async.Future<$0.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $0.ResetPasswordRequest request);

  $async.Future<$0.RevokeTokenResponse> revokeToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RevokeTokenRequest> $request) async {
    return revokeToken($call, await $request);
  }

  $async.Future<$0.RevokeTokenResponse> revokeToken(
      $grpc.ServiceCall call, $0.RevokeTokenRequest request);
}
