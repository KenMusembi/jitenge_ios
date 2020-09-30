import 'dart:convert';

import 'package:flutter/material.dart';

//
import 'dart:async';
import 'dart:io';

import 'package:jitenge/screens/authenticate/sign-in.dart';
import 'package:jitenge/screens/users/airclass.dart';
import 'package:jitenge/screens/users/followUp.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:international_phone_input/international_phone_input.dart' as d;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('254');

  Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('254');

  Country _selectedCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('tr');

  Country _selectedFilteredCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('KE');

  final _formkey = GlobalKey<FormState>();

  bool thermalGun;
  bool fever;
  bool cough;
  bool difficultBreathing;
  bool feverish;
  bool chills;
  bool pcrTest;
  FollowUp _user;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController residenceController = TextEditingController();
  final TextEditingController airlineController = TextEditingController();
  final TextEditingController flightNumberController = TextEditingController();
  final TextEditingController seatNumberController = TextEditingController();
  final TextEditingController destinationCityController =
      TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController countriesVisitedController =
      TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactTelephoneController =
      TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController sublocationController = TextEditingController();
  final TextEditingController postalAdressController = TextEditingController();

  String dropdownValue = 'Male';
  String dropdownValue2 = 'Nairobi';
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  String selectedcountry = 'Kenya';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2020, 9),
        lastDate: DateTime(2021, 1));
    if (picked2 != null && picked2 != selectedDate2)
      setState(() {
        selectedDate2 = picked2;
        print(selectedDate2);
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
    _buildCountryPickerDropdownSoloExpanded() {
      return CountryPickerDropdown(
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        //show'em (the text fields) you're in charge now
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        //if you want your dropdown button's selected item UI to be different
        //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.

        itemHeight: null,
        isExpanded: true,
        initialValue: 'KE',
        icon: Icon(Icons.arrow_downward),
      );
    }

    Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
        SizedBox(
          width: dropdownItemWidth,
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: Text("+${country.phoneCode}(${country.isoCode})")),
            ],
          ),
        );

    Widget _buildDropdownItemWithLongText(
            Country country, double dropdownItemWidth) =>
        SizedBox(
          width: dropdownItemWidth,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(child: Text("${country.name}")),
              ],
            ),
          ),
        );

    Widget _buildDropdownSelectedItemBuilder(
            Country country, double dropdownItemWidth) =>
        SizedBox(
            width: dropdownItemWidth,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CountryPickerUtils.getDefaultFlagImage(country),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: Text(
                      '${country.name}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                  ],
                )));

    _buildCountryPickerDropdown(
        {bool filtered = false,
        bool sortedByIsoCode = false,
        bool hasPriorityList = false,
        bool hasSelectedItemBuilder = false}) {
      double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.5;
      //respect dropdown button icon size
      double dropdownItemWidth = dropdownButtonWidth - 30;
      double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
      return Row(
        children: <Widget>[
          SizedBox(
            // width: dropdownButtonWidth,
            child: CountryPickerDropdown(
              /* underline: Container(
              height: 2,
              color: Colors.red,
            ),*/
              //show'em (the text fields) you're in charge now
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              //if you have menu items of varying size, itemHeight being null respects
              //that, IntrinsicHeight under the hood ;).
              itemHeight: null,
              //itemHeight being null and isDense being true doesn't play along
              //well together. One is trying to limit size and other is saying
              //limit is the sky, therefore conflicts.
              //false is default but still keep that in mind.
              isDense: false,
              //if you want your dropdown button's selected item UI to be different
              //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
              selectedItemBuilder: hasSelectedItemBuilder == true
                  ? (Country country) => _buildDropdownSelectedItemBuilder(
                      country, dropdownSelectedItemWidth)
                  : null,
              //initialValue: 'AR',
              itemBuilder: (Country country) => hasSelectedItemBuilder == true
                  ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                  : _buildDropdownItem(country, dropdownItemWidth),
              initialValue: 'KE',
              itemFilter: filtered
                  ? (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode)
                  : null,
              //priorityList is shown at the beginning of list
              priorityList: hasPriorityList
                  ? [
                      CountryPickerUtils.getCountryByIsoCode('GB'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ]
                  : null,
              sortComparator: sortedByIsoCode
                  ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                  : null,
              onValuePicked: (Country country) {
                print("${country.name}");
                setState(() {
                  selectedcountry = "${country.name}";
                });
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jitenge - Air Traveler Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 250.0, 0.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/jitenge.png'),
                    radius: 35.0,
                  ),
                ),
              ),
              Text(
                'Air Traveler Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 2.0,
                  fontSize: 22.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Sign Up as an Air Traveler.',
                style: TextStyle(
                  color: Colors.grey,
                  //letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  Text(
                    'Biodata',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'First Name'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: middleNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Middle Name'),
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
                  Text(
                    'What is your Country of Residence?',
                    style: TextStyle(
                      color: Colors.black,
                      //letterSpacing: 2.0,
                      fontSize: 18.0,
                      fontFamily: 'Calibri',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildCountryPickerDropdown(hasSelectedItemBuilder: true),
                      //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        width: 20.0,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Gender:',
                          style: TextStyle(
                            color: Colors.black,
                            //letterSpacing: 2.0,
                            fontSize: 18.0,
                            fontFamily: 'Calibri',
                            //fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 100.0,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Date of Arrival:',
                          style: TextStyle(
                            color: Colors.black,
                            //letterSpacing: 2.0,
                            fontSize: 18.0,
                            fontFamily: 'Calibri',
                            //fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      FlatButton(
                        onPressed: () => _selectDate2(context),
                        child: Text("${selectedDate2.toLocal()}".split(' ')[0],
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
                  SizedBox(height: 5.0),
                  TextField(
                    controller: airlineController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Airline'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: flightNumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Flight Number(s)'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: seatNumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Seat Number'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: destinationCityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Destination City'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'E-Mail Address'),
                  ),
                  SizedBox(height: 5.0),
                  d.InternationalPhoneInput(
                    decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                  SizedBox(height: 15.0),
                  Text(
                    'Travel History',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Which countries have you been in the past two weeks?',
                    style: TextStyle(
                      color: Colors.black,
                      //letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: countriesVisitedController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Countries Visited'),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Medical History',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Today or in the past 24hours, have you had any of the following symptoms?',
                    style: TextStyle(
                      color: Colors.black,
                      //letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Fever (37.5°C oe higher)'),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: true,
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
                                value: false,
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
                        Text('Felt Feverish?'),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: true,
                                groupValue: feverish,
                                title: Text("YES"),
                                onChanged: (newValue) =>
                                    setState(() => feverish = newValue),
                                //activeColor: Colors.red,
                                //selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: false,
                                groupValue: feverish,
                                title: Text("NO"),
                                onChanged: (newValue) =>
                                    setState(() => feverish = newValue),
                                //activeColor: Colors.red,
                                //selected: true,
                              ),
                            ),
                          ],
                        ),
                        Text('Had Chills?'),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: true,
                                groupValue: chills,
                                title: Text("YES"),
                                onChanged: (newValue) =>
                                    setState(() => chills = newValue),
                                //activeColor: Colors.red,
                                //selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: false,
                                groupValue: chills,
                                title: Text("NO"),
                                onChanged: (newValue) =>
                                    setState(() => chills = newValue),
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
                                value: true,
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
                                value: false,
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
                                value: true,
                                groupValue: difficultBreathing,
                                title: Text("YES"),
                                onChanged: (newValue) => setState(
                                    () => difficultBreathing = newValue),
                                //activeColor: Colors.red,
                                //selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: false,
                                groupValue: difficultBreathing,
                                title: Text("NO"),
                                onChanged: (newValue) => setState(
                                    () => difficultBreathing = newValue),
                                //activeColor: Colors.red,
                                //selected: true,
                              ),
                            ),
                          ],
                        ),
                        Text('Do you have a Negative PCR test?'),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: true,
                                groupValue: pcrTest,
                                title: Text("YES"),
                                onChanged: (newValue) =>
                                    setState(() => pcrTest = newValue),
                                //activeColor: Colors.red,
                                //selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: false,
                                groupValue: pcrTest,
                                title: Text("NO"),
                                onChanged: (newValue) =>
                                    setState(() => pcrTest = newValue),
                                //activeColor: Colors.red,
                                //selected: true,
                              ),
                            ),
                          ],
                        ),
                        //SizedBox(height: 10.0),
                      ]),
                  SizedBox(height: 10.0),
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: contactPersonController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name of contact person'),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: contactTelephoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contact person telephone'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: villageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Village/House Number/Hotel'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: sublocationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Sublocation/Estate'),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    controller: postalAdressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Postal Address'),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      Text('County',
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
                        items: <String>[
                          'Nairobi',
                          'Kirinyaga',
                          'Bungoma',
                          'Nyamira',
                          'Lamu',
                          'Wajir',
                          'Nandi',
                          'Embu',
                          'Isiolo',
                          'Taita Taveta',
                          'Nakuru',
                          'Migori',
                          'Narok',
                          'Marsabit',
                          'Kilifi',
                          'Kitui',
                          'Mombasa',
                          'Kisumu',
                          'Kakamega',
                          'Machakos',
                          'Mandera',
                          'Meru',
                          'Garissa',
                          'Kisii',
                          'Siaya',
                          'Muranga',
                          'Laikipia',
                          'Kajiado',
                          'Kwale',
                          'Baringo',
                          'Nyeri',
                          'Trans Nzioia',
                          'Vihiga',
                          'Samburu',
                          'Tana Rover',
                          'Elgeyo-Marakwet',
                          'West Pokot',
                          'Makueni',
                          'Kiambu',
                          'Tharaka Nithi',
                          'Turkana',
                          'Busia',
                          'Bomet',
                          'Homa Bay',
                          'Kericho',
                          'Nyandarua',
                          'Uasin Gishu'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  FloatingActionButton.extended(
                    label: Text('Submit'),
                    onPressed: () async {
                      final String firstName = firstNameController.text;
                      final middleName = middleNameController.text;
                      final lastName = lastNameController.text;
                      final passportNumber = passportNumberController.text;
                      final String sex = dropdownValue;
                      final String county = dropdownValue2;
                      final String phone_number = '+254' + phoneNumber;
                      final String dob = selectedDate.toString();
                      final String arrival_date = selectedDate2.toString();
                      final String selecetdcountry = selectedcountry;
                      final airline = airlineController.text;
                      final flightNumber = flightNumberController.text;
                      final seatNumber = seatNumberController.text;
                      final destinationCity = destinationCityController.text;
                      final email = emailAddressController.text;
                      final countriesVisited = countriesVisitedController.text;
                      final contactPerson = contactPersonController.text;
                      final contactPhone = contactTelephoneController.text;
                      final village = villageController.text;
                      final postalAddress = postalAdressController.text;
                      final sublocation = sublocationController.text;
                      final FollowUp followup = await _showDialog(
                          difficultBreathing,
                          fever,
                          feverish,
                          cough,
                          chills,
                          pcrTest,
                          firstName,
                          middleName,
                          lastName,
                          passportNumber,
                          sex,
                          county,
                          phone_number,
                          dob,
                          arrival_date,
                          selecetdcountry,
                          airline,
                          flightNumber,
                          seatNumber,
                          destinationCity,
                          email,
                          countriesVisited,
                          contactPerson,
                          contactPhone,
                          village,
                          postalAddress,
                          sublocation);
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
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '                 Already have an account? ',
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        //arguments: {},
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Login',
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
      ),
    );
  }
}

