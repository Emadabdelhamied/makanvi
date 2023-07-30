// To parse this JSON data, do
//
//     final getDataAddPropertyModel = getDataAddPropertyModelFromJson(jsonString);

import 'dart:convert';

GetDataAddPropertyModel getDataAddPropertyModelFromJson(String str) =>
    GetDataAddPropertyModel.fromJson(json.decode(str));

String getDataAddPropertyModelToJson(GetDataAddPropertyModel data) =>
    json.encode(data.toJson());

class GetDataAddPropertyModel {
  GetDataAddPropertyModel({
    required this.offerTypes,
    required this.types,
    required this.amenities,
    required this.features,
    required this.currencies,
    required this.maxArea,
    required this.maxPrice,
    required this.minArea,
    required this.minPrice,
  });

  List<TypeProparty> offerTypes;
  List<TypeProparty> types;
  List<Amenity> amenities;
  List<Amenity> features;
  List<String> currencies;
  double minPrice;
  double maxPrice;
  double minArea;
  double maxArea;

  factory GetDataAddPropertyModel.fromJson(Map<String, dynamic> json) =>
      GetDataAddPropertyModel(
        offerTypes: List<TypeProparty>.from(
            json["offer_types"].map((x) => TypeProparty.fromJson(x))),
        types: List<TypeProparty>.from(
            json["types"].map((x) => TypeProparty.fromJson(x))),
        amenities: List<Amenity>.from(
            json["amenities"].map((x) => Amenity.fromJson(x))),
        features: List<Amenity>.from(
            json["features"].map((x) => Amenity.fromJson(x))),
        currencies: List<String>.from(
          json["currencies"].map((x) => x),
        ),
        minPrice: double.parse(json["min_price"].toString()),
        minArea: double.parse(json["min_area"].toString()),
        maxArea: double.parse(json["max_area"].toString()),
        maxPrice: double.parse(json["max_price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "offer_types": List<dynamic>.from(offerTypes.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Amenity {
  Amenity({
    required this.id,
    required this.title,
    this.iconPath,
  });

  int id;
  String title;
  String? iconPath;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json["id"],
        title: json["title"],
        iconPath: json["icon_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon_path": iconPath,
      };
}

class TypeProparty {
  TypeProparty({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory TypeProparty.fromJson(Map<String, dynamic> json) => TypeProparty(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
