import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';

import 'package:jitenge/screens/users/userlist.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;
import 'followUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Report extends StatefulWidget {
  final int clientId;
  String firstName;
  Report({Key key, this.clientId, this.firstName}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  UserList character;
  String thermalGun;
  String fever;
  String cough;
  String difficultBreathing;
  bool _disable = true;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController bodytempController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  FollowUp _user;

  @override
  void initState() {
    int clientId = widget.clientId;
    int day;
    String bodyTemp;
    String comment;
    _showDialog(difficultBreathing, fever, clientId, thermalGun, cough,
        bodyTemp, day, comment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int clientId = widget.clientId;
    String firstName = widget.firstName;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jitenge - Self Report'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => _exitApp(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 40.0, 15.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/jitenge.png'),
                          backgroundColor: Colors.white,
                          radius: 45.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Emergency? Call EOC now.'),
                      SizedBox(height: 10.0),
                      RaisedButton.icon(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0)), //this right here
                                child: Container(
                                  height: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 10.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Emergency Contacts.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //letterSpacing: 2.0,
                                            fontSize: 22.0,
                                            fontFamily: 'Calibri',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                            'In case you or any of your contacts develop any symptoms please contact the Emergency operations Centre (EOC) with any of the following numbers.'),
                                        Row(
                                          children: <Widget>[
                                            Text('Hotline 1 ' +
                                                '\n' +
                                                '\n' +
                                                '0729471414'),
                                            SizedBox(width: 80),
                                            SizedBox(
                                              width: 60.0,
                                              child: RaisedButton(
                                                onPressed: () =>
                                                    UrlLauncher.launch(
                                                        "tel:+254729471414"),
                                                color: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.phone,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text('Hotline 2' +
                                                '\n' +
                                                '\n' +
                                                '0732353535'),
                                            SizedBox(width: 80),
                                            SizedBox(
                                              width: 60.0,
                                              child: RaisedButton(
                                                onPressed: () =>
                                                    UrlLauncher.launch(
                                                        "tel:+254732353535"),
                                                color: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.phone,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text('Hotline 3 (Toll Free)' +
                                                '\n' +
                                                '\n' +
                                                '0800721316'),
                                            SizedBox(width: 40),
                                            SizedBox(
                                              width: 60.0,
                                              child: RaisedButton(
                                                onPressed: () =>
                                                    UrlLauncher.launch(
                                                        "tel:0800721316"),
                                                color: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.phone,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        color: Colors.red,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                          //side: BorderSide(color: Colors.white)
                        ),
                        icon: Icon(Icons.phone),
                        //borderRadius: BorderRadius.circular(18.0),
                        splashColor: Colors.pink,
                        label: Text('Call EOC'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Jitenge-MOH Self Reporting',
              style: TextStyle(
                color: Colors.black,
                //letterSpacing: 2.0,
                fontSize: 22.0,
                fontFamily: 'Calibri',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 5.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        firstName == null
                            ? Container()
                            : Text('Reporting for $firstName'),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Please enter the fields below.',
                          style: TextStyle(
                            color: Colors.grey[500],
                            //letterSpacing: 2.0,
                            fontSize: 14.0,
                            fontFamily: 'Calibri',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _user == null
                            ? Container()
                            : Text(
                                'You have successfully reported for $firstName. That is it for today.'),
                        Form(
                          key: _formkey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                    'Do you have a thermal gun or a thermometer?'),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'YES',
                                        groupValue: thermalGun,
                                        title: Text("YES"),
                                        onChanged: (newValue) => setState(() {
                                          thermalGun = newValue;
                                          _disable = true;
                                        }),
                                        //setState(() => thermalGun = newValue),
                                        //activeColor: Colors.red,
                                        //selected: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'NO',
                                        groupValue: thermalGun,
                                        title: Text("NO"),
                                        onChanged: (newValue) => setState(() {
                                          thermalGun = newValue;
                                          _disable = false;
                                        }),
                                        //activeColor: Colors.red,
                                        //selected: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible:
                                      _disable, // true makes TextFormField disabled and vice-versa
                                  child: TextField(
                                    enabled: _disable,
                                    controller: bodytempController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'What is your body temperature? eg. 36.5'),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Have you developed a fever?'),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'YES',
                                        groupValue: fever,
                                        title: Text("YES"),
                                        onChanged: (newValue) =>
                                            setState(() => fever = newValue),
                                        //activeColor: Colors.red,
                                        //selected: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'NO',
                                        groupValue: fever,
                                        title: Text("NO"),
                                        onChanged: (newValue) =>
                                            setState(() => fever = newValue),
                                        //activeColor: Colors.red,
                                        //selected: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Text('Have you developed a cough?'),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'YES',
                                        groupValue: cough,
                                        title: Text("YES"),
                                        onChanged: (newValue) =>
                                            setState(() => cough = newValue),
                                        //activeColor: Colors.red,
                                        //selected: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'NO',
                                        groupValue: cough,
                                        title: Text("NO"),
                                        onChanged: (newValue) =>
                                            setState(() => cough = newValue),
                                        //activeColor: Colors.red,
                                        //selected: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Text('Do you have difficulty in breathing?'),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'YES',
                                        groupValue: difficultBreathing,
                                        title: Text("YES"),
                                        onChanged: (newValue) => setState(() =>
                                            difficultBreathing = newValue),
                                        //activeColor: Colors.red,
                                        //selected: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 'NO',
                                        groupValue: difficultBreathing,
                                        title: Text("NO"),
                                        onChanged: (newValue) => setState(() =>
                                            difficultBreathing = newValue),
                                        //activeColor: Colors.red,
                                        //selected: true,
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Please provide any comment.'),
                                ),
                                SizedBox(height: 10.0),
                                FloatingActionButton.extended(
                                  label: Text('Submit'),
                                  onPressed: () async {
                                    final int day = 2;
                                    //clientId = 92349;
                                    final comment = commentController.text;
                                    final bodyTemp = bodytempController.text;
                                    final FollowUp followup = await _showDialog(
                                        difficultBreathing,
                                        fever,
                                        clientId,
                                        thermalGun,
                                        cough,
                                        bodyTemp,
                                        day,
                                        comment);
                                    setState(() {
                                      _user = followup;
                                    });
                                  },
                                  tooltip: "Submit Follow Up Data",
                                  //icon: Icon(Icons.add)
                                ),
                                SizedBox(height: 10.0),
                              ]),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(height: 3.0),

            // Divider(color: Colors.black12),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.home, color: Colors.blue[400]),
            label: Text(
              'Home',
              style: TextStyle(
                  color: Colors.blue[400],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              _exitApp(context);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.blue[400]),
            label: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.blue[400],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: missing_return
Future<FollowUp> _showDialog(
    String difficultBreathing,
    String fever,
    int clientId,
    String thermalGun,
    String cough,
    String bodyTemp,
    int day,
    String comment) async {
  final String apiUrl = 'http://ears-covid.mhealthkenya.co.ke/api/response';
  try {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOnsiaWQiOjEsInBob25lX251bWJlciI6IisyNTQ3MjM3ODMwMjEiLCJmaXJzdF9uYW1lIjoicGF0aWVudCIsImNyZWF0ZWRfYXQiOiIyMDIwLTAzLTAxIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wMSIsInVwZGF0ZWRBdCI6IjIwMjAtMDMtMTQifSwiaWF0IjoxNTg0MTkxNjUzfQ.dEgJySZ33Mi4jE6lodOgbsTjKMuT7xfW-EkhHKtv-Oc";

    final response = await http.post(apiUrl, headers: {
      //'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
      //HttpHeaders.authorizationHeader:
      //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOnsiaWQiOjEsInBob25lX251bWJlciI6IisyNTQ3MjM3ODMwMjEiLCJmaXJzdF9uYW1lIjoicGF0aWVudCIsImNyZWF0ZWRfYXQiOiIyMDIwLTAzLTAxIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wMSIsInVwZGF0ZWRBdCI6IjIwMjAtMDMtMTQifSwiaWF0IjoxNTg0MTkxNjUzfQ.dEgJySZ33Mi4jE6lodOgbsTjKMuT7xfW-EkhHKtv-Oc"
    }, body: {
      "client_id": json.encode(clientId),
      "thermal_gun": thermalGun,
      "body_temp": bodyTemp,
      "fever": fever,
      "cough": cough,
      "difficult_breathing": difficultBreathing,
      "day": json.encode(day),
      "comment": comment
    });
    //FollowUp followUp;

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      print(clientId);
      print(bodyTemp);
      //print('bodyTemp');
      print(fever);
      print(cough);
      print(difficultBreathing);
      print(day);
      print(comment);
      if (responseString.contains("true")) {
        Fluttertoast.showToast(
            msg: "Successfully Submited your day report. \n Check in tomorrow",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (responseString.contains('completed') ||
          responseString.contains('zilikamilika')) {
        Fluttertoast.showToast(
            msg: "Your 14 days of reporting were completed. Thank you",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (responseString.contains('already recorded')) {
        Fluttertoast.showToast(
            msg:
                "Your response for day 7 was already recorded more than once and your next submission is expected tomorrow. For any further information kindly call EOC.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "You are not authorised to access this resource",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return followUpFromJson(responseString);
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
  } catch (error) {}
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Logout from Jitenge.'),
          content: Text('Are you sure you want to log out?'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  //arguments: {},
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (Route<dynamic> route) => false,
                );
                SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
                //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