// ignore: missing_return
Future _showDialog(
    bool difficultBreathing,
    bool fever,
    bool feverish,
    bool cough,
    bool chills,
    bool pcrTest,
    String firstName,
    String middleName,
    String lastName,
    String passportNumber,
    String sex,
    String county,
    String phone_number,
    String dob,
    String arrival_date,
    String selectedcountry,
    String airline,
    String flightNumber,
    String seatNumber,
    String destinationCity,
    String email,
    String countriesVisited,
    String contactPerson,
    String contactPhone,
    String village,
    String postalAddress,
    String sublocation) async {
  final String apiUrl = 'https://ears.health.go.ke/airport_post/';
  if (county == '' || county == null) {
    county = 'Nairobi';
  }

  AirClass jsonf;
  jsonf.firstName;
  jsonf.emailAddress = 'false';
  jsonf.cormobidity = 'ff';
  jsonf.objProp = ObjProp(airline: airline, flightNumber: flightNumber);

  // String token =
  //   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOnsiaWQiOjEsInBob25lX251bWJlciI6IisyNTQ3MjM3ODMwMjEiLCJmaXJzdF9uYW1lIjoicGF0aWVudCIsImNyZWF0ZWRfYXQiOiIyMDIwLTAzLTAxIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wMSIsInVwZGF0ZWRBdCI6IjIwMjAtMDMtMTQifSwiaWF0IjoxNTg0MTkxNjUzfQ.dEgJySZ33Mi4jE6lodOgbsTjKMuT7xfW-EkhHKtv-Oc";

  final response = await http.post(apiUrl, headers: {
    //'Content-type': 'application/json',
    'Accept': '*/*',
    //'Authorization': 'Bearer $token'
  }, body: {
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "sex": sex,
    "dob": dob,
    "passport_number": passportNumber,
    "phone_number": phone_number,
    "email_address": email,
    "place_of_diagnosis": "kenya",
    "date_of_arrival": arrival_date,
    "nationality": selectedcountry,
    "country": selectedcountry,
    "county": county,
    "subcounty": "Dagorreti",
    "ward": "Dago",
    "cormobidity": "no",
    "hcw_id": json.encode(1),
    "drugs": "no",
    "nok": contactPerson,
    "nok_phone_num": contactPhone,
    "communication_language_id": json.encode(1),
    "airline": airline,
    "flight_number": flightNumber,
    "seat_number": seatNumber,
    "destination_city": destinationCity,
    "countries_visited": countriesVisited,
    "cough": json.encode(cough),
    "covid_pcr": json.encode(pcrTest),
    "breathing_difficulty": json.encode(difficultBreathing),
    "fever": json.encode(fever),
    "chills": json.encode(chills),
    "feverish": json.encode(feverish),
    "measured_temperature": json.encode(0),
    "arrival_airport_code": arrival_date,
    "released": json.encode(false),
    "risk_assessment_referal": json.encode(false),
    "designated_hospital_referal": json.encode(false),
    "reference_facility": json.encode(false),
    "residence": village,
    "estate": sublocation,
    "postal_address": postalAddress,
    "ObjProp": json.encode(jsonf)
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
                "Successfully Registered as an Air Traveller. \n Log in to check your QR Code.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (responseString.contains('Exists')) {
        Fluttertoast.showToast(
            msg: "Client with details already exists",
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
