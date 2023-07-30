// To parse this JSON data, do
//
//     final getAllMessagesModel = getAllMessagesModelFromJson(jsonString);

import 'dart:convert';

GetAllMessagesModel getAllMessagesModelFromJson(String str) =>
    GetAllMessagesModel.fromJson(json.decode(str));

String getAllMessagesModelToJson(GetAllMessagesModel data) =>
    json.encode(data.toJson());

class GetAllMessagesModel {
  GetAllMessagesModel({
    required this.messages,
    required this.prevPage,
  });

  List<MessageAll> messages;
  String prevPage;

  factory GetAllMessagesModel.fromJson(Map<String, dynamic> json) =>
      GetAllMessagesModel(
        messages: List<MessageAll>.from(
            json["messages"].map((x) => MessageAll.fromJson(x))),
        prevPage: json["prev_page"],
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "prev_page": prevPage,
      };
}

class MessageAll {
  MessageAll(
      {required this.id,
      required this.channelId,
      this.body,
      this.property,
      required this.senderId,
      required this.receiverId,
      required this.createdAt,
      required this.date,
      required this.time,
      required this.isSeen});

  int id;
  String channelId;
  String? body;
  PropertyMessage? property;
  int senderId;
  int isSeen;
  int receiverId;
  String createdAt;
  String time;
  String date;

  factory MessageAll.fromJson(Map<String, dynamic> json) => MessageAll(
      id: json["id"],
      channelId: json["channel_id"].toString(),
      body: json["body"],
      property: json["property"] == null
          ? null
          : PropertyMessage.fromJson(json["property"]),
      senderId: json["sender_id"],
      receiverId: json["receiver_id"],
      createdAt: json["since"],
      date: json["date"],
      isSeen: json["seen"],
      time: json["time"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "channel_id": channelId,
        "body": body,
        "property": property?.toJson(),
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt,
        "time": time,
        "date": date
      };
}

class PropertyMessage {
  PropertyMessage({
    required this.id,
    required this.title,
    this.isFav,
    this.url,
    required this.price,
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
  String coverImage;
//  List<dynamic> images;
  Location location;
  int listingExpireAfter;
  int featureExpireAfter;
  dynamic recommendedShootingDate;
  dynamic shootingDate;

  factory PropertyMessage.fromJson(Map<String, dynamic> json) =>
      PropertyMessage(
        id: json["id"],
        title: json["title"],
        coverImage: json["cover_image_path"] ?? "",
        isFav: json["is_fav"],
        url: json["url"],
        price: json["price"],
        status: json["status"],
        //  images: List<dynamic>.from(json["images"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        listingExpireAfter: json["listing_expire_after"],
        featureExpireAfter: json["feature_expire_after"],
        recommendedShootingDate: json["recommended_shooting_date"],
        shootingDate: json["shooting_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_fav": isFav,
        "url": url,
        "price": price,
        "status": status,
        // "images": List<dynamic>.from(images.map((x) => x)),
        "location": location.toJson(),
        "listing_expire_after": listingExpireAfter,
        "feature_expire_after": featureExpireAfter,
        "recommended_shooting_date": recommendedShootingDate,
        "shooting_date": shootingDate,
      };
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
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"] ?? '',
        state: json["state"],
        city: json["city"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "state": state,
        "city": city,
      };
}
