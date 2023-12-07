import 'package:dummy_app/consts.dart';
import 'package:dummy_app/services/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeController =
    AsyncNotifierProvider<ThemeController, String>(() => ThemeController());

class ThemeController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return await ref.read(themeServiceProvider).initTheme();
  }

  String get currentMode => state.value ?? lightMode;

  void toggle(bool isDarkMode) async {
    state = const AsyncValue.loading();

    final mode = isDarkMode ? darkMode : lightMode;
    state = await AsyncValue.guard(
      () async {
        ref.read(themeServiceProvider).toggleTheme(mode);

        return mode;
      },
    );
  }
}
