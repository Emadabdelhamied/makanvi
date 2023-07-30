import 'dart:convert';

import 'package:makanvi_web/features/seller_pages/listining_seller/data/models/my_listings_all_model.dart';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

class SearchModel {
  SearchModel({
    required this.properties,
    required this.total,
  });

  Properties properties;
  int total;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
      properties: Properties.fromJson(json["properties"]),
      total: json['total']);
}

class Properties {
  Properties({
    required this.data,
    required this.meta,
  });

  List<Active> data;
  Meta meta;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        data: List<Active>.from(json["data"].map((x) => Active.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
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
}
