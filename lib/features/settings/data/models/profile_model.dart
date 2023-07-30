// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.profile,
  });

  Profile profile;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.accountType,
    required this.accountMode,
    this.agencyName,
    required this.lang,
    this.profilePhotoPath,
    required this.mobileNumber,
    required this.mobileNumberVerifiedAt,
    required this.accountStatus,
    required this.provider,
    required this.country,
    required this.mobileCountry,
    // required this.location,
    // required this.packages,
    // this.lastShootedPropertyId,
    // required this.createdAt,
  });

  int id;
  String name;
  String email;
  String accountType;
  String accountMode;
  dynamic agencyName;
  String lang;
  dynamic profilePhotoPath;
  String mobileNumber;
  String mobileNumberVerifiedAt;
  String accountStatus;
  String provider;
  Country country;
  Country mobileCountry;
  // Location location;
  // List<Package> packages;
  // dynamic lastShootedPropertyId;
  // DateTime createdAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        accountType: json["account_type"] ?? "",
        accountMode: json["account_mode"],
        agencyName: json["agency_name"],
        lang: json["lang"],
        profilePhotoPath: json["profile_photo_path"],
        mobileNumber: json["mobile_number"],
        mobileNumberVerifiedAt: json["mobile_number_verified_at"],
        accountStatus: json["account_status"],
        provider: json["provider"],
        country: json["country"] == null
            ? Country(
                id: 1,
                countryCode: "",
                flagImg: "",
                name: "",
                shortName: "",
                isActive: 1,
                show: 0)
            : Country.fromJson(json["country"]),
        mobileCountry: Country.fromJson(json["mobile_country"]),
        // location: Location.fromJson(json["location"]),
        // packages: List<Package>.from(
        //     json["packages"].map((x) => Package.fromJson(x))),
        // lastShootedPropertyId: json["last_shooted_property_id"],
        // createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "account_type": accountType,
        "account_mode": accountMode,
        "agency_name": agencyName,
        "lang": lang,
        "profile_photo_path": profilePhotoPath,
        "mobile_number": mobileNumber,
        "mobile_number_verified_at": mobileNumberVerifiedAt,
        "account_status": accountStatus,
        "provider": provider,
        "country": country.toJson(),
        "mobile_country": mobileCountry.toJson(),
        // "location": location.toJson(),
        // "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
        // "last_shooted_property_id": lastShootedPropertyId,
        // "created_at":
        //     "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class Country {
  Country({
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

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        countryCode: json["country_code"],
        flagImg: json["flag_img"],
        name: json["name"],
        shortName: json["short_name"],
        isActive: json["is_active"],
        show: json["show"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_code": countryCode,
        "flag_img": flagImg,
        "name": name,
        "short_name": shortName,
        "is_active": isActive,
        "show": show,
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
        country: json["country"],
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

class Package {
  Package({
    required this.id,
    required this.name,
    required this.purpose,
    required this.price,
    required this.currency,
    required this.listingCount,
    required this.listingExpireDays,
    required this.packageExpireDays,
    required this.consume,
    required this.expireAt,
  });

  int id;
  String name;
  String purpose;
  int price;
  String currency;
  int listingCount;
  int listingExpireDays;
  int packageExpireDays;
  int consume;
  DateTime expireAt;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        purpose: json["purpose"],
        price: json["price"],
        currency: json["currency"],
        listingCount: json["listing_count"],
        listingExpireDays: json["listing_expire_days"],
        packageExpireDays: json["package_expire_days"],
        consume: json["consume"],
        expireAt: DateTime.parse(json["expire_at"]),
      );

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
        "expire_at":
            "${expireAt.year.toString().padLeft(4, '0')}-${expireAt.month.toString().padLeft(2, '0')}-${expireAt.day.toString().padLeft(2, '0')}",
      };
}
