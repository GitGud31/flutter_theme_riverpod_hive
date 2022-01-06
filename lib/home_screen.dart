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
        title: const Text('Dummy app'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text('Screen'),
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: (mode == 'dark') ? true : false,
            onChanged: (value) => ref.watch(themeController).toggle(value),
          ),
        ],
      ),
    );
  }
}
