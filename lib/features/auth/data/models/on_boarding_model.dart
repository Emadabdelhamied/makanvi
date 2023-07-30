// To parse this JSON data, do
//
//     final onBoardingModel = onBoardingModelFromJson(jsonString);

import 'dart:convert';

OnBoardingModel onBoardingModelFromJson(String str) =>
    OnBoardingModel.fromJson(json.decode(str));

String onBoardingModelToJson(OnBoardingModel data) =>
    json.encode(data.toJson());

class OnBoardingModel {
  OnBoardingModel({
    required this.onboards,
    // required this.countries,
  });

  List<Onboard> onboards;
  // List<Country> countries;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingModel(
        onboards: List<Onboard>.from(
            json["onboards"].map((x) => Onboard.fromJson(x))),
        // countries: List<Country>.from(
        //     json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "onboards": List<dynamic>.from(onboards.map((x) => x.toJson())),
        // "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    required this.id,
    required this.code,
    required this.flagImg,
    required this.title,
    required this.shortName,
    required this.isActive,
    required this.order,
    this.createdAt,
    required this.updatedAt,
  });

  int id;
  String code;
  String flagImg;
  String title;
  String shortName;
  int isActive;
  int order;
  dynamic createdAt;
  DateTime updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        code: json["code"],
        flagImg: json["flag_img"],
        title: json["title"],
        shortName: json["short_name"],
        isActive: json["is_active"],
        order: json["order"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "flag_img": flagImg,
        "title": title,
        "short_name": shortName,
        "is_active": isActive,
        "order": order,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Onboard {
  Onboard({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
  });

  int id;
  String title;
  String description;
  dynamic imagePath;

  factory Onboard.fromJson(Map<String, dynamic> json) => Onboard(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image_path": imagePath,
      };
}
