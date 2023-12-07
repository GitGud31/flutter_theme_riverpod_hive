import 'package:dummy_app/consts.dart';
import 'package:dummy_app/widgets/themed_icon.dart';
import 'package:dummy_app/widgets/themed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/theme_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Riverpod - Hive'), actions: [
          Switch(
            activeColor: Theme.of(context).primaryColorLight,
            value:
                (ref.watch(themeController.notifier).currentMode == darkMode),
            onChanged: (value) =>
                ref.read(themeController.notifier).toggle(value),
          ),
        ]),
        body: ref.watch(themeController).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text("$e"),
              ),
              data: (mode) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height / 3.5),
                      ThemedIcon(mode: mode),
                      ThemedText(mode: mode),
                    ],
                  ),
                );
              },
            ));
  }
}
