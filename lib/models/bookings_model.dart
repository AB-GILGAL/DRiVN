// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
    Data? data;
    bool status;

    BookingModel({
         this.data,
        required this.status,
    });

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        data: Data.fromJson(json["data"]??{}),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
    };
}

class Data {
    int? count;
    List<BookingDataModel> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<BookingDataModel>.from(json["data"]?.map((x) => BookingDataModel.fromJson(x))??[]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BookingDataModel {
    String bookingStatus;
    DateTime createdAt;
    List<Request>? driverRequests;
    int id;
    String reference;
    Rental rental;
    String tripEndedAt;
    String tripStartedAt;
    String tripStatus;
    DateTime updatedAt;
    bool withDriver;
    List<Request>? vehicleRequests;
    Vehicle? vehicle;

    BookingDataModel({
        required this.bookingStatus,
        required this.createdAt,
        this.driverRequests,
        required this.id,
        required this.reference,
        required this.rental,
        required this.tripEndedAt,
        required this.tripStartedAt,
        required this.tripStatus,
        required this.updatedAt,
        required this.withDriver,
        this.vehicleRequests,
        this.vehicle,
    });

    factory BookingDataModel.fromJson(Map<String, dynamic> json) => BookingDataModel(
        bookingStatus: json["bookingStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        driverRequests: json["driverRequests"] == null ? [] : List<Request>.from(json["driverRequests"]!.map((x) => Request.fromJson(x))),
        id: json["id"],
        reference: json["reference"],
        rental: Rental.fromJson(json["rental"]),
        tripEndedAt: json["tripEndedAt"],
        tripStartedAt: json["tripStartedAt"],
        tripStatus: json["tripStatus"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        withDriver: json["withDriver"],
        vehicleRequests: json["vehicleRequests"] == null ? [] : List<Request>.from(json["vehicleRequests"]!.map((x) => Request.fromJson(x))),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    );

    Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
        "createdAt": createdAt.toIso8601String(),
        "driverRequests": driverRequests == null ? [] : List<dynamic>.from(driverRequests!.map((x) => x.toJson())),
        "id": id,
        "reference": reference,
        "rental": rental.toJson(),
        "tripEndedAt": tripEndedAt,
        "tripStartedAt": tripStartedAt,
        "tripStatus": tripStatus,
        "updatedAt": updatedAt.toIso8601String(),
        "withDriver": withDriver,
        "vehicleRequests": vehicleRequests == null ? [] : List<dynamic>.from(vehicleRequests!.map((x) => x.toJson())),
        "vehicle": vehicle?.toJson(),
    };
}

class Request {
    DateTime createdAt;
    String declineReason;
    Customer? driver;
    int id;
    String status;
    DateTime updatedAt;
    Vehicle? vehicle;

    Request({
        required this.createdAt,
        required this.declineReason,
        this.driver,
        required this.id,
        required this.status,
        required this.updatedAt,
        this.vehicle,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        createdAt: DateTime.parse(json["createdAt"]),
        declineReason: json["declineReason"],
        driver: json["driver"] == null ? null : Customer.fromJson(json["driver"]),
        id: json["id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "declineReason": declineReason,
        "driver": driver?.toJson(),
        "id": id,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicle": vehicle?.toJson(),
    };
}

class Customer {
    String firstName;
    int id;
    String lastName;
    String username;

    Customer({
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.username,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "username": username,
    };
}

class Vehicle {
    String availability;
    bool booked;
    String brand;
    List<Feature> features;
    int id;
    List<Image> images;
    Customer owner;
    String type;

    Vehicle({
        required this.availability,
        required this.booked,
        required this.brand,
        required this.features,
        required this.id,
        required this.images,
        required this.owner,
        required this.type,
    });

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: Customer.fromJson(json["owner"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "availability": availability,
        "booked": booked,
        "brand": brand,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "type": type,
    };
}

class Feature {
    int id;
    String info;
    String name;

    Feature({
        required this.id,
        required this.info,
        required this.name,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        info: json["info"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "info": info,
        "name": name,
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

class Rental {
    Customer customer;
    String customerLocation;
    String customerLocationAudio;
    int driverAmount;
    String paymentStatus;
    DateTime pickupDate;
    DateTime pickupTime;
    String returnDate;
    String returnTime;
    List<Transaction>? transactions;
    int vehicleAmount;
    int? refundAmount;

    Rental({
        required this.customer,
        required this.customerLocation,
        required this.customerLocationAudio,
        required this.driverAmount,
        required this.paymentStatus,
        required this.pickupDate,
        required this.pickupTime,
        required this.returnDate,
        required this.returnTime,
        this.transactions,
        required this.vehicleAmount,
        this.refundAmount,
    });

    factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        customer: Customer.fromJson(json["customer"]),
        customerLocation: json["customerLocation"],
        customerLocationAudio: json["customerLocationAudio"],
        driverAmount: json["driverAmount"],
        paymentStatus: json["paymentStatus"],
        pickupDate: DateTime.parse(json["pickupDate"]),
        pickupTime: DateTime.parse(json["pickupTime"]),
        returnDate: json["returnDate"],
        returnTime: json["returnTime"],
        transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
        vehicleAmount: json["vehicleAmount"],
        refundAmount: json["refundAmount"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "customerLocation": customerLocation,
        "customerLocationAudio": customerLocationAudio,
        "driverAmount": driverAmount,
        "paymentStatus": paymentStatus,
        "pickupDate": pickupDate.toIso8601String(),
        "pickupTime": pickupTime.toIso8601String(),
        "returnDate": returnDate,
        "returnTime": returnTime,
        "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "vehicleAmount": vehicleAmount,
        "refundAmount": refundAmount,
    };
}

class Transaction {
    int amount;
    String channel;
    DateTime createdAt;
    int id;
    DateTime paidAt;
    String reference;
    String transType;
    DateTime updatedAt;

    Transaction({
        required this.amount,
        required this.channel,
        required this.createdAt,
        required this.id,
        required this.paidAt,
        required this.reference,
        required this.transType,
        required this.updatedAt,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        channel: json["channel"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        paidAt: DateTime.parse(json["paidAt"]),
        reference: json["reference"],
        transType: json["transType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "channel": channel,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "paidAt": paidAt.toIso8601String(),
        "reference": reference,
        "transType": transType,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
