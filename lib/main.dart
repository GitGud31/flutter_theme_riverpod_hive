import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

//TODO: Use L.log(...) to log stuff.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final dbService = DatabaseService();
  await dbService.initTheme();

  runApp(
    ProviderScope(
      //observers: [ProvidersLogger()],
      overrides: [
        databaseService.overrideWith((_) => dbService),
      ],
      child: const App(),
    ),
  );
}
