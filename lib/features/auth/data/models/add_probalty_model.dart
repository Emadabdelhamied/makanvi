// To parse this JSON data, do
//
//     final addPropartyModel = addPropartyModelFromJson(jsonString);

import 'dart:convert';

AddPropartyModel addPropartyModelFromJson(String str) =>
    AddPropartyModel.fromJson(json.decode(str));

String addPropartyModelToJson(AddPropartyModel data) =>
    json.encode(data.toJson());

class AddPropartyModel {
  AddPropartyModel({
    required this.offerTypeId,
    this.typeId,
    this.area,
    required this.price,
    required this.amenities,
    required this.features,
    required this.isNegotiable,
    required this.recommendedShootingDate,
    required this.country,
    required this.state,
    required this.city,
    required this.countryAr,
    required this.stateAr,
    required this.cityAr,
    required this.latitude,
    required this.longitude,
    required this.descriptionAr,
    required this.descriptionEn,
    this.currency,
  });

  int offerTypeId;
  int? typeId;
  String? area;
  String price;
  List<int> amenities;
  List<FeatureAddProbalty> features;
  int isNegotiable;
  String recommendedShootingDate;
  String country;
  String? currency;
  String state;
  String city;
  String countryAr;
  String stateAr;
  String cityAr;
  double latitude;
  double longitude;
  String descriptionAr;
  String descriptionEn;

  factory AddPropartyModel.fromJson(Map<String, dynamic> json) =>
      AddPropartyModel(
        offerTypeId: json["offer_type_id"] ?? 0,
        currency: json["currency"],
        typeId: json["type_id"],
        area: json["area"],
        price: json["price"],
        amenities: List<int>.from(json["amenities"].map((x) => x)),
        features: List<FeatureAddProbalty>.from(
            json["features"].map((x) => FeatureAddProbalty.fromJson(x))),
        isNegotiable: json["is_negotiable"],
        recommendedShootingDate: json["recommended_shooting_date"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        countryAr: json["country_ar"],
        stateAr: json["state_ar"],
        cityAr: json["city_ar"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
      );

  Map<String, dynamic> toJson() => {
        "offer_type_id": offerTypeId,
        "type_id": typeId,
        "area": area,
        "price": price,
        "currency": currency,
        "amenities": List<dynamic>.from(amenities.map((x) => x)).toList(),
        "features":
            List<FeatureAddProbalty>.from(features.map((x) => x)).toList(),
        "is_negotiable": isNegotiable,
        "recommended_shooting_date": recommendedShootingDate,
        "country": country,
        "state": state,
        "city": city,
        "country_ar": countryAr,
        "state_ar": stateAr,
        "city_ar": cityAr,
        "latitude": latitude,
        "longitude": longitude,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
      };

  Map<String, dynamic> toJsonApi() => {
        "offer_type_id": offerTypeId,
        "type_id": typeId,
        "area": area,
        "price": price,
        "currency": currency,
        "amenities[]": List<dynamic>.from(amenities.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "is_negotiable": isNegotiable,
        "recommended_shooting_date": recommendedShootingDate,
        "country": country,
        "state": state,
        "city": city,
        "country_ar": countryAr,
        "state_ar": stateAr,
        "city_ar": cityAr,
        "latitude": latitude,
        "longitude": longitude,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
      };
}

class FeatureAddProbalty {
  FeatureAddProbalty({
    required this.id,
    required this.count,
  });

  int id;
  int count;

  factory FeatureAddProbalty.fromJson(Map<String, dynamic> json) =>
      FeatureAddProbalty(
        id: json["id"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
      };
}
