import 'package:grpc/grpc_web.dart' as grpc_web;
import '../proto/auth/v1/authentication.pbgrpc.dart' as auth;

class AuthApi {
  final String host;
  final int port;
  late final grpc_web.GrpcWebClientChannel _ch;
  late final auth.AuthenticationServiceClient _client;

  AuthApi(this.host, this.port) {
    _ch = grpc_web.GrpcWebClientChannel.xhr(Uri.parse('http://$host:$port'));
    _client = auth.AuthenticationServiceClient(_ch);
  }

  Future<auth.AuthResponse> signUp(String email, String password) =>
      _client.signUp(auth.SignUpRequest(email: email, password: password));

  Future<auth.AuthResponse> signIn(String email, String password) =>
      _client.signIn(auth.SignInRequest(email: email, password: password));

  Future<auth.AuthResponse> googleSignIn(String idToken) =>
      _client.googleSignIn(auth.GoogleSignInRequest(idToken: idToken));

  Future<auth.AuthResponse> refresh(String refreshToken) => _client
      .refreshToken(auth.RefreshTokenRequest(refreshToken: refreshToken));

  Future<auth.ValidateTokenResponse> validate(String accessToken) => _client
      .validateToken(auth.ValidateTokenRequest(accessToken: accessToken));

  Future<auth.RequestPasswordResetResponse> requestPasswordReset(
          String email) =>
      _client
          .requestPasswordReset(auth.RequestPasswordResetRequest(email: email));

  Future<auth.ResetPasswordResponse> resetPassword(
          String resetToken, String newPassword) =>
      _client.resetPassword(auth.ResetPasswordRequest(
          resetToken: resetToken, newPassword: newPassword));

  Future<void> revoke(String refreshToken) async {
    await _client
        .revokeToken(auth.RevokeTokenRequest(refreshToken: refreshToken));
  }

  Future<void> close() async {
    // gRPC-Web ไม่มี shutdown
  }
}
