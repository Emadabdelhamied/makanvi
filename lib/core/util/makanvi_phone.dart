import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MakanviPhoneNumber extends PhoneNumber {
  toMap() {
    String phoneNumberTemp = phoneNumber ?? "";
    phoneNumberTemp = phoneNumberTemp.contains("+")
        ? phoneNumberTemp.substring(dialCode!.length)
        : phoneNumberTemp;
    phoneNumberTemp = phoneNumberTemp.startsWith("0")
        ? phoneNumberTemp.substring(1)
        : phoneNumberTemp;
    return {
      "phone_iso": isoCode,
      "phone_dial": dialCode,
      "phone_number": phoneNumberTemp
    };
  }

  MakanviPhoneNumber({
    required super.isoCode,
    required super.dialCode,
    required super.phoneNumber,
  });
  factory MakanviPhoneNumber.fromPN(PhoneNumber ph) {
    return MakanviPhoneNumber(
        isoCode: ph.isoCode,
        dialCode: ph.dialCode,
        phoneNumber: ph.phoneNumber);
  }
  factory MakanviPhoneNumber.fromMap(Map<String, dynamic> map) {
    return MakanviPhoneNumber(
      isoCode: map["phone_iso"],
      dialCode: map["phone_dial"],
      phoneNumber: map["phone_number"],
    );
  }
}
