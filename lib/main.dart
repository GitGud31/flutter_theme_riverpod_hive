import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final _databaseService = DatabaseService();
  await _databaseService.initTheme();

  runApp(
    ProviderScope(
      //observers: [ProvidersLogger()],
      overrides: [
        databaseService.overrideWithValue(_databaseService),
      ],
      child: App(),
    ),
  );
}
