// To parse this JSON data, do
//
//     final getMyListigsAllModel = getMyListigsAllModelFromJson(jsonString);

import 'dart:convert';

GetMyListigsAllModel getMyListigsAllModelFromJson(String str) =>
    GetMyListigsAllModel.fromJson(json.decode(str));

class GetMyListigsAllModel {
  GetMyListigsAllModel(
      {required this.properities, required this.subscriptions});

  Properities properities;
  Subscriptions subscriptions;

  factory GetMyListigsAllModel.fromJson(Map<String, dynamic> json) =>
      GetMyListigsAllModel(
        properities: Properities.fromJson(
          json["properities"],
        ),
        subscriptions: Subscriptions.fromJson(json["subscriptions"]),
      );
}

class Properities {
  Properities({
    required this.active,
    required this.pending,
    required this.expired,
  });

  List<Active> active;
  List<Active> pending;
  List<Active> expired;

  factory Properities.fromJson(Map<String, dynamic> json) => Properities(
        active:
            List<Active>.from(json["active"].map((x) => Active.fromJson(x))),
        pending:
            List<Active>.from(json["pending"].map((x) => Active.fromJson(x))),
        expired:
            List<Active>.from(json["expired"].map((x) => Active.fromJson(x))),
      );
}

class Active {
  Active({
    required this.id,
    required this.title,
    this.url,
    required this.price,
    required this.currency,
    required this.isFav,
    required this.status,
    required this.coverImage,
//    required this.images,
    required this.location,
    required this.listingExpireAfter,
    required this.featureExpireAfter,
    required this.recommendeShootingDate,
    required this.shootingDate,
  });

  int id;
  String title;
  String currency;
  bool isFav;
  dynamic url;
  int price;
  String status;
  String coverImage;
//  List<Image> images;
  Location location;
  int listingExpireAfter;
  int featureExpireAfter;
  String recommendeShootingDate;
  String shootingDate;

  factory Active.fromJson(Map<String, dynamic> json) => Active(
        id: json["id"],
        title: json["title"],
        currency: json["currency"],
        url: json["url"],
        price: json["price"],
        status: json["status"],
        isFav: json["is_fav"] ?? false,
        coverImage: json["cover_image_path"] ?? "",
        //  images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        location: Location.fromJson(json["location"]),
        listingExpireAfter: json["listing_expire_after"],
        featureExpireAfter: json["feature_expire_after"],
        recommendeShootingDate: json["recommended_shooting_date"] ?? '',
        shootingDate: json["shooting_date"] ?? '',
      );
}

class Location {
  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.city,
  });

  int id;
  String latitude;
  String longitude;
  String country;
  String state;
  String city;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
      );
}

class Subscriptions {
  Subscriptions({
    required this.listing,
    required this.feature,
  });

  FeatureData listing;
  FeatureData feature;

  factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        listing: json["listing"] == null
            ? FeatureData(
                id: 0,
                name: "",
                purpose: "",
                price: 0,
                currency: "",
                listingCount: 0,
                listingExpireDays: 0,
                packageExpireDays: 0,
                consume: 0,
                expireAt: DateTime.now(),
                cancelled: 0,
                goTo: "pay",
                expireAfter: 0)
            : FeatureData.fromJson(json["listing"]),
        feature: json["feature"] == null
            ? FeatureData(
                id: 0,
                name: "",
                purpose: "",
                price: 0,
                currency: "",
                listingCount: 0,
                listingExpireDays: 0,
                packageExpireDays: 0,
                consume: 0,
                expireAt: DateTime.now(),
                cancelled: 0,
                goTo: "pay",
                expireAfter: 0)
            : FeatureData.fromJson(json["feature"]),
      );
}

class Image {
  Image({
    required this.id,
    required this.propertyId,
    required this.path,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int propertyId;
  String path;
  int order;
  DateTime createdAt;
  DateTime updatedAt;
  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        propertyId: json["property_id"],
        path: json["path"],
        order: json["order"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class FeatureData {
  FeatureData({
    required this.id,
    required this.name,
    required this.purpose,
    required this.price,
    required this.currency,
    required this.listingCount,
    required this.listingExpireDays,
    required this.packageExpireDays,
    required this.consume,
    required this.expireAt,
    required this.expireAfter,
    required this.cancelled,
    required this.goTo,
  });

  int id;
  String name;
  String purpose;
  int price;
  String currency;
  int listingCount;
  int listingExpireDays;
  int packageExpireDays;
  int consume;
  DateTime expireAt;
  int expireAfter;
  int cancelled;
  String goTo;
  factory FeatureData.fromJson(Map<String, dynamic> json) => FeatureData(
        id: json["id"],
        name: json["name"],
        purpose: json["purpose"],
        price: json["price"],
        currency: json["currency"],
        listingCount: json["listing_count"],
        listingExpireDays: json["listing_expire_days"],
        packageExpireDays: json["package_expire_days"],
        consume: json["consume"],
        expireAt: DateTime.parse(json["expire_at"]),
        expireAfter: json["expire_after"],
        cancelled: json["cancelled"],
        goTo: json["go_to"],
      );
}
