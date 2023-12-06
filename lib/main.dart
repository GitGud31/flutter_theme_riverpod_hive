import 'package:dummy_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

//** Use L.log(...) for better logging */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final themeService = ThemeService();
  await themeService.initTheme();

  runApp(
    ProviderScope(

      //** uncomment this, to log your providers changes */
      //observers: [ProvidersLogger()],
      overrides: [
        themeServiceProvider.overrideWith((_) => themeService),
      ],
      child: const App(),
    ),
  );
}
