// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.success,
        this.message,
        this.clientId,
        this.isHcw,
        this.language,
    });

    bool success;
    String message;
    int clientId;
    int isHcw;
    int language;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        success: json["success"],
        message: json["message"],
        clientId: json["client_id"],
        isHcw: json["is_hcw"],
        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "client_id": clientId,
        "is_hcw": isHcw,
        "language": language,
    };
}
