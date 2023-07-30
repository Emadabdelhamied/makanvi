// To parse this JSON data, do
//
//     final recentlyAllModel = recentlyAllModelFromJson(jsonString);

import 'dart:convert';

import '../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';

RecentlyAllModel recentlyAllModelFromJson(String str) =>
    RecentlyAllModel.fromJson(json.decode(str));

class RecentlyAllModel {
  RecentlyAllModel({
    required this.recently,
  });

  Recently recently;

  factory RecentlyAllModel.fromJson(Map<String, dynamic> json) =>
      RecentlyAllModel(
        recently: Recently.fromJson(json["recently"]),
      );
}

class Recently {
  Recently({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<RecentlyAllData> data;
  Links links;
  Meta meta;

  factory Recently.fromJson(Map<String, dynamic> json) => Recently(
        data: List<RecentlyAllData>.from(
            json["data"].map((x) => RecentlyAllData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );
}

class RecentlyAllData {
  RecentlyAllData({
    required this.id,
    required this.title,
    this.isFav,
    this.url,
    required this.price,
    required this.currency,
    required this.status,
    //  required this.images,
    required this.location,
    required this.listingExpireAfter,
    required this.featureExpireAfter,
    required this.coverImage,
    this.recommendedShootingDate,
    this.shootingDate,
  });

  int id;
  String title;
  dynamic isFav;
  dynamic url;
  int price;
  String status;
  String coverImage;
  String currency;
  // List<dynamic> images;
  Location location;
  int listingExpireAfter;
  int featureExpireAfter;
  DateTime? recommendedShootingDate;
  dynamic shootingDate;

  factory RecentlyAllData.fromJson(Map<String, dynamic> json) =>
      RecentlyAllData(
        id: json["id"],
        currency: json["currency"],
        title: json["title"],
        isFav: json["is_fav"],
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
