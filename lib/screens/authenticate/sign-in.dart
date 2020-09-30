import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:jitenge/screens/authenticate/driver-sign-up.dart';
import 'package:jitenge/screens/authenticate/home-sign-up.dart';
import 'package:jitenge/screens/authenticate/login.dart';
import 'package:jitenge/screens/users/HCWhome.dart';
import 'package:jitenge/screens/users/userlist.dart' as dd;
import 'sign-up.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

enum SingingCharacter { home_isolation, truck_driver, air_traveler }
String character = 'air_traveler';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Login _user;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  int ninjalevel = 0;

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jitenge MOH - Log In'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 200.0, 5.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/jitenge.png'),
                  backgroundColor: Colors.white,
                  radius: 50.0,
                ),
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
            Text(
              'Please enter your phone number, kindly do not include the country code.' +
                  '\n' +
                  'This is a one time validation process.',
              style: TextStyle(
                color: Colors.grey[500],
                //letterSpacing: 2.0,
                fontSize: 14.0,
                fontFamily: 'Calibri',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),

            //_user == null
            //  ? Text('Failed')
            //: Text('Success'),
            Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InternationalPhoneInput(
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
                    SizedBox(height: 10.0),
                    TextField(
                      controller: nameController,
                      autofocus: false,
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'National ID or Passport Number'),
                    ),
                    SizedBox(height: 15.0),
                    FloatingActionButton.extended(
                      label: Text('Submit'),
                      onPressed: () async {
                        final String phone_no = phoneNumber;
                        print(phoneNumber);
                        final String passport_no = nameController.text;

                        if (phoneNumber.length < 4) {
                          Fluttertoast.showToast(
                              msg: "Please enter a valid Phone Number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (passport_no.length < 2) {
                          Fluttertoast.showToast(
                              msg: "Please enter a valid ID/Passport Number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          final Login user =
                              await _showDialog(phone_no, passport_no);
                          setState(() {
                            _user = user;
                            // String message = _user.message;
                            if (_user.isHcw == 1) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                //arguments: {},
                                MaterialPageRoute(
                                    builder: (context) => HCWhome(
                                        language: _user.language,
                                        phone_no: phone_no,
                                        client_id: _user.clientId)),
                                (Route<dynamic> route) => false,
                              );
                            } else if (_user.isHcw == 0 &&
                                _user.success == true &&
                                _user.clientId != null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                //arguments: {},
                                MaterialPageRoute(
                                    builder: (context) => dd.UserList(
                                        language: _user.language,
                                        phone_no: phone_no,
                                        client_id: _user.clientId)),
                                (Route<dynamic> route) => false,
                              );
                            } else if (_user.success == false &&
                                _user != null) {
                              Fluttertoast.showToast(
                                  msg:
                                      "You are not authorised to access this resource.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER_RIGHT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (passport_no == null) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please enter a valid ID/Passport Number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER_RIGHT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please ensure your details are correct and you have internet connection.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER_RIGHT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        }
                      },
                      tooltip: "Submit Follow Up Data",
                      //icon: Icon(Icons.add)
                    ),
                  ]),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '                 Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.grey,
                    //letterSpacing: 2.0,
                    fontSize: 14.0,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                  color: Colors.white,
                  //elevation: 2.0,
                  onPressed: () {
                    _registerModal(context, setState);
                    //notYet(context);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        //letterSpacing: 2.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: missing_return
Future<Login> _showDialog(String phone_no, String passport_no) async {
  final String apiUrl = 'http://ears-api.mhealthkenya.co.ke/api/login';

  final response = await http.post(apiUrl, headers: {
    HttpHeaders.authorizationHeader:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjUwYjY5MGZjOGE5ZTk2NjdkNjllYWJmNzM5MmZhMzQ3ODllYjNlYWVjMTk3ZGRhZTA5MTZiMGY0YWIyN2QwOTBkY2JlMDI0N2U4Y2E1ZmU2In0.eyJhdWQiOiI0IiwianRpIjoiNTBiNjkwZmM4YTllOTY2N2Q2OWVhYmY3MzkyZmEzNDc4OWViM2VhZWMxOTdkZGFlMDkxNmIwZjRhYjI3ZDA5MGRjYmUwMjQ3ZThjYTVmZTYiLCJpYXQiOjE1ODg4MzU5NDUsIm5iZiI6MTU4ODgzNTk0NSwiZXhwIjoxNjIwMzcxOTQ1LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.LyrNZuAHaV59aGv4-Am9nrSWr_kxuooxZyQWEUe61GnCD09iEOfbDCofo-5whaGCb_juL_iLE5kZqAza2ywqROVYgjDJP-JH_g5cZgtPhom8mNq-Fjf2PJ3gt3xyAqor3kLMEn1ZhdfOL8I-W4tQ5_eSJY5vUhPWFA2vCbp3zRgRgM4ITLn19PnXk-bRQ-Lo5CTIuNOnt8I4IQjVGnQMAqTIUT9blY7YOYZ9tBRHj-yKl7dFRgO6yZcXpeIRPAithE_lo9GzKFl69F6mg_gBJbaymMyshgUxtThYuUWsZv1fkZnJColVOpmRjvjOqkRanB4keiveZA1Wfj3Gj6QtrAj_C3giIB3LMRwQS0_Da2FnVgbAqCG2PEfmfseKTdHMZttm6Vy59Ya9sXf41qlfYOWpXMkWNPsKxbngjMqjvDAw_26VTUaQP92c7m_8HkXoN7zY_KsWbc0HvMuMbHt29SlqPSytOzh1v45digHDARkF9oLAuHnIy7sFUzbAEsltG4UeatcHFbi5pa7tE-FeA27z7jlvgMRsbUENsikKxpbnnz6loucCpsdZ1VgQ3iXIeDWz4Ka79Yi1_IhYmA6OhssVABslQPmOKyoVxKeaL37F8BwES7AmWnDvO0bCdm4V66jlvulKMvW5nTqhrKTy5ax76sPGd5-cCA_G7em9SLg"
  }, body: {
    "phone_no": phone_no,
    "passport_no": passport_no
  });
  try {
    if (response.statusCode == 200) {
      if (passport_no == '' || phone_no == '') {
        Fluttertoast.showToast(
            msg: "Please enter a valid ID/Passport Number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        final String responseString = response.body;
        print(responseString);
        print(passport_no);
        return loginFromJson(responseString);
      }
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
        msg: "Please ensure you have a steady internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

Future<bool> _registerModal(BuildContext context, StateSetter setState) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Please Select an option below:'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.white)),
        actions: <Widget>[
          StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 340,
                height: 180,
                child: Column(
                  children: [
                    RadioListTile<String>(
                      activeColor: Colors.red,
                      title: const Text('Home isolation'),
                      value: 'home_isolation',
                      groupValue: character,
                      onChanged: (value) {
                        setState(() {
                          character = value;
                          print(character);
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Truck Driver'),
                      activeColor: Colors.red,
                      value: 'truck_driver',
                      groupValue: character,
                      onChanged: (String value) {
                        setState(() {
                          character = value;
                          print(character);
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Air Traveler'),
                      activeColor: Colors.red,
                      value: 'air_traveler',
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
                  if (character == 'home_isolation') {
                    Navigator.push(
                      context,
                      //arguments: {},
                      MaterialPageRoute(builder: (context) => HomeSignUp()),
                    );
                  } else if (character == 'truck_driver') {
                    Navigator.push(
                      context,
                      //arguments: {},
                      MaterialPageRoute(builder: (context) => DriverSignUp()),
                    );
                  } else if (character == 'air_traveler') {
                    Navigator.push(
                      context,
                      //arguments: {},
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  }
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ],
      ));
}

notYet(BuildContext context) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Service not available.'),
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
                height: 60,
                child: Column(
                  children: <Widget>[
                    Text('We will notify you once this feature is ready.'),
                  ],
                ),
                //  ),
              );
            },
          ),
        ],
      ));
}
