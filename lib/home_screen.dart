import 'package:dummy_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeController).theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod - Hive'),
        actions: [
          Switch(
            value: (mode == 'dark') ? true : false,
            onChanged: (value) =>
                ref.read(themeController.notifier).toggle(value),
          ),
        ],
      ),
      body: Center(
          child: RichText(
        text: TextSpan(
          text: 'Current theme mode ',
          style: const TextStyle(fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: mode,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      )),
    );
  }
}
