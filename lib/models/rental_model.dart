// To parse this JSON data, do
//
//     final rentalVehicleModel = rentalVehicleModelFromJson(jsonString);

import 'dart:convert';

RentalVehicleModel rentalVehicleModelFromJson(String str) =>
    RentalVehicleModel.fromJson(json.decode(str));

String rentalVehicleModelToJson(RentalVehicleModel data) =>
    json.encode(data.toJson());

class RentalVehicleModel {
  Data? data;
  bool status;

  RentalVehicleModel({
    required this.data,
    required this.status,
  });

  factory RentalVehicleModel.fromJson(Map<String, dynamic> json) =>
      RentalVehicleModel(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  int count;
  List<Vehicle> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Vehicle>.from(json["data"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Vehicle {
  String availability;
  bool booked;
  String brand;
  DateTime createdAt;
  List<Document> documents;
  List<Feature> features;
  int id;
  List<Image> images;
  Owner owner;
  Rental? rental;
  String type;
  DateTime updatedAt;

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.createdAt,
    required this.documents,
    required this.features,
    required this.id,
    required this.images,
    required this.owner,
    this.rental,
    required this.type,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        createdAt: DateTime.parse(json["createdAt"]),
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        rental: json["rental"] == null ? null : Rental.fromJson(json["rental"]),
        type: json["type"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "availability": availability,
        "booked": booked,
        "brand": brand,
        "createdAt": createdAt.toIso8601String(),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "rental": rental?.toJson(),
        "type": type,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Document {
  String document;
  int id;

  Document({
    required this.document,
    required this.id,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        document: json["document"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "id": id,
      };
}

class Feature {
  int id;
  String info;
  String name;
  String slug;

  Feature({
    required this.id,
    required this.info,
    required this.name,
    required this.slug,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        info: json["info"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "info": info,
        "name": name,
        "slug": slug,
      };
}

class Image {
  int id;
  String image;

  Image({
    required this.id,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Owner {
  String firstName;
  int id;
  String lastName;

  Owner({
    required this.firstName,
    required this.id,
    required this.lastName,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
      };
}

class Rental {
  int id;
  String location;
  int price;
  Driver? driver;

  Rental({
    required this.id,
    required this.location,
    required this.price,
    this.driver,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        id: json["id"],
        location: json["location"],
        price: json["price"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "price": price,
        "driver": driver?.toJson(),
      };
}

class Driver {
  int experience;
  String firstName;
  int id;
  String lastName;
  int rate;

  Driver({
    required this.experience,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.rate,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        experience: json["experience"],
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "experience": experience,
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "rate": rate,
      };
}
