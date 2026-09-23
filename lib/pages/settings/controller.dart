part of 'index.dart';

class SettingsController extends GetxController {
  String get themeModeName {
    switch (AppTheme.mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  String get roleName => ConfigStore.to.isBossMode ? 'Boss' : 'Geek';
}
