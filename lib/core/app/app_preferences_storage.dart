import 'dart:convert';

import 'package:hive/hive.dart';

import 'app_data.dart';

class Preferences {
  final JsonCodec codec;

  final Box<dynamic> box;

  // ignore: unused_element
  Preferences(this.box, [this.codec = json]);

  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<dynamic>("data");
    return Preferences(box);
  }

  AppData? loadAppData() {
    // var box = Hive.box('data');

    var data = box.get("data");
    return data == null ? null : AppData.fromJson(codec.decode(data));
  }

  Future<void> setAppDataHive(AppData appData) {
    // var box = Hive.box('data');

    // ignore: unnecessary_null_comparison
    if (appData == null) {
      return box.delete("data");
    }
    String data = codec.encode(appData.toJson());
    return box.put("data", data);
  }
}
