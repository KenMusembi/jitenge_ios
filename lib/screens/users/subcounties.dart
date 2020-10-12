// To parse this JSON data, do
//
//     final subcounties = subcountiesFromJson(jsonString);

import 'dart:convert';

List<Subcounties> subcountiesFromJson(String str) => List<Subcounties>.from(json.decode(str).map((x) => Subcounties.fromJson(x)));

String subcountiesToJson(List<Subcounties> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcounties {
    Subcounties({
        this.id,
        this.name,
        this.organisationunitid,
    });

    int id;
    String name;
    String organisationunitid;

    factory Subcounties.fromJson(Map<String, dynamic> json) => Subcounties(
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
