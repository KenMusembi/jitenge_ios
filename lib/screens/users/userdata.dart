// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  final bool success;
  final List<Client> clients;

  User({this.success, this.clients});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['clients'] as List;
    print(list.runtimeType);
    List<Client> clientList = list.map((i) => Client.fromJson(i)).toList();
    return User(success: parsedJson['success'], clients: clientList);
  }
}

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String passportNumber;
  final dynamic uuid;

  Client(
      {this.id, this.firstName, this.lastName, this.passportNumber, this.uuid});

  factory Client.fromJson(Map<String, dynamic> parsedJson) {
    return Client(
        id: parsedJson['id'],
        firstName: parsedJson['firstName'],
        lastName: parsedJson['lastName'],
        passportNumber: parsedJson['passportNumber'],
        uuid: parsedJson['uuid']);
  }
}
