// To parse this JSON data, do
//
//     final followUp = followUpFromJson(jsonString);

import 'dart:convert';

FollowUp followUpFromJson(String str) => FollowUp.fromJson(json.decode(str));

String followUpToJson(FollowUp data) => json.encode(data.toJson());

class FollowUp {
  FollowUp({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory FollowUp.fromJson(Map<String, dynamic> json) => FollowUp(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
