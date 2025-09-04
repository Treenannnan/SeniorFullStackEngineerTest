import 'package:flutter/material.dart';
import 'package:frontend/widget/setting_popup.dart';
import 'package:frontend/widget/resetpassword_popup.dart';
import 'package:frontend/services/google_auth_service.dart';
import 'dart:async';
import 'dart:convert' show utf8, base64Url, json;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:frontend/api/auth_api.dart';
import 'package:frontend/token_store.dart';
import 'package:frontend/pages/shop.dart';
import 'package:frontend/proto/auth/v1/authentication.pbgrpc.dart' as auth;

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, this.googleClientId, this.googleScopes});

  final String? googleClientId;
  final List<String>? googleScopes;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _emailCtl = TextEditingController(text: 'a@b.com');
  final _passCtl = TextEditingController(text: 'xYz#12345');
  late GoogleAuthService _google;
  late AuthApi _api;

  String host = "127.0.0.1";
  int port = 50051;

  @override
  void initState() {
    super.initState();
    if (widget.googleClientId != null && widget.googleScopes != null) {
      _google = GoogleAuthService(
        serverClientId: widget.googleClientId!,
        scopes: widget.googleScopes!,
      );
    }

    _api = AuthApi(host, port);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _attemptAutoLogin();
    });

    unawaited(
      _google.init(_onGoogleEvent, _onGoogleError),
    );
  }

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    unawaited(_api.close());
    super.dispose();
  }

  void _onGoogleError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('GoogleSignIn error: $e')),
    );
  }

  Future<void> _attemptAutoLogin() async {
    final saved = await TokenStore.load();

    if (saved.refresh != null) {
      await _doRefresh(saved.refresh!);
    }
  }

  Future<void> _doRefresh(String refreshToken) async {
    try {
      final r = await _api.refresh(refreshToken);
      await _doSignIn(r, r.user.email);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Refresh token error: $e'")),
      );
    }
  }

  Future<void> _onGoogleEvent(GoogleSignInAuthenticationEvent ev) async {
    switch (ev) {
      case GoogleSignInAuthenticationEventSignIn():
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Google signed-in as ${ev.user.email}')),
          );
        }
      case GoogleSignInAuthenticationEventSignOut():
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Google signed-out')),
          );
        }
    }
  }

  Future<void> _setting() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const SettingPopup(),
    );
    if (mounted) {
      if (result != null && context.mounted) {
        final _host = result['host'];
        final _port = result['port'];

        if (_host != null && _port != null) {
          setState(() {
            host = _host;
            port = int.parse(_port);
          });

          _api = AuthApi(host, port);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connect to $_host:$_port')),
        );
      }
    }
  }

  Future<void> _doSignIn(auth.AuthResponse auth, String? rawEmail) async {
    try {
      final authEmail = auth.user.email == "google_user@example.com"
          ? rawEmail
          : auth.user.email;

      await TokenStore.save(auth.tokens.accessToken, auth.tokens.refreshToken,
          authEmail ?? "not found");

      if (!mounted) return;
      final role = _extractRole(auth.tokens.accessToken);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "SignIn success: ${authEmail ?? "not found"} role: ${role!}")),
      );

      _goShop(accessToken: auth.tokens.accessToken, userEmail: authEmail);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-In error: $e")),
      );
    }
  }

  Future<void> _doEmailSignUp() async {
    try {
      final r = await _api
          .signUp(_emailCtl.text.trim(), _passCtl.text)
          .timeout(const Duration(seconds: 5));
      await _doSignIn(r, _emailCtl.text.trim());
    } catch (e) {
      if (!mounted) return;
      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Request timed out or connection missing")),
        );

        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email sign-in error: $e")),
      );
    }
  }

  Future<void> _doEmailSignIn() async {
    try {
      final r = await _api
          .signIn(_emailCtl.text.trim(), _passCtl.text)
          .timeout(const Duration(seconds: 5));
      await _doSignIn(r, _emailCtl.text.trim());
    } catch (e) {
      if (!mounted) return;

      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Request timed out or connection missing")),
        );

        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email sign-in error: $e")),
      );
    }
  }

  Future<void> _doGoogleSignIn() async {
    try {
      if (!_google.isSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('This platform does not support google authenticate')),
        );
        return;
      }
      //await _google.signOut();
      final account = await _google.signIn();

      final email = account.email;
      final idToken = account.idToken;

      if (!mounted) return;

      if (email == null || idToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pleace check google client id')),
        );
        return;
      }
      final r =
          await _api.googleSignIn(idToken).timeout(const Duration(seconds: 5));

      await _doSignIn(r, email);
    } catch (e) {
      if (!mounted) return;
      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Request timed out or connection missing")),
        );

        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("google sign-in error: $e")),
      );
    }
  }

  Future<void> _doRequestResetPassword() async {
    try {
      final r = await _api
          .requestPasswordReset(_emailCtl.text.trim())
          .timeout(const Duration(seconds: 5));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Password Reset OK: ${r.ok}")),
      );
    } catch (e) {
      if (!mounted) return;
      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Request timed out or connection missing")),
        );

        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Password Reset error: $e")),
      );
    }
  }

  Future<void> _doResetPassword() async {
    try {
      final result = await showDialog<Map<String, String>>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const ResetPasswordPopup(),
      );
      if (mounted) {
        if (result != null && context.mounted) {
          final token = result['token'];
          final pass = result['pass'];
          final r = await _api
              .resetPassword(token!, pass!)
              .timeout(const Duration(seconds: 5));
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Reset Password OK: ${r.ok}")),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Request timed out or connection missing")),
        );

        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reset Password error: $e")),
      );
    }
  }

  void _goShop({
    required String accessToken,
    required String? userEmail,
  }) {
    final role = _extractRole(accessToken);
    final isAdmin = (role ?? '').toUpperCase() == 'ADMIN';

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ShopPage(
          host: host,
          port: port,
          useGrpcWeb: false,
          accessToken: accessToken,
          isAdmin: isAdmin,
          userEmail: userEmail ?? '-',
        ),
      ),
    );
  }

  String? _extractRole(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return null;
      final payload = parts[1];

      String norm =
          payload.padRight(payload.length + (4 - payload.length % 4) % 4, '=');
      final bytes = base64Url.decode(norm);
      final map = json.decode(utf8.decode(bytes)) as Map<String, dynamic>;
      final role = map['role'];
      if (role is String) return role;
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Books Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting',
            onPressed: _setting,
          ),
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(50, 0, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Welcome", style: TextStyle(fontSize: 16)),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailCtl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passCtl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 1),
              Transform.translate(
                offset: Offset(8, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _doEmailSignUp,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: 2,
                        vertical: 1,
                      ),
                    ),
                    child: const Text(
                      'register',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _doGoogleSignIn,
                      icon: const Icon(Icons.account_circle),
                      label: const Text('Google Sign-In'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 242, 74, 18),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _doEmailSignIn,
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Transform.translate(
                offset: Offset(8, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _doRequestResetPassword,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: 2,
                            vertical: 1,
                          ),
                        ),
                        child: const Text(
                          'request password reset',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: _doResetPassword,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: 2,
                            vertical: 1,
                          ),
                        ),
                        child: const Text(
                          'password reset',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
