// To parse this JSON data, do
//
//     final paymentInfoModel = paymentInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:makanvi_web/features/seller_pages/payment/data/models/get_package_model.dart';

import '../../../listining_seller/data/models/my_listings_all_model.dart';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

class PaymentInfoModel {
  PaymentInfoModel({
    required this.cards,
    required this.subscriptions,
  });

  List<CardPayment> cards;
  Subscriptions subscriptions;

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        cards: List<CardPayment>.from(
            json["cards"].map((x) => CardPayment.fromJson(x))),
        subscriptions: Subscriptions.fromJson(json["subscriptions"]),
      );
}

// class Card {
//   Card({
//     required this.id,
//     required this.cardHolderName,
//     required this.last4,
//     required this.expiryMonth,
//     required this.expiryYear,
//     this.country,
//     required this.brand,
//     required this.createdAt,
//   });

//   int id;
//   String cardHolderName;
//   String last4;
//   String expiryMonth;
//   String expiryYear;
//   dynamic country;
//   String brand;
//   DateTime createdAt;

//   factory Card.fromJson(Map<String, dynamic> json) => Card(
//         id: json["id"],
//         cardHolderName: json["card_holder_name"],
//         last4: json["last_4"],
//         expiryMonth: json["expiry_month"],
//         expiryYear: json["expiry_year"],
//         country: json["country"],
//         brand: json["brand"],
//         createdAt: DateTime.parse(json["created_at"]),
//       );
// }

class Listing {
  Listing({
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
    required this.expireAfter,
    required this.cancelled,
    required this.goTo,
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
  int expireAfter;
  int cancelled;
  String goTo;

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
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
        expireAfter: json["expire_after"],
        cancelled: json["cancelled"],
        goTo: json["go_to"],
      );
}
