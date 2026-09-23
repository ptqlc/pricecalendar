part of 'index.dart';

abstract class Routes {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static const splash = 'splash';
  static const main = 'main';
  static const sign = 'sign';
  static const resetPassword = 'reset_password';
  static const resetPasswordVerify = 'reset_password_verify';
  static const resetPasswordEdit = 'reset_password_edit';
  static const resetPasswordSuccess = 'reset_password_success';
  static const notice = 'notice';
  static const job = 'job';
  static const jobSearch = 'job_search';
  static const jobDetail = 'job_detail';
  static const jobCollect = 'job_collect';
  static const applyDetail = 'apply_detail';
  static const vacancyDetail = 'vacancy_detail';
  static const vacancyEdit = 'vacancy_edit';
  static const vacancyGeek = 'vacancy_geek';
  static const vacancyResume = 'vacancy_resume';
  static const settings = 'settings';
  // static const settingsNotice = 'settings_notice';
  static const settingsTheme = 'settings_theme';
  static const conversation = 'conversation';
  static const role = 'role';
  static const profileEdit = 'profile_edit';
  static const profileCategory = 'profile_category';
  // static const help = 'help';
  static const helpFAQ = 'help_faq';
  static const call = 'call';

  static final GoRouter config = GoRouter(
    // debugLogDiagnostics: !kReleaseMode,
    initialLocation: '/$splash',
    observers: [observer],
    routes: [
      GoRoute(
        path: '/$splash',
        name: splash,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: '/$sign',
        name: sign,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const SignPage(),
        ),
      ),
      GoRoute(
        path: '/',
        name: main,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const MainPage(),
        ),
      ),
      /*GoRoute(
        path: '/$help',
        name: help,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const HelpPage(),
        ),
      ),*/
      GoRoute(
        path: '/$helpFAQ',
        name: helpFAQ,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const HelpFAQPage(),
        ),
      ),
      GoRoute(
        path: '/$resetPassword',
        name: resetPassword,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ResetPasswordPage(),
        ),
      ),
      GoRoute(
        path: '/$resetPasswordVerify',
        name: resetPasswordVerify,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ResetPasswordVerifyPage(),
        ),
      ),
      GoRoute(
        path: '/$resetPasswordEdit',
        name: resetPasswordEdit,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ResetPasswordEditPage(),
        ),
      ),
      GoRoute(
        path: '/$resetPasswordSuccess',
        name: resetPasswordSuccess,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ResetPasswordSuccessPage(),
        ),
      ),
      GoRoute(
        path: '/$job',
        name: job,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const JobPage(),
        ),
      ),
      GoRoute(
        path: '/$jobDetail',
        name: jobDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const JobDetailPage(),
        ),
      ),
      GoRoute(
        path: '/$jobSearch',
        name: jobSearch,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const JobSearchPage(),
        ),
      ),
      GoRoute(
        path: '/$jobCollect',
        name: jobCollect,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const JobCollectPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$role',
        name: role,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const RolePage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$profileEdit',
        name: profileEdit,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: ProfileEditPage(
            roleType: state.uri.queryParameters['roleType'].toString(),
          ),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$profileCategory',
        name: profileCategory,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ProfileCategoryPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$notice',
        name: notice,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const NoticePage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$vacancyGeek',
        name: vacancyGeek,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const VacancyGeekPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$vacancyResume',
        name: vacancyResume,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const VacancyResumePage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$vacancyEdit',
        name: vacancyEdit,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const VacancyEditPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$vacancyDetail',
        name: vacancyDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const VacancyDetailPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$applyDetail',
        name: applyDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ApplyDetailPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$conversation',
        name: conversation,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const ConversationPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$call',
        name: call,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const CallPage(),
          fullscreenDialog: true,
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      GoRoute(
        path: '/$settings',
        name: settings,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const SettingsPage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
      /*GoRoute(
        path: '/$settingsNotice',
        name: settingsNotice,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const SettingsNoticePage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),*/
      GoRoute(
        path: '/$settingsTheme',
        name: settingsTheme,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const SettingsThemePage(),
        ),
        redirect: (context, state) => RouteRedirect.auth(),
      ),
    ],
  );
}

abstract class RouteRedirect {
  static String? auth() {
    if (UserStore.to.isLogin) return null;
    return '/${Routes.sign}';
  }
}
