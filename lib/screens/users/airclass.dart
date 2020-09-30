// To parse this JSON data, do
//
//     final airClass = airClassFromJson(jsonString);

import 'dart:convert';

AirClass airClassFromJson(String str) => AirClass.fromJson(json.decode(str));

String airClassToJson(AirClass data) => json.encode(data.toJson());

ObjProp objPropFromJson(String str) => ObjProp.fromJson(json.decode(str));

String objPropToJson(ObjProp data) => json.encode(data.toJson());

class AirClass {
  AirClass({
    this.firstName,
    this.middleName,
    this.lastName,
    this.sex,
    this.dob,
    this.passportNumber,
    this.phoneNumber,
    this.emailAddress,
    this.placeOfDiagnosis,
    this.dateOfContact,
    this.nationality,
    this.countyId,
    this.subcountyId,
    this.wardId,
    this.cormobidity,
    this.hcwId,
    this.drugs,
    this.nok,
    this.nokPhoneNum,
    this.communicationLanguageId,
    this.objProp,
  });

  String firstName;
  String middleName;
  String lastName;
  String sex;
  DateTime dob;
  String passportNumber;
  String phoneNumber;
  String emailAddress;
  String placeOfDiagnosis;
  DateTime dateOfContact;
  String nationality;
  int countyId;
  int subcountyId;
  int wardId;
  String cormobidity;
  int hcwId;
  String drugs;
  String nok;
  String nokPhoneNum;
  int communicationLanguageId;
  ObjProp objProp;

  factory AirClass.fromJson(Map<String, dynamic> json) => AirClass(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        sex: json["sex"],
        dob: DateTime.parse(json["dob"]),
        passportNumber: json["passport_number"],
        phoneNumber: json["phone_number"],
        emailAddress: json["email_address"],
        placeOfDiagnosis: json["place_of_diagnosis"],
        dateOfContact: DateTime.parse(json["date_of_contact"]),
        nationality: json["nationality"],
        countyId: json["county_id"],
        subcountyId: json["subcounty_id"],
        wardId: json["ward_id"],
        cormobidity: json["cormobidity"],
        hcwId: json["hcw_id"],
        drugs: json["drugs"],
        nok: json["nok"],
        nokPhoneNum: json["nok_phone_num"],
        communicationLanguageId: json["communication_language_id"],
        objProp: ObjProp.fromJson(json["ObjProp"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "sex": sex,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "place_of_diagnosis": placeOfDiagnosis,
        "date_of_contact":
            "${dateOfContact.year.toString().padLeft(4, '0')}-${dateOfContact.month.toString().padLeft(2, '0')}-${dateOfContact.day.toString().padLeft(2, '0')}",
        "nationality": nationality,
        "county_id": countyId,
        "subcounty_id": subcountyId,
        "ward_id": wardId,
        "cormobidity": cormobidity,
        "hcw_id": hcwId,
        "drugs": drugs,
        "nok": nok,
        "nok_phone_num": nokPhoneNum,
        "communication_language_id": communicationLanguageId,
        "ObjProp": objProp.toJson(),
      };
}

class ObjProp {
  ObjProp({
    this.airline,
    this.flightNumber,
    this.seatNumber,
    this.destinationCity,
    this.travelHistory,
    this.cough,
    this.breathingDifficulty,
    this.fever,
    this.chills,
    this.temperature,
    this.residence,
    this.estate,
    this.postalAddress,
  });

  String airline;
  String flightNumber;
  String seatNumber;
  String destinationCity;
  String travelHistory;
  bool cough;
  bool breathingDifficulty;
  bool fever;
  bool chills;
  bool temperature;
  String residence;
  String estate;
  String postalAddress;

  factory ObjProp.fromJson(Map<String, dynamic> json) => ObjProp(
        airline: json["airline"],
        flightNumber: json["flight_number"],
        seatNumber: json["seat_number"],
        destinationCity: json["destination_city"],
        travelHistory: json["travel_history"],
        cough: json["cough"],
        breathingDifficulty: json["breathing_difficulty"],
        fever: json["fever"],
        chills: json["chills"],
        temperature: json["temperature"],
        residence: json["residence"],
        estate: json["estate"],
        postalAddress: json["postal_address"],
      );

  Map<String, dynamic> toJson() => {
        "airline": airline,
        "flight_number": flightNumber,
        "seat_number": seatNumber,
        "destination_city": destinationCity,
        "travel_history": travelHistory,
        "cough": cough,
        "breathing_difficulty": breathingDifficulty,
        "fever": fever,
        "chills": chills,
        "temperature": temperature,
        "residence": residence,
        "estate": estate,
        "postal_address": postalAddress,
      };
}
