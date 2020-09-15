import 'package:flutter/material.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';
import 'package:jitenge/screens/users/reporting.dart';
import 'package:jitenge/screens/users/userlist.dart';
import 'package:jitenge/screens/users/resources.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(child: SignIn());
  }
}
