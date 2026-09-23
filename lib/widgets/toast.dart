part of 'index.dart';

abstract class CustomToast {
  static TransitionBuilder init({
    required BuildContext context,
    required TransitionBuilder builder,
  }) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..radius = 20.w
      ..boxShadow = [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
          offset: const Offset(0, 0),
          blurRadius: 20.w,
        ),
      ]
      ..progressColor = Colors.transparent
      ..contentPadding = EdgeInsets.all(20.w)
      ..backgroundColor =
      Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.tertiary
      ..indicatorColor = Colors.transparent
      ..textColor = Theme.of(context).colorScheme.onSurface
      ..textStyle = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17.w,
        color: Theme.of(context).colorScheme.onSurface,
      )
      ..maskType = EasyLoadingMaskType.clear
      ..maskColor = const Color(0xFF09101D).withOpacity(0.7)
      ..userInteractions = true
      ..successWidget = const CustomToastSuccess()
      ..errorWidget = const CustomToastFail()
      ..indicatorWidget = CustomLoadingIndicator(size: 60.w)
      ..dismissOnTap = false;
    return EasyLoading.init(builder: builder);
  }

  static void text(String text) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showToast(text);
  }

  static void success(String text) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showSuccess(text);
  }

  static void fail(String text) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showError(text);
  }

  static void loading() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;
    EasyLoading.show();
  }

  static void dismiss() => EasyLoading.dismiss();
}

class CustomToastFail extends StatelessWidget {
  const CustomToastFail({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.close_rounded,
      color: const Color(0xFFFF1843),
      size: 60.w,
    );
  }
}

class CustomToastSuccess extends StatelessWidget {
  const CustomToastSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_rounded,
      color: Theme.of(context).colorScheme.primary,
      size: 60.w,
    );
  }
}
