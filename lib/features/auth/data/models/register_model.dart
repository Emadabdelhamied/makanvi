import 'dart:convert';

import '../../domain/entities/register_entity.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

// ignore: must_be_immutable
class RegisterModel extends RegisterEntity {
  RegisterModel({
    required super.user,
    required super.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
      );
}

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.accountType,
      required super.accountMode,
      required super.lang,
      required super.profilePhotoPath,
      required super.mobileNumber,
      required super.mobileNumberVerifiedAt,
      required super.accountStatus,
      required super.provider,
      required super.country,
      required super.mobileCountry,
      super.locationUser,
      super.createdAt,
      super.goTo,
      super.packageId});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      accountType: json["account_type"],
      accountMode: json["account_mode"],
      lang: json["lang"],
      profilePhotoPath: json["profile_photo_path"],
      mobileNumber: json["mobile_number"],
      mobileNumberVerifiedAt: json["mobile_number_verified_at"],
      accountStatus: json["account_status"],
      provider: json["provider"],
      country: json["country"] == null ? "" : json["country"]["name"],
      mobileCountry: json["mobile_country"],
      locationUser: json["location"] == null
          ? null
          : LocationUser.fromJson(json["location"])
      // createdAt: json["created_at"],
      // goTo: json["subscriptions"]["listing"] == null
      //     ? ""
      //     : json["subscriptions"]["listing"]["go_to"],
      // packageId: json["subscriptions"]["listing"] == null
      //     ? 0
      //     : json["subscriptions"]["listing"]["id"]
      );
}

class SubscriptionsAuthModel {
  SubscriptionsAuthModel({
    this.listing,
  });

  Feature? listing;

  factory SubscriptionsAuthModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsAuthModel(
        listing:
            json["listing"] == null ? null : Feature.fromJson(json["listing"]),
      );
}

class Feature {
  Feature({
    required this.id,
    required this.name,
    required this.purpose,
    required this.goTo,
  });

  int id;
  String name;
  String purpose;
  String goTo;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        purpose: json["purpose"] ?? "",
        goTo: json["go_to"] ?? "",
      );
}
