import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:jitenge/screens/authenticate/sign-up.dart';
import 'package:jitenge/screens/wrapper.dart';

import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
