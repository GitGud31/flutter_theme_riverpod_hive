import 'package:dummy_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeController = ChangeNotifierProvider<ThemeController>((ref) {
  final themeService = ref.watch(themeServiceProvider);

  return ThemeController(themeService);
});

class ThemeController with ChangeNotifier {
  ThemeController(this._themeService);

  late final ThemeService _themeService;

  String get theme => _themeService.savedTheme;

  void toggle(bool mode) {
    (mode)
        ? _themeService.toggleSaveTheme("dark")
        : _themeService.toggleSaveTheme("light");

    notifyListeners();
  }
}
