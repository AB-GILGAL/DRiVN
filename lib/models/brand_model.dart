// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
    Data data;
    bool status;

    BrandModel({
        required this.data,
        required this.status,
    });

    factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
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
    List<BrandDataModel> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<BrandDataModel>.from(json["data"].map((x) => BrandDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BrandDataModel {
    int availableVehicles;
    DateTime createdAt;
    int id;
    String logo;
    String name;
    int unavailableVehicles;
    DateTime updatedAt;
    int vehicles;

    BrandDataModel({
        required this.availableVehicles,
        required this.createdAt,
        required this.id,
        required this.logo,
        required this.name,
        required this.unavailableVehicles,
        required this.updatedAt,
        required this.vehicles,
    });

    factory BrandDataModel.fromJson(Map<String, dynamic> json) => BrandDataModel(
        availableVehicles: json["availableVehicles"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
        unavailableVehicles: json["unavailableVehicles"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicles: json["vehicles"],
    );

    Map<String, dynamic> toJson() => {
        "availableVehicles": availableVehicles,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "logo": logo,
        "name": name,
        "unavailableVehicles": unavailableVehicles,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicles": vehicles,
    };
}
