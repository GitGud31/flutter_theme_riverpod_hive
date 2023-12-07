import 'package:dummy_app/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemedText extends ConsumerWidget {
  const ThemedText({super.key, required this.mode});

  final String mode;

  TextStyle _getTextStyle(String mode) {
    final textColor = (mode == darkMode) ? white : black;

    return TextStyle(fontSize: 20, color: textColor);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichText(
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
    );
  }
}
