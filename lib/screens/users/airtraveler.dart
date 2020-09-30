import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitenge/screens/authenticate/driver-sign-up.dart';
import 'package:jitenge/screens/authenticate/home-sign-up.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';

import 'package:jitenge/screens/users/userdata.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;
import 'followUp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'resources.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:jitenge/screens/users/reporting.dart';
import 'package:barcode_scan/barcode_scan.dart';

void main() {
  runApp(
    new Airtaveler(),
  );
}

class Airtaveler extends StatefulWidget {
  final int clientId;
  Airtaveler({Key key, this.clientId}) : super(key: key);

  @override
  _AirtavelerState createState() => _AirtavelerState();
}

class _AirtavelerState extends State<Airtaveler> {
  Future<List<Client>> _clients;
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  @override
  void initState() {
    int clientId = widget.clientId;
    _clients = getDriver(phoneNumber);
    super.initState();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      String cleanednumber =
          internationalizedPhoneNumber.replaceAll(new RegExp(r'[^\w\s]+'), '');
      phoneNumber = cleanednumber;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    int clientId = widget.clientId;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jitenge - Air Traveler'),
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
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
                      Text('Scan Traveler QR Code.'),
                      SizedBox(height: 10.0),
                      Material(
                          child: InkWell(
                        onTap: () {
                          scanAirAttestation(context);
                        },
                        child: Image.asset(
                          'assets/qr_code.png',
                          height: 60,
                          width: 70,
                          fit: BoxFit.contain,
                          //),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Jitenge- Report daily follow up',
              style: TextStyle(
                color: Colors.black,
                //letterSpacing: 2.0,
                fontSize: 22.0,
                fontFamily: 'Calibri',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'You are logged in as a health care provider. Please search for a home care case below to help in reporting their daily follow up by entering their registered phone number',
              style: TextStyle(
                color: Colors.grey[500],
                //letterSpacing: 2.0,
                fontSize: 14.0,
                fontFamily: 'Calibri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(height: 10.0),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: InternationalPhoneInput(
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '72200000'),
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: phoneNumber,
                          initialSelection: '+254',
                          enabledCountries: [],
                          showCountryCodes: true,
                          showCountryFlags: true,
                          //showCountryName: true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final String phone_no = phoneNumber;
                              Future<List<Client>> clients =
                                  getDriver(phone_no);
                              setState(() {
                                _clients = clients;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Flexible(
              child: new FutureBuilder<List<Client>>(
                future: _clients,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        // TODO: Handle this case.
                        break;
                      case ConnectionState.waiting:
                        // TODO: Handle this case.
                        break;
                      case ConnectionState.active:
                        // TODO: Handle this case.
                        break;
                      case ConnectionState.done:
                        // TODO: Handle this case.
                        if (snapshot.hasData) {
                          List<Client> yourPosts = snapshot.data;
                          if (snapshot.data.length == 0) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: FloatingActionButton.extended(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          //arguments: {},
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeSignUp()),
                                        );
                                      },
                                      label: Text('Register New Air Traveler')),
                                )
                              ],
                            );
                          }
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
                                    subtitle:
                                        Text(yourPosts[index].passportNumber),
                                    onTap: () => _userModal(
                                        context,
                                        setState,
                                        yourPosts[index].contactUuid,
                                        yourPosts[index].id,
                                        yourPosts[index].firstName));
                              });
                        }
                    }
                  }
                  // By default, show a loading spinner.
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator()],
                  );
                },
              ),
              //],
            ),

            SizedBox(height: 3.0),

            // Divider(color: Colors.black12),
          ],
        ),
      ),
      // ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              Navigator.pop(context);
            },
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

Future<List<Client>> getDriver(phone_no) async {
  final response = await http.get(
    'https://ears.health.go.ke/quarantine_contacts/+$phone_no/',
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    print(phone_no);
    //return clientFromJson(json.decode(response.body));
    return List<Client>.from(
        json.decode(response.body).map((x) => Client.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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

Future scanAirAttestation(BuildContext context) async {
  var options = ScanOptions(
      // set the options
      );

  var result = await BarcodeScanner.scan();
  print(json.encode(result.rawContent.toString()));
  String code = json.encode(result.rawContent.toString());
  print('object');

  final String apiUrl =
      'http://ears-covid.mhealthkenya.co.ke/api/air/traveller/details';

  final response = await http.post(apiUrl, body: {
    "air_traveller_uuid": json.encode(code),
  });
  try {
    if (response.statusCode == 200) {
      final String responseString = code;
      print(result);
      print(responseString);

      //return loginFromJson(responseString);
      //this._outputController.text = barcode;
      return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('FirstName Second Name'),
            content: Text(
              'Air Traveler',
              style: TextStyle(color: Colors.black38),
            ),
            //contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Colors.white)),
            actions: <Widget>[
              StatefulBuilder(
                builder: (context, setState) {
                  var thermalGun;
                  var bodytempController;
                  return SingleChildScrollView(
                    //width: 700,
                    //height: 500,
                    child: SizedBox(
                      width: 700,
                      child: Column(
                        children: <Widget>[
                          Text('Passport/ID/DL No.'),
                          SizedBox(height: 10.0),
                          Text('Phone'),
                          Text('Airline'),
                          Text('Seat Number'),
                          Text('Country of Origin'),
                          TextField(
                            controller: bodytempController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Measured temperature? eg. 36.5'),
                          ),
                          TextField(
                            controller: bodytempController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Airport Arrival Code'),
                          ),
                          Text('Has the traveller arrived or is in transit?'),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 'YES',
                                  groupValue: thermalGun,
                                  title: Text("IN TRANSIT"),
                                  onChanged: (newValue) => setState(() {
                                    thermalGun = newValue;
                                    //_disable = true;
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
                                  title: Text("ARRIVED"),
                                  onChanged: (newValue) => setState(() {
                                    thermalGun = newValue;
                                    //_disable = false;
                                  }),
                                  //activeColor: Colors.red,
                                  //selected: true,
                                ),
                              ),
                            ],
                          ),
                          Text('Released?'),
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
                                    //_disable = true;
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
                                    //_disable = false;
                                  }),
                                  //activeColor: Colors.red,
                                  //selected: true,
                                ),
                              ),
                            ],
                          ),
                          Text('Referred for risk assesment at airport?'),
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
                                    //_disable = true;
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
                                    //_disable = false;
                                  }),
                                  //activeColor: Colors.red,
                                  //selected: true,
                                ),
                              ),
                            ],
                          ),
                          Text('Referred to designated hospital?'),
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
                                    //_disable = true;
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
                                    //_disable = false;
                                  }),
                                  //activeColor: Colors.red,
                                  //selected: true,
                                ),
                              ),
                            ],
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                    //  ),
                  );
                },
              ),
            ],
          ));
    } else {
      Fluttertoast.showToast(
          msg: "Please ensure you have a steady internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Please ensure you have a steady internet connections",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
