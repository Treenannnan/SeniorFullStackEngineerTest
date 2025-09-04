
import 'package:flutter/material.dart';
import 'pages/index.dart';

const String kServerClientId =
    '225011963709-jqhe548mvechr2d0jkl6ggv2t20pu539.apps.googleusercontent.com';
//const String kServerClientId = '225011963709-sfctohq747eo3igvv07cd5foiiio38ej.apps.googleusercontent.com';

//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

const List<String> kGoogleScopes = <String>[
  'openid',
  '	.../auth/userinfo.email',
  '.../auth/userinfo.profile'
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AuthApp());
}

class AuthApp extends StatefulWidget {
  const AuthApp({super.key});
  @override
  State<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: _navKey,
      home: const IndexPage(googleClientId: kServerClientId, googleScopes: kGoogleScopes,),);
  }
}
