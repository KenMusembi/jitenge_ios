import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'dart:async';
import 'sign-up.dart';

class DriverSignUp extends StatefulWidget {
  @override
  _DriverSignUpState createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text('Ninja ID Card'),
        //centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 10.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                'Driver Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 2.0,
                  fontSize: 22.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Create your account as a driver andstart your self quarantine.',
                style: TextStyle(
                  color: Colors.grey,
                  //letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30.0),
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
              SizedBox(
                //width: 600,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                  child: CountryCodePicker(
                    onChanged: print,
                    hideMainText: false,
                    showFlagMain: true,
                    //: true,
                    showFlag: true,
                    initialSelection: 'UG',
                    hideSearch: false,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: true,
                  ),
                ),
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
              SizedBox(
                //width: 600,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                  child: CountryCodePicker(
                    onChanged: print,
                    hideMainText: false,
                    showFlagMain: true,
                    //: true,
                    showFlag: true,
                    initialSelection: 'UG',
                    hideSearch: false,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: true,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'Physical Address'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'First Name'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'Last Name'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'ID/Passport Number'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
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
                decoration:
                    InputDecoration.collapsed(hintText: '(07) 023 123-1234'),
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
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'Place of contact'),
              ),
              SizedBox(height: 5.0),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'Any additional symptomatic conditions'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'Are you using any drugs/prescriptions'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'Next of Kin'),
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    hintText: 'Next of Kin Phone Number'),
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Text('Prefeered Language',
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
              Row(
                children: <Widget>[
                  FlatButton(
                    //padding: EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 5.0),
                    color: Colors.grey[50],
                    //elevation: 2.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  SizedBox(width: 140.0),
                  FlatButton(
                    //padding: EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 5.0),
                    color: Colors.grey[50],
                    //elevation: 2.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: const Text('Next',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
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
