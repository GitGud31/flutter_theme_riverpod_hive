import 'package:dummy_app/consts.dart';
import 'package:dummy_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(themeController).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text("$e"),
            ),
        data: (theme) {
          return MaterialApp(
            theme: (theme == lightMode) ? ThemeData.light() : ThemeData.dark(),
            home: const HomeScreen(),
          );
        });
  }
}
