import 'package:flutter/material.dart';
import 'package:video_player_app/features/auth/login/login_page.dart';

class FlutterBasicApp extends StatefulWidget {
  const FlutterBasicApp({Key? key}) : super(key: key);

  @override
  _FlutterBasicAppState createState() => _FlutterBasicAppState();
}

class _FlutterBasicAppState extends State<FlutterBasicApp> {
  @override
  Widget build(BuildContext context) {
    return   LoginPage();
  }
}
