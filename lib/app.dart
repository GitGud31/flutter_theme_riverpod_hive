import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_screen.dart';

//TODO: use L.log(msg); to print stuff

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    ref.read(themeController).loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: (ref.watch(themeController).theme == 'light')
            ? AppTheme.light
            : AppTheme.dark,
        home: const HomeScreen(),
      ),
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
  final _service = ref.watch(themeService);

  return ThemeController(_service);
});

class ThemeController with ChangeNotifier {
  ThemeController(this._service);

  late final ThemeService _service;

  String get theme => _service.theme;

  Future<void> loadTheme() async {
    await _service.openDatabase();
    _service.fetchTheme();

    notifyListeners();
  }

  void toggle(bool mode) {
    (mode == true) ? _service.toggle("light") : _service.toggle("dark");

    notifyListeners();
  }
}

//** THEME SERVICE */
final themeService = Provider<ThemeService>((ref) {
  final _database = ref.watch(databaseService);

  return ThemeService(_database);
});

class ThemeService {
  ThemeService(this._database);

  final DatabaseService _database;

  late String _theme;

  String get theme => _theme;

  Future<void> openDatabase() async => await _database.initTheme();

  void fetchTheme() => _theme = _database.savedTheme;

  Future<void> toggle(String theme) async {
    (theme == 'light') ? _theme = "dark" : _theme = "light";

    _database.toggleSaveTheme(_theme);
  }
}

//** DATABASE CLASS */
final databaseService =
    StateProvider<DatabaseService>((_) => DatabaseService());

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

  Future<void> toggleSaveTheme(String mode) async =>
      await themeBox.put(0, mode);
}
