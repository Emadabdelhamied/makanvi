// To parse this JSON data, do
//
//     final featureAllModel = featureAllModelFromJson(jsonString);

import 'dart:convert';

import '../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';

FeatureAllModel featureAllModelFromJson(String str) =>
    FeatureAllModel.fromJson(json.decode(str));

String featureAllModelToJson(FeatureAllModel data) =>
    json.encode(data.toJson());

class FeatureAllModel {
  FeatureAllModel({
    required this.featured,
  });

  Featured featured;

  factory FeatureAllModel.fromJson(Map<String, dynamic> json) =>
      FeatureAllModel(
        featured: Featured.fromJson(json["featured"]),
      );

  Map<String, dynamic> toJson() => {
        "featured": featured.toJson(),
      };
}

class Featured {
  Featured({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<FeatureAllData> data;
  Links links;
  Meta meta;

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        data: List<FeatureAllData>.from(
            json["data"].map((x) => FeatureAllData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class FeatureAllData {
  FeatureAllData({
    required this.id,
    required this.title,
    this.isFav,
    this.url,
    required this.price,
    required this.currency,
    required this.status,
    required this.coverImage,
    required this.location,
    required this.listingExpireAfter,
    required this.featureExpireAfter,
    this.recommendedShootingDate,
    this.shootingDate,
  });

  int id;
  String title;
  dynamic isFav;
  dynamic url;
  int price;
  String status;
  String currency;
  String coverImage;
//  List<dynamic> images;
  Location location;
  int listingExpireAfter;
  int featureExpireAfter;
  DateTime? recommendedShootingDate;
  dynamic shootingDate;

  factory FeatureAllData.fromJson(Map<String, dynamic> json) => FeatureAllData(
        id: json["id"],
        title: json["title"],
        isFav: json["is_fav"],
        currency: json["currency"],
        url: json["url"],
        price: json["price"],
        status: json["status"],
        coverImage: json["cover_image_path"] ?? "",
        //  images: List<dynamic>.from(json["images"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        listingExpireAfter: json["listing_expire_after"],
        featureExpireAfter: json["feature_expire_after"],
        recommendedShootingDate: json["recommended_shooting_date"] == null
            ? null
            : DateTime.parse(json["recommended_shooting_date"]),
        shootingDate: json["shooting_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_fav": isFav,
        "url": url,
        "price": price,
        "status": status,
        //  "images": List<dynamic>.from(images.map((x) => x)),
        "listing_expire_after": listingExpireAfter,
        "feature_expire_after": featureExpireAfter,
        "recommended_shooting_date":
            "${recommendedShootingDate!.year.toString().padLeft(4, '0')}-${recommendedShootingDate!.month.toString().padLeft(2, '0')}-${recommendedShootingDate!.day.toString().padLeft(2, '0')}",
        "shooting_date": shootingDate,
      };
}

class Links {
  Links({
    required this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  dynamic last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] ?? "",
        last: json["last"] ?? "",
        prev: json["prev"] ?? "",
        next: json["next"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    this.from,
    required this.path,
    required this.perPage,
    this.to,
  });

  int currentPage;
  int? from;
  String path;
  int perPage;
  int? to;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "path": path,
        "per_page": perPage,
        "to": to,
      };
}
