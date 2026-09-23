part of 'index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          title: Text(S.of(context).settings_title),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
            child: CustomCellGroup(
              children: [
                CustomCell(
                  title: Text(S.of(context).settings_theme),
                  icon: const Icon(Ionicons.color_fill_outline),
                  value: Text(controller.themeModeName),
                  onTap: () async {
                    await context.pushNamed(Routes.settingsTheme);
                    controller.update();
                  },
                ),
                CustomCell(
                  title: Text(S.of(context).settings_reset_pwd),
                  icon: const Icon(Ionicons.lock_closed_outline),
                  onTap: () => context.pushNamed(Routes.resetPassword),
                ),
                CustomCell(
                  title: Text(S.of(context).settings_role),
                  icon: const Icon(Ionicons.people_outline),
                  value: Text(controller.roleName),
                  onTap: () => context.pushNamed(Routes.role),
                ),
                CustomCell(
                  title: Text(S.of(context).settings_lang),
                  icon: const Icon(Ionicons.language_outline),
                  value: Text(ConfigStore.to.locale.languageCode),
                  onTap: () async {
                    final result = await CustomBottomSheet.showPicker<Locale>(
                      context: context,
                      title: Text(S.of(context).settings_lang),
                      items: S.delegate.supportedLocales,
                      builder: (value) => Text(value.toString()),
                    );
                    if (result == null) return;
                    await Future.delayed(const Duration(milliseconds: 500));
                    ConfigStore.to.setLanguage(result);
                  },
                ),
                CustomCell(
                  title: const Text('FAQ'),
                  icon: const Icon(Ionicons.help_circle_outline),
                  onTap: () => context.pushNamed(Routes.helpFAQ),
                ),
                CustomCell(
                  title: Text(S.of(context).settings_logout),
                  icon: const Icon(
                    Ionicons.exit_outline,
                    color: AppTheme.error,
                  ),
                  showArrow: false,
                  onTap: () async {
                    final result = await CustomDialog.show<bool>(
                      context: context,
                      confirm: const Text('Yes, Logout'),
                      cancel: const Text('Cancel'),
                      builder: (BuildContext context) {
                        return const Text('Are you sure want to logout?');
                      },
                      onCancel: Navigator.of(context).pop,
                      onConfirm: () => Navigator.of(context).pop(true),
                    );
                    if (result != true) return;
                    CustomToast.loading();
                    await UserStore.to.logout();
                    CustomToast.dismiss();
                    if (context.mounted) context.goNamed(Routes.splash);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
