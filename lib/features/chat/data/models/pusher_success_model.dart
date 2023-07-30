// To parse this JSON data, do
//
//     final modelSucessPusher = modelSucessPusherFromJson(jsonString);

import 'dart:convert';

ModelSucessPusher modelSucessPusherFromJson(String str) =>
    ModelSucessPusher.fromJson(json.decode(str));

String modelSucessPusherToJson(ModelSucessPusher data) =>
    json.encode(data.toJson());

class ModelSucessPusher {
  ModelSucessPusher({
    required this.presence,
  });

  Presence presence;

  factory ModelSucessPusher.fromJson(Map<String, dynamic> json) =>
      ModelSucessPusher(
        presence: Presence.fromJson(json["presence"]),
      );

  Map<String, dynamic> toJson() => {
        "presence": presence.toJson(),
      };
}

class Presence {
  Presence({
    required this.count,
    // required this.ids,
    // required this.hash,
  });

  int count;
  // List<String> ids;
  // Hash hash;

  factory Presence.fromJson(Map<String, dynamic> json) => Presence(
        count: json["count"],
        // ids: List<String>.from(json["ids"].map((x) => x)),
        // hash: Hash.fromJson(json["hash"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        // "ids": List<dynamic>.from(ids.map((x) => x)),
        // "hash": hash.toJson(),
      };
}

class Hash {
  Hash({
    required this.the25,
  });

  The25 the25;

  factory Hash.fromJson(Map<String, dynamic> json) => Hash(
        the25: The25.fromJson(json["25"]),
      );

  Map<String, dynamic> toJson() => {
        "25": the25.toJson(),
      };
}

class The25 {
  The25({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhotoPath,
  });

  int id;
  String name;
  dynamic email;
  String profilePhotoPath;

  factory The25.fromJson(Map<String, dynamic> json) => The25(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profilePhotoPath: json["profile_photo_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_photo_path": profilePhotoPath,
      };
}
