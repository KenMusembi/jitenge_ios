import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';
import 'package:jitenge/screens/users/userlist.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;
import 'followUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test extends StatefulWidget {
  //final int clientId;
  Test({
    Key key,
  }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    FollowUp _user;
    // TODO: implement build
    return Center(
      child: Row(
        children: [
          _user == null
              ? Container()
              : Text(
                  'Your temperature is ${_user.success}  and your comment is ${_user.message}.'),
          FloatingActionButton.extended(
            label: Text('Submit'),
            onPressed: () async {
              final int day = 2;
              int clientId = 92349;

              final FollowUp followup = await _showDialog();
              setState(() {
                _user = followup;
              });
            },
            tooltip: "Submit Follow Up Data",
            //icon: Icon(Icons.add)
          ),
        ],
      ),
    );
    //throw UnimplementedError();
  }
}

Future<FollowUp> _showDialog() async {
  final String apiUrl = 'http://ears-covid.mhealthkenya.co.ke/api/response';
  try {
    final response = await http.post(apiUrl, headers: {
      HttpHeaders.authorizationHeader:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOnsiaWQiOjEsInBob25lX251bWJlciI6IisyNTQ3MjM3ODMwMjEiLCJmaXJzdF9uYW1lIjoicGF0aWVudCIsImNyZWF0ZWRfYXQiOiIyMDIwLTAzLTAxIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wMSIsInVwZGF0ZWRBdCI6IjIwMjAtMDMtMTQifSwiaWF0IjoxNTg0MTkxNjUzfQ.dEgJySZ33Mi4jE6lodOgbsTjKMuT7xfW-EkhHKtv-Oc"
    }, body: {
      "client_id": json.encode(92349),
      "thermal_gun": 'Yes',
      "body_temp": 'Yes',
      "fever": 'Yes',
      "cough": 'Yes',
      "difficult_breathing": 'Yes',
      "day": json.encode(2),
      "comment": 'comment'
    });
    //FollowUp followUp;

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      //print(passport_no);
      return followUpFromJson(responseString);

      //return followUpFromJson(responseString);
    } else {
      Fluttertoast.showToast(
          msg: "Error! Could not submit Report, Kindly try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  } catch (error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
