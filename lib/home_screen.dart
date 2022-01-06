import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeController).theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod - Hive'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Some text')),
          const SizedBox(height: 100),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: (mode == 'dark') ? true : false,
            onChanged: (value) =>
                ref.watch(themeController.notifier).toggle(value),
          ),
        ],
      ),
    );
  }
}
