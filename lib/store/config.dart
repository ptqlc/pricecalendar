part of 'index.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  Locale locale = PlatformDispatcher.instance.locale;
  List<CategoryModel> categories = [];
  List<String> countries = [];

  String _roleType = C.roleGeek;

  String get roleType => _roleType;

  bool get isBossMode => _roleType == C.roleBoss;

  @override
  void onInit() {
    super.onInit();
    _initLanguage();
    _initThemeMode();
    _initCountries();
    _initCategories();
  }

  void _initLanguage() {
    final result = StorageService.to.getString(C.localLanguage);
    if (result.isEmpty) return;
    locale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == result,
      orElse: () => PlatformDispatcher.instance.locale,
    );
  }

  void _initCountries() {
    countries = [
      'Algeria',
      'American Samoa',
      'Andorra',
      'Bahamas',
      'Bahrain',
      'Bangladesh',
      'Cambodia',
      'Cameroon',
      'Canada',
    ];
  }

  void _initCategories() {
    categories = [
      CategoryModel(name: 'Content Writer', value: 0, icon: Ionicons.pencil),
      CategoryModel(
          name: 'Art & Design', value: 1, icon: Ionicons.color_palette),
      CategoryModel(name: 'Human Resources', value: 2, icon: Ionicons.people),
      CategoryModel(name: 'Programmer', value: 3, icon: Ionicons.code_slash),
      CategoryModel(name: 'Finance', value: 4, icon: Ionicons.briefcase),
      CategoryModel(name: 'Customer Service', value: 5, icon: Ionicons.headset),
      CategoryModel(
          name: 'Food & Restaurant', value: 6, icon: Ionicons.restaurant),
      CategoryModel(
          name: 'Music Producer', value: 7, icon: Ionicons.musical_notes),
    ];
  }

  void _initThemeMode() {
    final theme = StorageService.to.getString(C.localThemeMode);
    switch (theme) {
      case C.themeLight:
        AppTheme.mode = ThemeMode.light;
        break;
      case C.themeDark:
        AppTheme.mode = ThemeMode.dark;
        break;
      default:
        AppTheme.mode = ThemeMode.system;
        break;
    }
    AppTheme.setSystemStyle();
  }

  void setRole(String value) => _roleType = value;

  void setTheme(ThemeMode value) {
    switch (value) {
      case ThemeMode.system:
        StorageService.to.setString(C.localThemeMode, C.themeSystem);
        break;
      case ThemeMode.light:
        StorageService.to.setString(C.localThemeMode, C.themeLight);
        break;
      case ThemeMode.dark:
        StorageService.to.setString(C.localThemeMode, C.themeDark);
        break;
    }
    AppTheme.mode = value;
    AppTheme.setSystemStyle();
    update();
  }

  void setLanguage(Locale value) async {
    locale = value;
    StorageService.to.setString(C.localLanguage, value.languageCode);
    await S.delegate.load(locale);
    update();
  }
}
