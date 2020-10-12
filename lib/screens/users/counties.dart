// To parse this JSON data, do
//
//     final counties = countiesFromJson(jsonString);

import 'dart:convert';

List<Counties> countiesFromJson(String str) =>
    List<Counties>.from(json.decode(str).map((x) => Counties.fromJson(x)));

String countiesToJson(List<Counties> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Counties {
  Counties({
    this.id,
    this.name,
    this.organisationunitid,
  });

  int id;
  String name;
  String organisationunitid;

  factory Counties.fromJson(Map<String, dynamic> json) => Counties(
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
