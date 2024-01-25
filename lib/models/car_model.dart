class CarsModel {
  int cRate;

  CarsModel({
    required this.cRate,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) => CarsModel(
        cRate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "rate": cRate,
      };
}

class RideShareModel {
  String? rLocation;
  String? rImg;

  RideShareModel({required this.rLocation, required this.rImg});

  factory RideShareModel.fromJson(Map<String, dynamic> json) => RideShareModel(
        rLocation: json["location"],
        rImg: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "model": rLocation,
        "image": rImg,
      };
}
