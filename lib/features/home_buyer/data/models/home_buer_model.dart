// To parse this JSON data, do
//
//     final homeBuyerModel = homeBuyerModelFromJson(jsonString);

import 'dart:convert';

HomeBuyerModel homeBuyerModelFromJson(String str) =>
    HomeBuyerModel.fromJson(json.decode(str));

String homeBuyerModelToJson(HomeBuyerModel data) => json.encode(data.toJson());

class HomeBuyerModel {
  HomeBuyerModel({
    required this.propertyTypes,
    required this.popularLocations,
    required this.projects,
    required this.featured,
    required this.recently,
  });

  List<PropertyType> propertyTypes;
  List<PopularLocation> popularLocations;
  List<PopularLocation> projects;
  List<Featured> featured;
  List<Featured> recently;

  factory HomeBuyerModel.fromJson(Map<String, dynamic> json) => HomeBuyerModel(
        propertyTypes: List<PropertyType>.from(
            json["property_types"].map((x) => PropertyType.fromJson(x))),
        popularLocations: List<PopularLocation>.from(
            json["popular_locations"].map((x) => PopularLocation.fromJson(x))),
        projects: List<PopularLocation>.from(
            json["projects"].map((x) => PopularLocation.fromJson(x))),
        featured: List<Featured>.from(
            json["featured"].map((x) => Featured.fromJson(x))),
        recently: List<Featured>.from(
            json["recently"].map((x) => Featured.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "property_types":
            List<dynamic>.from(propertyTypes.map((x) => x.toJson())),
        "popular_locations":
            List<dynamic>.from(popularLocations.map((x) => x.toJson())),
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
        "featured": List<dynamic>.from(featured.map((x) => x.toJson())),
        "recently": List<dynamic>.from(recently.map((x) => x.toJson())),
      };
}

class Featured {
  Featured({
    required this.id,
    required this.title,
    this.isFav,
    this.url,
    required this.price,
    required this.currency,
    required this.status,
//    required this.images,
    required this.coverImage,
    required this.location,
    required this.listingExpireAfter,
    required this.featureExpireAfter,
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

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        id: json["id"],
        currency: json["currency"],
        title: json["title"],
        isFav: json["is_fav"] ?? false,
        url: json["url"],
        price: json["price"],
        status: json["status"],
        coverImage: json["cover_image_path"] ?? "",
        //  images: List<dynamic>.from(json["images"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        listingExpireAfter: json["listing_expire_after"],
        featureExpireAfter: json["feature_expire_after"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_fav": isFav,
        "url": url,
        "price": price,
        "status": status,
        //  "images": List<dynamic>.from(images.map((x) => x)),
        "location": location.toJson(),
        "listing_expire_after": listingExpireAfter,
        "feature_expire_after": featureExpireAfter,
      };
}

class Location {
  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    this.city,
  });

  int id;
  String latitude;
  String longitude;
  String country;
  String state;
  String? city;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"] ?? "",
        state: json["state"],
        city: json["city"],
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

class PopularLocation {
  PopularLocation({
    required this.id,
    required this.name,
    required this.coverImagePath,
    this.description,
  });

  int id;
  String name;
  String coverImagePath;
  String? description;

  factory PopularLocation.fromJson(Map<String, dynamic> json) =>
      PopularLocation(
        id: json["id"],
        name: json["name"],
        coverImagePath: json["cover_image_path"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover_image_path": coverImagePath,
        "description": description,
      };
}

class PropertyType {
  PropertyType({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
