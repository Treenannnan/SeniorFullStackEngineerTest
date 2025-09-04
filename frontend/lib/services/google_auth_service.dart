import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService({
    required this.serverClientId,
    required this.scopes,
  });

  final String serverClientId;
  final List<String> scopes;

  Future<void> init(
    void Function(GoogleSignInAuthenticationEvent event) onEvent,
    void Function(Object error) onError,
  ) async {
    await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
    GoogleSignIn.instance.authenticationEvents.listen(onEvent).onError(onError);
  }

  Stream<GoogleSignInAuthenticationEvent> get events =>
      GoogleSignIn.instance.authenticationEvents;

  bool get isSupported => GoogleSignIn.instance.supportsAuthenticate();

  Future<({String? idToken, String? email})> signIn() async {
    await GoogleSignIn.instance.disconnect();

    final account = await GoogleSignIn.instance.authenticate(
      scopeHint: scopes,
    );
    final authn = account.authentication;
    return (idToken: authn.idToken, email: account.email);
  }

  Future<void> signOut() => GoogleSignIn.instance.disconnect();
}
