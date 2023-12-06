import 'package:dummy_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeController).theme;

    return MaterialApp(
      theme: (mode == 'dark') ? ThemeData.dark() : ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
