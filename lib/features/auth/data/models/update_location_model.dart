// To parse this JSON data, do
//
//     final updateLocationModel = updateLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateLocationModel updateLocationModelFromJson(String str) =>
    UpdateLocationModel.fromJson(json.decode(str));

String updateLocationModelToJson(UpdateLocationModel data) =>
    json.encode(data.toJson());

class UpdateLocationModel {
  UpdateLocationModel({
    required this.country,
    required this.state,
    required this.city,
    required this.countryAr,
    required this.stateAr,
    required this.cityAr,
    required this.latitude,
    required this.longitude,
  });

  String country;
  String state;
  String city;
  String countryAr;
  String stateAr;
  String cityAr;
  String latitude;
  String longitude;

  factory UpdateLocationModel.fromJson(Map<String, dynamic> json) =>
      UpdateLocationModel(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        countryAr: json["country_ar"],
        stateAr: json["state_ar"],
        cityAr: json["city_ar"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "country_ar": countryAr,
        "state_ar": stateAr,
        "city_ar": cityAr,
        "latitude": latitude,
        "longitude": longitude,
      };
}
