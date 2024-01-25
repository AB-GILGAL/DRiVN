// To parse this JSON data, do
//
//     final driversModel = driversModelFromJson(jsonString);

import 'dart:convert';

DriversModel driversModelFromJson(String str) =>
    DriversModel.fromJson(json.decode(str));

String driversModelToJson(DriversModel data) => json.encode(data.toJson());

class DriversModel {
  Data? data;
  bool status;

  DriversModel({
    this.data,
    required this.status,
  });

  factory DriversModel.fromJson(Map<String, dynamic> json) => DriversModel(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  int? count;
  List<DriverModelData> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] ?? 0,
        data: List<DriverModelData>.from(
            json["data"].map((x) => DriverModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DriverModelData {
  DateTime createdAt;
  Document document;
  String firstName;
  int id;
  String lastName;
  String status;
  DateTime updatedAt;
  String username;

  DriverModelData({
    required this.createdAt,
    required this.document,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.status,
    required this.updatedAt,
    required this.username,
  });

  factory DriverModelData.fromJson(Map<String, dynamic> json) =>
      DriverModelData(
        createdAt: DateTime.parse(json["createdAt"]),
        document: Document.fromJson(json["document"]),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "document": document.toJson(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
      };
}

class Document {
  String cardStatus;
  DateTime createdAt;
  int experience;
  int id;
  List<String> idCard;
  String licenseNumber;
  String licenseStatus;
  String licenseType;
  int rate;
  DateTime updatedAt;

  Document({
    required this.cardStatus,
    required this.createdAt,
    required this.experience,
    required this.id,
    required this.idCard,
    required this.licenseNumber,
    required this.licenseStatus,
    required this.licenseType,
    required this.rate,
    required this.updatedAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        cardStatus: json["cardStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        experience: json["experience"],
        id: json["id"],
        idCard: List<String>.from(json["idCard"].map((x) => x)),
        licenseNumber: json["licenseNumber"],
        licenseStatus: json["licenseStatus"],
        licenseType: json["licenseType"],
        rate: json["rate"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "cardStatus": cardStatus,
        "createdAt": createdAt.toIso8601String(),
        "experience": experience,
        "id": id,
        "idCard": List<dynamic>.from(idCard.map((x) => x)),
        "licenseNumber": licenseNumber,
        "licenseStatus": licenseStatus,
        "licenseType": licenseType,
        "rate": rate,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
