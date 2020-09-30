// To parse this JSON data, do
//
//     final objProp = objPropFromJson(jsonString);

import 'dart:convert';

ObjProp objPropFromJson(String str) => ObjProp.fromJson(json.decode(str));

String objPropToJson(ObjProp data) => json.encode(data.toJson());

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
