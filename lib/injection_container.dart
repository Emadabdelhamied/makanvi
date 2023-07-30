import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/app/app_inj.dart';
import 'core/app/app_preferences_storage.dart';
import 'core/app/app_repository.dart';
import 'core/util/api_basehelper.dart';
import 'core/util/app_location.dart';
import 'core/util/navigator.dart';
import 'features/auth/auth_inj.dart';
import 'features/chat/chat_inj.dart';
import 'features/favourite/favourite_inj.dart';
import 'features/home_buyer/home_buyer_inj.dart';
import 'features/seller_pages/home_seller/home_seller_inj.dart';
import 'features/seller_pages/listining_seller/listings_inj.dart';
import 'features/seller_pages/notifications_seller/notification_inj.dart';
import 'features/seller_pages/payment/payment_inj.dart';
import 'features/settings/settings_inj.dart';
import 'features/static/static_inj.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
final ApiBaseHelper helper = ApiBaseHelper();
Future<void> init() async {
  initAppMainjection(sl);
  initAuthinjection(sl);
  initHomeBuyerinjection(sl);
  initHomeSellerinjection(sl);
  initSettingInjection(sl);
  initStaticInjection(sl);
  initChatInjection(sl);
  initListingsinjection(sl);
  initPaymentinjection(sl);
  initNotificationinjection(sl);
  initFavouriteInjection(sl);
  // core

  sl.registerLazySingleton<AppNavigator>(() => AppNavigator());
  sl.registerLazySingleton<AppLocation>(() => AppLocationImpl());
  //FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
  final sharedPreferences = await SharedPreferences.getInstance();
  final references = await Preferences.getInstance();

  final loc = Localizations;
  sl.registerLazySingleton(() => references);

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => loc);
  sl.registerLazySingleton(() => AppRepository(references));
  helper.dioInit();
  sl.registerLazySingleton(() => helper);
}
