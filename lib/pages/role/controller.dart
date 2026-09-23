part of 'index.dart';

class RoleController extends GetxController {
  final List<String> roleTypeList = [C.roleGeek, C.roleBoss];

  String? roleType;

  void onChanged(String? value) => roleType = value;

  void onSubmit(BuildContext context) async {
    if (roleType == null) {
      CustomToast.text('Please select a role');
      return;
    }
    if (roleType == C.roleBoss && UserStore.to.info.boss == null) {
      context.pushNamed(
        Routes.profileEdit,
        queryParameters: {'roleType': C.roleBoss},
      );
    } else if (roleType == C.roleGeek && UserStore.to.info.geek == null) {
      context.pushNamed(Routes.profileCategory);
    } else {
      ConfigStore.to.setRole(roleType!);
      CustomToast.loading();
      await Future.delayed(const Duration(seconds: 1));
      CustomToast.dismiss();
      if (context.mounted) context.goNamed(Routes.splash);
    }
  }
}
