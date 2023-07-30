import 'package:shared_preferences/shared_preferences.dart';

import 'app_data.dart';
import 'app_preferences_storage.dart';

class AppRepository {
  // final KeyValueStorage store;
  final Preferences store;
  AppRepository(this.store);

  AppData? loadAppData() {
    return store.loadAppData();
  }

  // AppData? loadAppDataHive() {
  //   return store.getAppData();
  // }

//saco
  Future setUserLang(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("lang", language);
  }

  Future<String> getUserLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("lang") ?? 'ar';
  }
}
