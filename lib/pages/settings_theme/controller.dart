part of 'index.dart';

class SettingsThemeController extends GetxController {
  bool get isSystem => AppTheme.mode == ThemeMode.system;

  bool get isLight => AppTheme.mode == ThemeMode.light;

  bool get isDark => AppTheme.mode == ThemeMode.dark;

  void setThemeMode(ThemeMode value) {
    update();
    ConfigStore.to.setTheme(value);
  }
}
