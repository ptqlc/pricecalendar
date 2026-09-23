part of 'index.dart';

class SettingsThemePage extends StatelessWidget {
  const SettingsThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsThemeController>(
      init: SettingsThemeController(),
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          title: const Text('Appearance'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
            child: CustomCellGroup(
              children: [
                CustomCell(
                  title: const Text('System'),
                  value: CustomSwitch(
                    value: controller.isSystem,
                    onChanged: (_) => controller.setThemeMode(ThemeMode.system),
                  ),
                ),
                CustomCell(
                  title: const Text('Light'),
                  value: CustomSwitch(
                    value: controller.isLight,
                    onChanged: (_) => controller.setThemeMode(ThemeMode.light),
                  ),
                ),
                CustomCell(
                  title: const Text('Dark'),
                  value: CustomSwitch(
                    value: controller.isDark,
                    onChanged: (_) => controller.setThemeMode(ThemeMode.dark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
