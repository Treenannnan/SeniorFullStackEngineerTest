// token_store.dart
import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  static const _kAccess  = 'access_token';
  static const _kRefresh = 'refresh_token';
  static const _kEmail   = 'user_email';

  static String access = "";
  static String refresh = "";
  static String email   = "";

  static Future<void> save(String access, String refresh, String email) async {
    final sp = await SharedPreferences.getInstance();
    access = access;
    refresh = refresh;
    email = email;
    await sp.setString(_kAccess, access);
    await sp.setString(_kRefresh, refresh);
    await sp.setString(_kEmail, email);
  }

  static Future<({String? access, String? refresh, String? email})> load() async {
    final sp = await SharedPreferences.getInstance();
    return (access: sp.getString(_kAccess),
            refresh: sp.getString(_kRefresh),
            email: sp.getString(_kEmail));
  }

  static Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kAccess);
    await sp.remove(_kRefresh);
    await sp.remove(_kEmail);
  }
}
