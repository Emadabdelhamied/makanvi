import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  RegisterEntity({
    required this.user,
    required this.token,
  });

  User user;
  String token;
  @override
  List<Object?> get props => [user, token];
}

class User extends Equatable {
  User(
      {required this.id,
      required this.name,
      this.email,
      this.accountType,
      required this.accountMode,
      required this.lang,
      required this.profilePhotoPath,
      required this.mobileNumber,
      required this.mobileNumberVerifiedAt,
      required this.accountStatus,
      required this.provider,
      required this.country,
      this.locationUser,
      required this.mobileCountry,
      this.createdAt,
      this.goTo,
      this.packageId});
  int id;
  String name;
  String? email;
  String? accountType;
  String accountMode;
  String lang;
  dynamic profilePhotoPath;
  dynamic mobileNumber;
  dynamic mobileNumberVerifiedAt;
  String accountStatus;
  String provider;
  dynamic country;
  LocationUser? locationUser;
  dynamic mobileCountry;
  String? createdAt;
  String? goTo;
  int? packageId;
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        mobileNumber,
        accountType,
        accountMode,
        lang,
        profilePhotoPath,
        mobileNumber,
        mobileNumberVerifiedAt,
        accountStatus,
        provider,
        country,
        mobileCountry,
        createdAt,
        goTo,
        packageId
      ];
}

class LocationUser {
  LocationUser({
    this.id,
    this.latitude,
    this.longitude,
    this.country,
    this.state,
    this.city,
  });

  int? id;
  String? latitude;
  String? longitude;
  String? country;
  String? state;
  String? city;

  factory LocationUser.fromJson(Map<String, dynamic> json) => LocationUser(
        id: json["id"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        country: json["country"] ?? "",
        state: json["state"] ?? "",
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
