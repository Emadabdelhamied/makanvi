// ignore_for_file: unnecessary_cast

enum AppState {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  notCompleted,
  notVerified,
  notSeenTutorial,
  notselectLang,
  selectRole,
  addProperty,
  loggedOut,
  guest,
}

class AppData {
  final String? token;
  final String? providerType;
  final String? languageCode;
  final bool? isCompleted;
  final bool? isLogedOut;
  final bool? isVerfied;
  final String? id;
  final String? displayName;
  final String? photoUrl;
  final bool? isSeenTutorial;
  final bool? isGuestUser;
  final bool? isSelectLang;
  final String? email;
  final String? phone;
  final String? typeUser;
  final String? modeUserNow;
  final String? verficationCode;
  final String? fbToken;
  final String? title;
  final String? countryId;
  final String? notificationStatus;
  final String? location;
  final String? lat;
  final String? lang;
  AppData(
      {this.typeUser,
      this.modeUserNow,
      this.countryId,
      this.isSelectLang,
      this.isGuestUser,
      this.isSeenTutorial,
      this.token,
      this.id,
      this.isLogedOut,
      this.displayName,
      this.photoUrl,
      this.languageCode,
      this.isCompleted,
      this.email,
      this.phone,
      this.isVerfied,
      this.verficationCode,
      this.fbToken,
      this.title,
      this.notificationStatus,
      this.location,
      this.lat,
      this.lang,
      this.providerType});

  dynamic toJson() => {
        "token": token,
        "languageCode": languageCode,
        "isGuestUser": isGuestUser,
        "isCompleted": isCompleted,
        "id": id,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "isVerfied": isVerfied,
        "isSeenTutorial": isSeenTutorial,
        "isSelectLang": isSelectLang,
        "email": email,
        "phone": phone,
        "typeUser": typeUser,
        "verficationCode": verficationCode,
        "fbToken": fbToken,
        "title": title,
        "notificationStatus": notificationStatus,
        "modeUserNow": modeUserNow,
        "countryId": countryId,
        "providerType": providerType,
        "location": location,
        "lat": lat,
        "lang": lang,
        "loggedOut": isLogedOut,
      };
//update the crunnet user data
  AppData copyWith(
      {bool? isCompleteed,
      String? langCode,
      String? name,
      String? userId,
      String? photo,
      String? emailCopy,
      String? phoneCopy,
      String? tokenCopy,
      bool? isverfied,
      bool? seenTutorial,
      bool? isGuestUserCopy,
      bool? selectLang,
      String? typeUserCopy,
      String? verficationCodeCopy,
      String? fbTokenCopy,
      String? notificationStatus,
      String? title,
      String? countryIdCopy,
      String? modeUserNowCopy,
      String? providerTypeCopy,
      String? locationCopy,
      String? latCopy,
      bool? loggedOut,
      String? langCopy}) {
    return AppData(
        isCompleted: isCompleteed ?? isCompleted,
        languageCode: langCode ?? languageCode,
        displayName: name ?? displayName,
        isLogedOut: loggedOut ?? isLogedOut,
        token: tokenCopy ?? token,
        id: userId ?? id,
        photoUrl: photo ?? photoUrl,
        isVerfied: isverfied ?? isVerfied,
        isSeenTutorial: seenTutorial ?? isSeenTutorial,
        isSelectLang: selectLang ?? isSelectLang,
        isGuestUser: isGuestUserCopy ?? isGuestUser,
        email: emailCopy ?? email,
        phone: phoneCopy ?? phone,
        fbToken: fbTokenCopy ?? fbToken,
        typeUser: typeUserCopy ?? typeUser,
        title: title ?? title,
        notificationStatus: notificationStatus ?? notificationStatus,
        modeUserNow: modeUserNowCopy ?? modeUserNow,
        countryId: countryIdCopy ?? countryId,
        providerType: providerTypeCopy ?? providerType,
        location: locationCopy ?? location,
        lat: latCopy ?? lat,
        lang: langCopy ?? lang,
        verficationCode: verficationCodeCopy ?? verficationCode);
  }

  static AppData fromJson(Map<String, dynamic> json) {
    return AppData(
        languageCode: (json['languageCode'] ?? "" as String),
        isCompleted: (json['isCompleted'] ?? false as bool),
        token: (json['token'] ?? "" as String),
        id: (json['id'] ?? "" as String),
        title: json['title'] ?? '' as String,
        displayName: (json['displayName'] ?? "" as String),
        photoUrl: (json['photoUrl'] ?? "" as String),
        email: (json['email'] ?? "" as String),
        phone: (json['phone'] ?? "" as String),
        isVerfied: (json['isVerfied'] ?? false as bool),
        isSeenTutorial: (json['isSeenTutorial'] ?? false as bool),
        isSelectLang: (json['isSelectLang'] ?? false as bool),
        isGuestUser: (json['isGuestUser'] ?? false as bool),
        fbToken: (json['fbToken'] ?? "" as String),
        typeUser: (json['typeUser'] ?? "" as String),
        verficationCode: (json['verficationCode'] ?? "" as String),
        modeUserNow: (json['modeUserNow'] ?? "" as String),
        countryId: (json['countryId'] ?? "" as String),
        providerType: (json['providerType'] ?? "" as String),
        location: (json['location'] ?? "" as String),
        lat: (json['lat'] ?? "" as String),
        lang: (json['lang'] ?? "" as String),
        notificationStatus: json['notificationStatus'],
        isLogedOut: json["loggedOut"] ?? false);
  }
}
