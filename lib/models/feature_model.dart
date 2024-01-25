// To parse this JSON data, do
//
//     final featureModel = featureModelFromJson(jsonString);

import 'dart:convert';

FeatureModel featureModelFromJson(String str) => FeatureModel.fromJson(json.decode(str));

String featureModelToJson(FeatureModel data) => json.encode(data.toJson());

class FeatureModel {
    Data data;
    bool status;

    FeatureModel({
        required this.data,
        required this.status,
    });

    factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
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
    List<FeatureDataModel> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<FeatureDataModel>.from(json["data"].map((x) => FeatureDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class FeatureDataModel {
    DateTime createdAt;
    int id;
    String info;
    String name;
    DateTime updatedAt;

    FeatureDataModel({
        required this.createdAt,
        required this.id,
        required this.info,
        required this.name,
        required this.updatedAt,
    });

    factory FeatureDataModel.fromJson(Map<String, dynamic> json) => FeatureDataModel(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        info: json["info"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "info": info,
        "name": name,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
