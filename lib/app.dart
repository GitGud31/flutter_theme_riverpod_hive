import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_screen.dart';
import 'log.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: (ref.watch(themeController).theme == 'light')
          ? AppTheme.light
          : AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}

//** THEME CLASS */
class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData.light();
  static ThemeData dark = ThemeData.dark();
}

//** THEME CONTROLLER */
final themeController = ChangeNotifierProvider<ThemeController>((ref) {
  final _database = ref.watch(databaseService);

  return ThemeController(_database);
});

class ThemeController with ChangeNotifier {
  ThemeController(this._database);

  late final DatabaseService _database;

  String get theme => _database.savedTheme;

  void toggle(bool mode) {
    (mode)
        ? _database.toggleSaveTheme("dark")
        : _database.toggleSaveTheme("light");

    notifyListeners();
  }
}

//** DATABASE CLASS */
final databaseService = Provider<DatabaseService>((_) => DatabaseService());

class DatabaseService {
  late final Box<String> themeBox;

  String get savedTheme => themeBox.values.first;

  Future<void> initTheme() async {
    await Hive.openBox<String>('theme').then((value) => themeBox = value);

    //first time loading
    if (themeBox.values.isEmpty) {
      themeBox.add('light');
    }
  }

  Future<void> toggleSaveTheme(String mode) async {
    L.log("Got: $mode");
    await themeBox.put(0, mode);
    L.log("Saved: ${themeBox.values}");
  }
}
