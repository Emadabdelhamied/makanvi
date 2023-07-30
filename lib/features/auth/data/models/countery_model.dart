// To parse this JSON data, do
//
//     final counteryModel = counteryModelFromJson(jsonString);

import 'dart:convert';

CounteryModel counteryModelFromJson(String str) =>
    CounteryModel.fromJson(json.decode(str));

class CounteryModel {
  CounteryModel({
    required this.countries,
  });

  List<CountryAuth> countries;

  factory CounteryModel.fromJson(Map<String, dynamic> json) => CounteryModel(
        countries: List<CountryAuth>.from(
            json["countries"].map((x) => CountryAuth.fromJson(x))),
      );
}

class CountryAuth {
  CountryAuth({
    required this.id,
    required this.countryCode,
    required this.flagImg,
    required this.name,
    required this.shortName,
    required this.isActive,
    required this.show,
  });

  int id;
  String countryCode;
  String flagImg;
  String name;
  String shortName;
  int isActive;
  int show;

  factory CountryAuth.fromJson(Map<String, dynamic> json) => CountryAuth(
        id: json["id"],
        countryCode: json["country_code"],
        flagImg: json["flag_img"],
        name: json["name"],
        shortName: json["short_name"],
        isActive: json["is_active"],
        show: json["show"],
      );
}
