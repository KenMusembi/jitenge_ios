import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';

import 'package:jitenge/screens/users/reporting.dart';
import 'package:jitenge/screens/users/userdata.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:http/http.dart' as http;
import 'userdata.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'resources.dart';

enum SingingCharacter { report_symptoms, show_qr }
String character = 'report_symptoms';

Future<List<Client>> fetchUser(phone_no) async {
  final response = await http
      .get('https://ears.health.go.ke/quarantine_contacts/+$phone_no');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    //return clientFromJson(json.decode(response.body));
    return List<Client>.from(
        json.decode(response.body).map((x) => Client.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to find user');
  }
}

void main() {
  runApp(
    new UserList(),
  );
}

class UserList extends StatefulWidget {
  final String phone_no;
  final int client_id;
  //const UserList(this.phone_no);
  UserList({Key key, int language, this.phone_no, this.client_id})
      : super(key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List<Client>> _clients;
  //Client _user;
  bool _loading;
  int _currentIndex = 0;
  final tabs = [
    Center(child: Text('Home')),
    Center(child: Text('Resources')),
  ];

  @override
  void initState() {
    String phone_no = widget.phone_no;
    int client_id = widget.client_id;
    _clients = fetchUser(phone_no);

    if (client_id == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }

    Fluttertoast.showToast(
        msg: "Login Successfull.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String phone_no = widget.phone_no;
    int client_id = widget.client_id;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jitenge - Select User'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => _exitApp(context)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 5.0),
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
                  //Text(widget.phone_no),
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
                        disabledColor: Colors.pink,
                        disabledTextColor: Colors.white,
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
            //Text('$client_id'),
            Text(
              'Please tap on the name of a user to report on their behalf, or display their QR Code.',
              style: TextStyle(
                color: Colors.grey[500],
                //letterSpacing: 2.0,
                fontSize: 14.0,
                fontFamily: 'Calibri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            //Text(_clients.firstName),
            Flexible(
              child: new FutureBuilder<List<Client>>(
                future: _clients,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Client> yourPosts = snapshot.data;
                    //List<Post> yourPosts = snapshot.data.posts;
                    return ListView.builder(
                        itemCount: yourPosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Whatever sort of things you want to build
                          // with your Post object at yourPosts[index]:
                          return ListTile(
                              title: Text(yourPosts[index].firstName +
                                  '  ' +
                                  yourPosts[index].lastName),
                              subtitle: Text(yourPosts[index].passportNumber),
                              onTap: () => _userModal(
                                  context,
                                  setState,
                                  yourPosts[index].contactUuid,
                                  yourPosts[index].id,
                                  yourPosts[index].firstName));
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              //],
            ),
            //Text(_clients),
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
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {},
            icon: Icon(Icons.home, color: Colors.blue[600]),
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
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              Navigator.push(
                context,
                //arguments: {},
                MaterialPageRoute(builder: (context) => ChooseLocation()),
              );
            },
            icon: Icon(Icons.assignment, color: Colors.blue[600]),
            label: Text(
              'Resources',
              style: TextStyle(
                  color: Colors.blue[400],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              _exitApp(context);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.blue[600]),
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

Future<bool> _userModal(BuildContext context, StateSetter setState, String name,
    int clientId, String firstname) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Please Select an option for $firstname.'),
        //content: Text('You can always log back in...'),
        //contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white)),
        actions: <Widget>[
          StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 340,
                height: 120,
                child: Column(
                  children: [
                    RadioListTile<String>(
                      activeColor: Colors.red,
                      title: const Text('Report Symptoms'),
                      value: 'report_symptoms',
                      groupValue: character,
                      onChanged: (value) {
                        setState(() {
                          character = value;
                          print(character);
                          print(name);
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Show QR Code'),
                      activeColor: Colors.red,
                      value: 'show_qr',
                      groupValue: character,
                      onChanged: (String value) {
                        setState(() {
                          character = value;
                          print(character);
                        });
                      },
                    ),
                  ],
                ),
                //  ),
              );
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 70),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              SizedBox(width: 30),
              FlatButton(
                onPressed: () {
                  print(character);
                  if (character == 'report_symptoms') {
                    Navigator.push(
                      context,
                      //arguments: {},
                      MaterialPageRoute(
                          builder: (context) =>
                              Report(clientId: clientId, firstName: firstname)),
                    );
                  } else if (character == 'show_qr' && name == null) {
                    _nullQRModal(context, setState, firstname);
                  } else {
                    _showQRModal(context, setState, name, firstname);
                  }
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ],
      ));
}

Future<bool> _showQRModal(
    BuildContext context, StateSetter setState, String name, String firstname) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('QR Code for $firstname'),
        //content: Text('You can always log back in...'),
        //contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white)),
        actions: <Widget>[
          StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 400,
                height: 360,
                child: Column(
                  children: <Widget>[
                    QrImage(
                      data: name,
                      size: 300,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
                //  ),
              );
            },
          ),
        ],
      ));
}

Future<bool> _nullQRModal(
    BuildContext context, StateSetter setState, String firstname) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('QR Code for $firstname does not exist.'),
        //content: Text('You can always log back in...'),
        //contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white)),
        actions: <Widget>[
          StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 400,
                height: 100,
                child: Column(
                  children: <Widget>[
                    Text('Sorry QR Code does not exist.'),
                    SizedBox(height: 10.0),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
                //  ),
              );
            },
          ),
        ],
      ));
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
                //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
