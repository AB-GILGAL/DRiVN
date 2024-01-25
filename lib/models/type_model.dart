// To parse this JSON data, do
//
//     final typeModel = typeModelFromJson(jsonString);

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));

String typeModelToJson(TypeModel data) => json.encode(data.toJson());

class TypeModel {
    Data data;
    bool status;

    TypeModel({
        required this.data,
        required this.status,
    });

    factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    int count;
    List<TypeDataModel> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<TypeDataModel>.from(json["data"].map((x) => TypeDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TypeDataModel {
    DateTime createdAt;
    int id;
    String name;
    DateTime updatedAt;

    TypeDataModel({
        required this.createdAt,
        required this.id,
        required this.name,
        required this.updatedAt,
    });

    factory TypeDataModel.fromJson(Map<String, dynamic> json) => TypeDataModel(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "name": name,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
