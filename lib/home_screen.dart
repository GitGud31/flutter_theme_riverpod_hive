import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/theme_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  TextStyle _getTextStyle(String mode) {
    final textColor = (mode == 'dark') ? Colors.white : Colors.black;

    return TextStyle(fontSize: 20, color: textColor);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeController.notifier);
    final mode = ref.watch(themeController).theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod - Hive'),
        actions: [
          Switch(
            value: mode == 'dark',
            onChanged: (value) => themeNotifier.toggle(value),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ThemedIcon(),
            RichText(
              text: TextSpan(
                text: 'Current theme mode ',
                style: _getTextStyle(mode),
                children: <TextSpan>[
                  TextSpan(
                    text: mode,
                    style: _getTextStyle(mode).copyWith(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemedIcon extends ConsumerWidget {
  const ThemedIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeController).theme;

    final iconColor = (mode == 'dark') ? Colors.grey : Colors.orange;
    final iconData = (mode == 'dark') ? Icons.dark_mode : Icons.light_mode;

    return Icon(iconData, color: iconColor, size: 50);
  }
}
