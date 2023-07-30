import 'dart:convert';

import '../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';

FavouritesModel favouritesModelFromJson(String str) =>
    FavouritesModel.fromJson(json.decode(str));

class FavouritesModel {
  FavouritesModel({
    required this.recently,
    required this.all,
  });

  List<Active> recently;
  List<Active> all;

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        recently:
            List<Active>.from(json["recently"].map((x) => Active.fromJson(x))),
        all: List<Active>.from(json["all"].map((x) => Active.fromJson(x))),
      );
}
