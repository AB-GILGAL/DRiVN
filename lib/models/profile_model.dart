// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String data;
    bool status;

    ProfileModel({
        required this.data,
        required this.status,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
    };
}
