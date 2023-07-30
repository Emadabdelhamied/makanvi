// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.recent,
    required this.older,
  });

  List<NotifcationCalss> recent;
  Older older;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        recent: List<NotifcationCalss>.from(
            json["recent"].map((x) => NotifcationCalss.fromJson(x))),
        older: Older.fromJson(json["older"]),
      );

  Map<String, dynamic> toJson() => {
        "recent": List<dynamic>.from(recent.map((x) => x.toJson())),
        "older": older.toJson(),
      };
}

class Older {
  Older({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<NotifcationCalss> data;
  Links links;
  Meta meta;

  factory Older.fromJson(Map<String, dynamic> json) => Older(
        data: List<NotifcationCalss>.from(
            json["data"].map((x) => NotifcationCalss.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class NotifcationCalss {
  NotifcationCalss({
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
  int? destinationId;
  int read;
  String sendAt;

  factory NotifcationCalss.fromJson(Map<String, dynamic> json) =>
      NotifcationCalss(
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
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
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
    required this.from,
    required this.path,
    required this.perPage,
    this.to,
  });

  int currentPage;
  int from;
  String path;
  int perPage;
  int? to;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"] ?? 0,
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? 0,
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "path": path,
        "per_page": perPage,
        "to": to,
      };
}
