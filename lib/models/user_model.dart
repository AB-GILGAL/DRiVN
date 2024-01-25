// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    Data data;
    bool status;

    UserModel({
        required this.data,
        required this.status,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    String avatar;
    DateTime createdAt;
    Document document;
    String firstName;
    int id;
    String lastName;
    DateTime updatedAt;
    String username;

    Data({
        required this.avatar,
        required this.createdAt,
        required this.document,
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.updatedAt,
        required this.username,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["createdAt"]),
        document: Document.fromJson(json["document"]),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "createdAt": createdAt.toIso8601String(),
        "document": document.toJson(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
    };
}

class Document {
    DateTime createdAt;
    int id;
    dynamic idCard;
    DateTime updatedAt;

    Document({
        required this.createdAt,
        required this.id,
        required this.idCard,
        required this.updatedAt,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        idCard: json["idCard"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "idCard": idCard,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
