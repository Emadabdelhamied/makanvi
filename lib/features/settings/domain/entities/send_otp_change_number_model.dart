// To parse this JSON data, do
//
//     final sendOtpResponseChaneNumber = sendOtpResponseChaneNumberFromJson(jsonString);

import 'dart:convert';

SendOtpResponseChaneNumber sendOtpResponseChaneNumberFromJson(String str) =>
    SendOtpResponseChaneNumber.fromJson(json.decode(str));

String sendOtpResponseChaneNumberToJson(SendOtpResponseChaneNumber data) =>
    json.encode(data.toJson());

class SendOtpResponseChaneNumber {
  SendOtpResponseChaneNumber({
    required this.message,
    required this.mobileCountryId,
    required this.mobileNumber,
  });

  String message;
  String mobileCountryId;
  String mobileNumber;

  factory SendOtpResponseChaneNumber.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseChaneNumber(
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
