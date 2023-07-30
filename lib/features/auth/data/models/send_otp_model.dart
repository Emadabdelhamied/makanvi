// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) =>
    SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  SendOtpModel({
    required this.message,
    required this.mobileCountryId,
    required this.mobileNumber,
  });

  String message;
  String mobileCountryId;
  String mobileNumber;

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
        message: json["message"],
        mobileCountryId: json["mobile_country_id"],
        mobileNumber: json["mobile_number"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "mobile_country_id": mobileCountryId,
        "mobile_number": mobileNumber,
      };
}
