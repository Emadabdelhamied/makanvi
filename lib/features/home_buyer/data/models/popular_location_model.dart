// To parse this JSON data, do
//
//     final popularLocationModel = popularLocationModelFromJson(jsonString);

import 'dart:convert';

PopularLocationModel popularLocationModelFromJson(String str) =>
    PopularLocationModel.fromJson(json.decode(str));

String popularLocationModelToJson(PopularLocationModel data) =>
    json.encode(data.toJson());

class PopularLocationModel {
  PopularLocationModel({
    required this.popularLocations,
  });

  PopularLocations popularLocations;

  factory PopularLocationModel.fromJson(Map<String, dynamic> json) =>
      PopularLocationModel(
        popularLocations: PopularLocations.fromJson(json["popular_locations"]),
      );

  Map<String, dynamic> toJson() => {
        "popular_locations": popularLocations.toJson(),
      };
}

class PopularLocations {
  PopularLocations({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory PopularLocations.fromJson(Map<String, dynamic> json) =>
      PopularLocations(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.coverImagePath,
    required this.propertiesCount,
  });

  int id;
  String name;
  String coverImagePath;
  int propertiesCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        coverImagePath: json["cover_image_path"],
        propertiesCount: json["properties_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover_image_path": coverImagePath,
        "properties_count": propertiesCount,
      };
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
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
