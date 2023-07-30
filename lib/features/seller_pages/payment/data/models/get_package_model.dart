// To parse this JSON data, do
//
//     final getPackageAndCardModel = getPackageAndCardModelFromJson(jsonString);

import 'dart:convert';

GetPackageAndCardModel getPackageAndCardModelFromJson(String str) =>
    GetPackageAndCardModel.fromJson(json.decode(str));

String getPackageAndCardModelToJson(GetPackageAndCardModel data) =>
    json.encode(data.toJson());

class GetPackageAndCardModel {
  GetPackageAndCardModel({
    required this.packages,
    required this.cards,
  });

  List<UserPackage> packages;
  List<CardPayment> cards;

  factory GetPackageAndCardModel.fromJson(Map<String, dynamic> json) =>
      GetPackageAndCardModel(
        packages: List<UserPackage>.from(
            json["packages"].map((x) => UserPackage.fromJson(x))),
        cards: List<CardPayment>.from(
            json["cards"].map((x) => CardPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
      };
}

class CardPayment {
  CardPayment({
    required this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    this.country,
    required this.brand,
    required this.createdAt,
  });

  int id;
  String cardHolderName;
  String last4;
  String expiryMonth;
  String expiryYear;
  dynamic country;
  String brand;
  DateTime createdAt;

  factory CardPayment.fromJson(Map<String, dynamic> json) => CardPayment(
        id: json["id"],
        cardHolderName: json["card_holder_name"],
        last4: json["last_4"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        country: json["country"],
        brand: json["brand"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_holder_name": cardHolderName,
        "last_4": last4,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "country": country,
        "brand": brand,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class UserPackage {
  UserPackage({
    required this.id,
    required this.name,
    required this.target,
    required this.purpose,
    required this.price,
    required this.currency,
    required this.listingCount,
    required this.listingExpireDays,
    required this.packageExpireDays,
  });

  int id;
  String name;
  String target;
  String purpose;
  int price;
  String currency;
  int listingCount;
  int listingExpireDays;
  int packageExpireDays;

  factory UserPackage.fromJson(Map<String, dynamic> json) => UserPackage(
        id: json["id"],
        name: json["name"],
        target: json["target"],
        purpose: json["purpose"],
        price: json["price"],
        currency: json["currency"],
        listingCount: json["listing_count"],
        listingExpireDays: json["listing_expire_days"],
        packageExpireDays: json["package_expire_days"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "target": target,
        "purpose": purpose,
        "price": price,
        "currency": currency,
        "listing_count": listingCount,
        "listing_expire_days": listingExpireDays,
        "package_expire_days": packageExpireDays,
      };
}
