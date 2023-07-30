// To parse this JSON data, do
//
//     final homeSellerModel = homeSellerModelFromJson(jsonString);

import 'dart:convert';

HomeSellerModel homeSellerModelFromJson(String str) =>
    HomeSellerModel.fromJson(json.decode(str));

String homeSellerModelToJson(HomeSellerModel data) =>
    json.encode(data.toJson());

class HomeSellerModel {
  HomeSellerModel({
    required this.recentlyNotifications,
    required this.subscriptions,
  });

  List<RecentlyNotificationHome> recentlyNotifications;
  SubscriptionsHomeSeller subscriptions;

  factory HomeSellerModel.fromJson(Map<String, dynamic> json) =>
      HomeSellerModel(
        recentlyNotifications: List<RecentlyNotificationHome>.from(
            json["recently_notifications"]
                .map((x) => RecentlyNotificationHome.fromJson(x))),
        subscriptions: SubscriptionsHomeSeller.fromJson(json["subscriptions"]),
      );

  Map<String, dynamic> toJson() => {
        "recently_notifications":
            List<dynamic>.from(recentlyNotifications.map((x) => x.toJson())),
        "subscriptions": subscriptions.toJson(),
      };
}

class RecentlyNotificationHome {
  RecentlyNotificationHome({
    required this.id,
    required this.title,
    required this.body,
    required this.name,
    this.profilePhotoPath,
    this.imagePath,
    required this.destination,
    this.destinationId,
    required this.read,
    required this.sendAt,
  });

  int id;
  String title;
  String body;
  String name;
  String? profilePhotoPath;
  String? imagePath;
  String destination;
  dynamic destinationId;
  int read;
  String sendAt;

  factory RecentlyNotificationHome.fromJson(Map<String, dynamic> json) =>
      RecentlyNotificationHome(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        name: json["name"],
        profilePhotoPath: json["profile_photo_path"],
        imagePath: json["image_path"],
        destination: json["destination"] ?? '',
        destinationId: json["destination_id"],
        read: json["read"],
        sendAt: json["send_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "name": name,
        "profile_photo_path": profilePhotoPath,
        "image_path": imagePath,
        "destination": destination,
        "destination_id": destinationId,
        "read": read,
        "send_at": sendAt,
      };
}

class SubscriptionsHomeSeller {
  SubscriptionsHomeSeller({
    this.listing,
    this.feature,
  });

  Feature? listing;
  Feature? feature;

  factory SubscriptionsHomeSeller.fromJson(Map<String, dynamic> json) =>
      SubscriptionsHomeSeller(
        listing:
            json["listing"] == null ? null : Feature.fromJson(json["listing"]),
        feature:
            json["feature"] == null ? null : Feature.fromJson(json["feature"]),
      );

  Map<String, dynamic> toJson() => {
        "listing": listing!.toJson(),
        "feature": feature!.toJson(),
      };
}

class Feature {
  Feature(
      {required this.id,
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
      required this.goTo,
      required this.cancled});

  int id;
  String name;
  String purpose;
  int price;
  String currency;
  int listingCount;
  int listingExpireDays;
  int packageExpireDays;
  int consume;
  String expireAt;
  String goTo;
  int expireAfter;
  int cancled;
  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
      id: json["id"],
      name: json["name"],
      purpose: json["purpose"],
      price: json["price"],
      currency: json["currency"],
      listingCount: json["listing_count"],
      listingExpireDays: json["listing_expire_days"],
      packageExpireDays: json["package_expire_days"],
      consume: json["consume"],
      expireAt: json["expire_at"],
      expireAfter: json["expire_after"],
      goTo: json["go_to"],
      cancled: json["cancelled"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "purpose": purpose,
        "price": price,
        "currency": currency,
        "listing_count": listingCount,
        "listing_expire_days": listingExpireDays,
        "package_expire_days": packageExpireDays,
        "consume": consume,
        "expire_at": expireAt,
        "expire_after": expireAfter,
      };
}
