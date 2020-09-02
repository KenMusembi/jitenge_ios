import 'package:flutter/material.dart';
//import 'package:jitenge/screens/authenticate/sign-up.dart';
import 'package:jitenge/screens/wrapper.dart';

void main() {
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
