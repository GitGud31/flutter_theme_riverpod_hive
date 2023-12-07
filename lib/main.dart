import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:dummy_app/app.dart';

import 'package:dummy_app/consts.dart';
import 'package:dummy_app/log.dart';

//** Use L.log(...) for better logging */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //** uncomment this if you want to simulate FIRST TIME, on every hotRestart */
  if (kDebugMode) {
    await Hive.deleteBoxFromDisk(themeBoxKey);
  }

  runApp(
    ProviderScope(
      observers: [ProvidersLogger()],
      child: const App(),
    ),
  );
}
