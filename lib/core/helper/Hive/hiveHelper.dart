import 'package:hive_flutter/hive_flutter.dart';

import 'adapters/category_hive_model.dart';

class HiveHelper {

  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CategoriesAdapter());


  }

   Future<Box<T>> openBox<T>(String boxName) async {
    print('Opening box $boxName');

    if (Hive.isBoxOpen(boxName)) {
      print('Box $boxName is already opened');
      return Hive.box<T>(boxName); // Return already opened box
    } else {
      print('Box $boxName is not opened');
      return await Hive.openBox<T>(boxName); // Open if not opened
    }
  }

   Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

   Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

   Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

   Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

   Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.close();
    }
  }
}
