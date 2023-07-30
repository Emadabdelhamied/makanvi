import 'dart:convert';

import '../../../../auth/data/models/get_data_add_probalty_model.dart';
import 'my_listings_all_model.dart';

MyListingModel myListingModelFromJson(String str) =>
    MyListingModel.fromJson(json.decode(str));

class MyListingModel {
  MyListingModel({
    required this.property,
  });

  Property property;

  factory MyListingModel.fromJson(Map<String, dynamic> json) => MyListingModel(
        property: Property.fromJson(json["property"]),
      );
}

class Property {
  Property({
    required this.id,
    required this.title,
    this.url,
    required this.area,
    required this.currency,
    required this.isNegotiable,
    required this.price,
    required this.status,
    this.type,
    this.offerType,
    required this.description,
    this.features,
    this.amenities,
    required this.images,
    required this.coverImage,
    required this.location,
    required this.recommendedShootingDate,
    this.shootingDate,
    this.user,
    this.createdAt,
    required this.listingExpireAfter,
    required this.featureExpireAfter,
    required this.isFav,
  });

  int id;
  String title;
  String currency;
  dynamic url;
  int area;
  int isNegotiable;
  int price;
  String status;
  Type? type;
  Type? offerType;
  String description;
  String coverImage;
  PropertyUser? user;
  List<Features>? features;
  List<Amenity>? amenities;
  List<Image> images;
  Location location;
  DateTime recommendedShootingDate;
  dynamic shootingDate;
  DateTime? createdAt;
  int listingExpireAfter;
  int featureExpireAfter;
  bool isFav;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        currency: json["currency"],
        isFav: json["is_fav"] ?? false,
        user: json["user"] == null ? null : PropertyUser.fromJson(json["user"]),
        area: json["area"] ?? 0,
        isNegotiable: json["is_negotiable"] ?? 0,
        price: json["price"],
        status: json["status"],
        coverImage: json["cover_image_path"] ?? "",
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        offerType: json["offer_type"] == null
            ? null
            : Type.fromJson(json["offer_type"]),
        description: json["description"] ?? '',
        features: json["features"] == null
            ? null
            : List<Features>.from(
                json["features"].map((x) => Features.fromJson(x))),
        amenities: json["amenities"] == null
            ? null
            : List<Amenity>.from(
                json["amenities"].map((x) => Amenity.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        location: Location.fromJson(json["location"]),
        recommendedShootingDate: json["recommended_shooting_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["recommended_shooting_date"]),
        shootingDate: json["shooting_date"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        listingExpireAfter: json["listing_expire_after"],
        featureExpireAfter: json["feature_expire_after"],
      );
}

class Features {
  Features({
    required this.id,
    required this.title,
    required this.count,
    required this.path,
  });

  int id;
  String title;
  int count;
  String path;

  factory Features.fromJson(Map<String, dynamic> json) => Features(
      id: json["id"],
      title: json["title"],
      count: json["count"] ?? 0,
      path: json['icon_path'] ?? "");
}

class Type {
  Type({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        title: json["title"],
      );
}

class PropertyUser {
  PropertyUser({
    required this.id,
    required this.name,
    this.agencyName,
    required this.email,
    required this.profilePhotoPath,
    required this.mobileNumber,
    required this.mobileCountry,
  });

  int id;
  String name;
  dynamic agencyName;
  String email;
  String profilePhotoPath;
  String mobileNumber;
  MobileCountry mobileCountry;

  factory PropertyUser.fromJson(Map<String, dynamic> json) => PropertyUser(
        id: json["id"],
        name: json["name"],
        agencyName: json["agency_name"],
        email: json["email"],
        profilePhotoPath: json["profile_photo_path"] ??
            'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png',
        mobileNumber: json["mobile_number"],
        mobileCountry: MobileCountry.fromJson(json["mobile_country"]),
      );
}

class MobileCountry {
  MobileCountry({
    required this.id,
    required this.countryCode,
    required this.flagImg,
    required this.name,
    required this.shortName,
    required this.isActive,
    required this.show,
  });

  int id;
  String countryCode;
  String flagImg;
  String name;
  String shortName;
  int isActive;
  int show;

  factory MobileCountry.fromJson(Map<String, dynamic> json) => MobileCountry(
        id: json["id"],
        countryCode: json["country_code"],
        flagImg: json["flag_img"],
        name: json["name"],
        shortName: json["short_name"],
        isActive: json["is_active"],
        show: json["show"],
      );
}
