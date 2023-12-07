//** DATABASE CLASS */
import 'package:dummy_app/consts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeServiceProvider = Provider<ThemeService>((_) => ThemeService());

class ThemeService {
  late final Box<String> themeBox;

  Future<String> initTheme() async {
    themeBox = await Hive.openBox<String>(themeBoxKey);

    // First time loading.
    // Set 'light' mode as the default.
    if (themeBox.values.isEmpty) themeBox.add(lightMode);

    return themeBox.values.first;
  }

  Future<void> toggleTheme(String mode) async => await themeBox.put(0, mode);
}
