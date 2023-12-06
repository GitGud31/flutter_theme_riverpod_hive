//** DATABASE CLASS */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeServiceProvider = Provider<ThemeService>((_) => ThemeService());

class ThemeService {
  late final Box<String> themeBox;

  String get savedTheme => themeBox.values.first;

  Future<void> initTheme() async {
    await Hive.openBox<String>('theme').then((value) => themeBox = value);

    //first time loading
    if (themeBox.values.isEmpty) themeBox.add('light');
  }

  Future<void> toggleSaveTheme(String mode) async =>
      await themeBox.put(0, mode);
}
