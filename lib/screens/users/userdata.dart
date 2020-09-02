// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.passportNumber,
    this.phoneNumber,
    this.contactUuid,
  });

  int id;
  String firstName;
  String lastName;
  String passportNumber;
  String phoneNumber;
  String contactUuid;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        passportNumber: json["passport_number"],
        phoneNumber: json["phone_number"],
        contactUuid: json["contact_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "passport_number": passportNumber,
        "phone_number": phoneNumber,
        "contact_uuid": contactUuid,
      };
}
