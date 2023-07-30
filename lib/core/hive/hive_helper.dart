//enum box names
import 'package:hive_flutter/hive_flutter.dart';

enum BoxNames {
  addProperty,
  updateLocation;

  //names

  String get name {
    switch (this) {
      case BoxNames.addProperty:
        return 'add_property';
      case BoxNames.updateLocation:
        return 'update_location';
    }
  }
}

class HiveHelper {
  static late Box memoryBox;
  static Future<void> init() async {
    await Hive.initFlutter();
    memoryBox = await Hive.openBox("memory");
  }

  //put on any box
  static Future<void> putOnBox({
    required BoxNames boxName,
    required String key,
    required dynamic value,
  }) async {
    final box = await Hive.openBox(boxName.name);
    await box.put(key, value);
    await box.close();
  }

  //get from any box

  static dynamic getFromBox({
    required BoxNames boxName,
    required String key,
  }) async {
    final box = await Hive.openBox(boxName.name);
    final value = box.get(key);
    await box.close();
    return value;
  }

  //delete from any box

  static Future<void> deleteFromBox({
    required BoxNames boxName,
    required String key,
  }) async {
    final box = await Hive.openBox(boxName.name);
    await box.delete(key);
    await box.close();
  }

  // open and get the box
  static Future<Box> getBox({
    required BoxNames boxName,
  }) async {
    final box = await Hive.openBox(boxName.name);
    return box;
  }
}
