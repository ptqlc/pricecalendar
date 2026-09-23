part of 'index.dart';

class SignController extends GetxController {
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final TextEditingController password2Input = TextEditingController();
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    emailInput.text = StorageService.to.getString(C.localAccount);
  }

  @override
  void onClose() {
    emailInput.dispose();
    passwordInput.dispose();
    password2Input.dispose();
    super.onClose();
  }

  void onShowPassword() => showPassword.value = !showPassword.value;

  Future<bool> onLogin(GlobalKey<FormState> key) async {
    if (key.currentState?.validate() != true) return false;
    CustomToast.loading();
    await UserStore.to.setAccount(emailInput.value.text);
    await Future.delayed(const Duration(seconds: 1));
    CustomToast.dismiss();
    return true;
  }
}
