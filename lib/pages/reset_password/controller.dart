part of 'index.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final TextEditingController password2Input = TextEditingController();
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final ValueNotifier<bool> isVerifying = ValueNotifier(false);

  final String _code = '8888';

  String get sendTo => emailInput.value.text;

  @override
  void onInit() {
    super.onInit();
    if (UserStore.to.isLogin) emailInput.text = UserStore.to.account;
  }

  @override
  void onClose() {
    emailInput.dispose();
    passwordInput.dispose();
    password2Input.dispose();
    super.onClose();
  }

  void onShowPassword() => showPassword.value = !showPassword.value;

  Future<bool> onSendEmail(GlobalKey<FormState> key) async {
    if (key.currentState?.validate() != true) return false;
    CustomToast.loading();
    await Future.delayed(const Duration(seconds: 2));
    CustomToast.dismiss();
    return true;
  }

  String? onCodeVerify(String? value) => value != _code ? _code : null;

  Future<void> onResendEmail() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<bool> onSubmit(BuildContext context, GlobalKey<FormState> key) async {
    if (key.currentState?.validate() != true) return false;
    CustomToast.loading();
    await Future.delayed(const Duration(seconds: 2));
    CustomToast.dismiss();
    return true;
  }
}
