// To parse this JSON data, do
//
//     final wards = wardsFromJson(jsonString);

import 'dart:convert';

List<Wards> wardsFromJson(String str) =>
    List<Wards>.from(json.decode(str).map((x) => Wards.fromJson(x)));

String wardsToJson(List<Wards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wards {
  Wards({
    this.id,
    this.name,
    this.organisationunitid,
  });

  int id;
  String name;
  String organisationunitid;

  factory Wards.fromJson(Map<String, dynamic> json) => Wards(
        id: json["id"],
        name: json["name"],
        organisationunitid: json["organisationunitid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "organisationunitid": organisationunitid,
      };
}
