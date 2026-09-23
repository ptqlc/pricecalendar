part of 'index.dart';

class ProfileEditController extends GetxController {
  final String roleType;
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController countryInput = TextEditingController();
  final TextEditingController addressInput = TextEditingController();
  final TextEditingController jobInput = TextEditingController();

  String? image;
  String? country;

  ProfileEditController({required this.roleType});

  @override
  void onClose() {
    nameInput.dispose();
    emailInput.dispose();
    dateInput.dispose();
    countryInput.dispose();
    addressInput.dispose();
    jobInput.dispose();
    super.onClose();
  }

  void changeDate(DateTime? value) => dateInput.text = Date.fromTime(value);

  void changeCountry(String? value) {
    if (value == null) return;
    country = value;
    countryInput.text = value;
  }

  void onSubmit(BuildContext context, GlobalKey<FormState> key) async {
    if (key.currentState?.validate() != true) return;
    CustomToast.loading();
    ConfigStore.to.setRole(roleType);
    if (roleType == C.roleBoss) {
      UserStore.to.setProfile(ProfileModel(
        boss: BossModel(
          logo: image,
          name: nameInput.value.text,
          email: emailInput.value.text,
          established: Date.fromStrToMilli(dateInput.value.text),
          country: countryInput.value.text,
          address: addressInput.value.text,
        ),
      ));
    } else {
      UserStore.to.setProfile(ProfileModel(
        geek: GeekModel(
          avatar: image,
          name: nameInput.value.text,
          email: emailInput.value.text,
          birthday: Date.fromStrToMilli(dateInput.value.text),
          occupation: jobInput.value.text,
          address: addressInput.value.text,
        ),
      ));
    }
    await Future.delayed(const Duration(seconds: 1));
    CustomToast.dismiss();
    if (context.mounted) context.goNamed(Routes.splash);
  }
}
