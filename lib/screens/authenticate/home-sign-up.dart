import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';
import 'package:jitenge/screens/users/counties.dart';
import 'package:jitenge/screens/users/countries.dart';
import 'package:jitenge/screens/users/followUp.dart';
import 'package:jitenge/screens/users/subcounties.dart';
import 'package:jitenge/screens/users/wards.dart';
import 'dart:async';
import 'driver-sign-up.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HomeSignUp extends StatefulWidget {
  @override
  _HomeSignUpState createState() => _HomeSignUpState();
}

class _HomeSignUpState extends State<HomeSignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController placeofContactController =
      TextEditingController();
  final TextEditingController airlineController = TextEditingController();
  final TextEditingController flightNumberController = TextEditingController();
  final TextEditingController seatNumberController = TextEditingController();
  final TextEditingController drugsController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController countriesVisitedController =
      TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactTelephoneController =
      TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController comorbidityController = TextEditingController();
  final TextEditingController physicalController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FollowUp _user;
  Future<List<Countries>> cntry;
  Future<List<Counties>> cnty;
  String dropdownValue3 = "KENYA";
  String dropdownValue4 = "Nairobi";
  String myselection, myselection2, myselection3, myselection4, myselection5;
  dynamic orgunit;
  bool countiesdropdown = false;
  String dropdownValue = 'Male';
  String dropdownValue2 = 'English';
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  List countriesdata, countiesdata, subcountiesdata = List(); //edited line

  Future<String> getCountries() async {
    final String apiUrl = 'http://ears-api.mhealthkenya.co.ke/api/countries';
    var res = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      countriesdata = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  Future<String> getCounties() async {
    final String apiUrl = 'http://ears-api.mhealthkenya.co.ke/api/counties';

    var res = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      countiesdata = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  Future<String> getSubCounties(myselection2) async {
    final String apiUrl = 'http://ears-api.mhealthkenya.co.ke/api/sub/counties';

    var res = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      subcountiesdata = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
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
  void initState() {
    this.getCounties();
    this.getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 10.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 250.0, 15.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/jitenge.png'),
                    radius: 40.0,
                  ),
                ),
              ),
              Text(
                'Home Care Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 2.0,
                  fontSize: 22.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Create your account as a home care case and start your self quarantine.',
                style: TextStyle(
                  color: Colors.grey,
                  //letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: _formkey,
                child: Column(children: [
                  Text(
                    'What is your country of origin?',
                    style: TextStyle(
                      color: Colors.black,
                      //letterSpacing: 2.0,
                      fontSize: 18.0,
                      fontFamily: 'Calibri',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: new DropdownButton(
                          //value: dropdownValue2,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 26,
                          elevation: 16,
                          items: countriesdata.map((item) {
                            return new DropdownMenuItem(
                              child: new SizedBox(
                                  width: 200, child: new Text(item['name'])),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              myselection = newVal;
                              if (myselection == '110') {
                                countiesdropdown = true;
                              } else {
                                countiesdropdown = false;
                              }
                            });
                          },
                          value: myselection,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Visibility(
                        visible: countiesdropdown,
                        child: Column(
                          children: [
                            Text(
                              '   What is your county?',
                              style: TextStyle(
                                color: Colors.black,
                                //letterSpacing: 2.0,
                                fontSize: 18.0,
                                fontFamily: 'Calibri',
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: new DropdownButton(
                                isExpanded: true,
                                items: countiesdata.map((item) {
                                  return new DropdownMenuItem(
                                    child: new SizedBox(
                                        width: 200,
                                        child: new Text(item['name'])),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    myselection2 = newVal;
                                    getSubCounties(myselection2);
                                    print(countiesdata
                                        .map((e) => e['organisationunitid']));
                                  });
                                  print(myselection2);
                                },
                                value: myselection2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.0),
                  Text(
                    'What is your nationality?',
                    style: TextStyle(
                      color: Colors.black,
                      //letterSpacing: 2.0,
                      fontSize: 18.0,
                      fontFamily: 'Calibri',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: new DropdownButton(
                        isExpanded: true,
                        items: countriesdata.map((item) {
                          return new DropdownMenuItem(
                            child: new SizedBox(
                                width: 200, child: new Text(item['name'])),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            myselection3 = newVal;
                          });
                        },
                        value: myselection3,
                      ),
                    ),
                  ]),
                  SizedBox(height: 5.0),

                  TextField(
                    controller: physicalController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Physical Location'),
                  ),
                  //),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'First Name'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Last Name'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: passportNumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ID/Passport Number'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email Address'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Gender',
                          style: TextStyle(
                            color: Colors.black,
                            //letterSpacing: 2.0,
                            fontSize: 18.0,
                            fontFamily: 'Calibri',
                            //fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 120.0,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Date of Birth:',
                          style: TextStyle(
                            color: Colors.black,
                            //letterSpacing: 2.0,
                            fontSize: 18.0,
                            fontFamily: 'Calibri',
                            //fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 40.0,
                      ),
                      FlatButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              color: Colors.black,
                              //letterSpacing: 2.0,
                              fontSize: 18.0,
                              fontFamily: 'Calibri',
                              //fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.0),
                  InternationalPhoneInput(
                    decoration: InputDecoration.collapsed(
                        hintText: '(07) 023 123-1234'),
                    onPhoneNumberChange: onPhoneNumberChange,
                    initialPhoneNumber: phoneNumber,
                    initialSelection: '+254',
                    enabledCountries: [],
                    showCountryCodes: true,
                    showCountryFlags: true,
                    //showCountryName: true,
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    controller: placeofContactController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Place of Contact'),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: comorbidityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Any additional symptomatic condition'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: drugsController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Are you using any Drus or Prescription'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: contactPersonController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Next of Kin'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: contactTelephoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Next of Kin Phone Number'),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      Text('Preferred Language',
                          style: TextStyle(
                            color: Colors.black,
                            //letterSpacing: 2.0,
                            fontSize: 18.0,
                            fontFamily: 'Calibri',
                            //fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 30.0,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                        },
                        items: <String>['English', 'Kiswahli', 'French']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  FloatingActionButton.extended(
                    label: Text('Submit'),
                    onPressed: () async {
                      final String firstName = firstNameController.text;
                      final lastName = lastNameController.text;
                      final String phone_number = '+254' + phoneNumber;
                      final passportNumber = passportNumberController.text;
                      final email = emailAddressController.text;
                      final place_of_contact = placeofContactController.text;
                      final comorbidity = comorbidityController.text;
                      final drugs = drugsController.text;
                      final String sex = dropdownValue;
                      final String nationality = myselection3;
                      final String country_id = myselection2;
                      final String county_id = myselection2;
                      final String subcounty_id = myselection4;
                      final String ward_id = myselection5;
                      final String communication_language_id = dropdownValue2;

                      final String dob = selectedDate.toString();
                      // final String arrival_date = selectedDate2.toString();
                      //final String origin_country = selectedcountry;

                      final contactPerson = contactPersonController.text;
                      final contactPhone = contactTelephoneController.text;

                      final FollowUp followup = await _showDialog(
                        firstName,
                        lastName,
                        phone_number,
                        passportNumber,
                        email,
                        place_of_contact,
                        comorbidity,
                        drugs,
                        sex,
                        nationality,
                        country_id,
                        county_id,
                        subcounty_id,
                        ward_id,
                        communication_language_id,
                        dob,
                        contactPerson,
                        contactPhone,
                      );
                      setState(() {
                        _user = followup;
                        if (_user.success == true) {
                          Fluttertoast.showToast(
                              msg:
                                  "Sorry, App currently not available for HealthCare workers.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    },
                    tooltip: "Submit Follow Up Data",
                    //icon: Icon(Icons.add)
                  ),
                ]),
              ),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Text(
                    '                 Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey,
                      //letterSpacing: 2.0,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    ' Login',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        //letterSpacing: 2.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: missing_return
Future _showDialog(
    String firstName,
    String lastName,
    String phone_number,
    String passportNumber,
    String email,
    String place_of_contact,
    String comorbidity,
    String drugs,
    String sex,
    String nationality,
    String country_id,
    String county_id,
    String subcounty_id,
    String ward_id,
    String communication_language_id,
    String dob,
    String contactPerson,
    String contactPhone) async {
  final String apiUrl = 'https://ears.health.go.ke/airport_post/';
  if (county_id == '' || county_id == null) {
    county_id = '47';
  }

  // String token =
  //   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOnsiaWQiOjEsInBob25lX251bWJlciI6IisyNTQ3MjM3ODMwMjEiLCJmaXJzdF9uYW1lIjoicGF0aWVudCIsImNyZWF0ZWRfYXQiOiIyMDIwLTAzLTAxIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wMSIsInVwZGF0ZWRBdCI6IjIwMjAtMDMtMTQifSwiaWF0IjoxNTg0MTkxNjUzfQ.dEgJySZ33Mi4jE6lodOgbsTjKMuT7xfW-EkhHKtv-Oc";

  final response = await http.post(apiUrl, headers: {
    //'Content-type': 'application/json',
    'Accept': '*/*',
    //'Authorization': 'Bearer $token'
  }, body: {
    "first_name": firstName,
    "last_name": lastName,
    "sex": sex,
    "dob": dob,
    "passport_number": passportNumber,
    "phone_number": phone_number,
    "email_address": email,
    "place_of_diagnosis": "kenya",
    "date_of_arrival": dob,
    "nationality": nationality,
    "country": country_id,
    "county": county_id,
    "subcounty": "Dagorreti",
    "ward": "Dago",
    "cormobidity": "no",
    "hcw_id": json.encode(1),
    "drugs": drugs,
    "nok": contactPerson,
    "nok_phone_num": contactPhone,
    "communication_language_id": communication_language_id
  }).timeout(
    Duration(seconds: 3),
    onTimeout: () {
      // time has run out, do what you wanted to do
      return null;
    },
  );
  //FollowUp followUp;
  try {
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      print(phone_number);

      if (responseString.contains("Successfully")) {
        Fluttertoast.showToast(
            msg:
                "Successfully Registered as a HomeCare case. \n Log in to report your symptoms.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (responseString.contains('Exists')) {
        Fluttertoast.showToast(
            msg: "Sorry, Client with details already exists.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registration not succesful, Kindly Try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return responseString;
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
