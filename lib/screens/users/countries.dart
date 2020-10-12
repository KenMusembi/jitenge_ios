// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) =>
    List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  Countries({
    this.id,
    this.name,
    this.phoneCode,
    this.iso,
  });

  int id;
  String name;
  int phoneCode;
  String iso;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        iso: json["iso"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "iso": iso,
      };
}
