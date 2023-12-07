import 'package:dummy_app/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemedIcon extends ConsumerWidget {
  const ThemedIcon({Key? key, required this.mode}) : super(key: key);

  final String mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = (mode == darkMode) ? white : yellow;
    final iconData = (mode == darkMode) ? Icons.dark_mode : Icons.light_mode;

    return Icon(iconData, color: iconColor, size: 50);
  }
}
