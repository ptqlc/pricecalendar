part of 'index.dart';

class ProfileController extends GetxController {
  final TextEditingController textInput = TextEditingController();

  GeekModel? get geek => UserStore.to.info.geek;

  BossModel? get boss => UserStore.to.info.boss;

  String? get avatar => ConfigStore.to.isBossMode ? boss?.logo : geek?.avatar;

  String? get name => ConfigStore.to.isBossMode ? boss?.name : geek?.name;

  String? get summary =>
      ConfigStore.to.isBossMode ? boss?.country : geek?.occupation;

  @override
  void onClose() {
    textInput.dispose();
    super.onClose();
  }

  void updateGeekInfo(GeekModel? data) async {
    if (data == null) return;
    UserStore.to.updateGeekInfo(data);
    update();
  }

  void updateBossInfo(BossModel? data) async {
    if (data == null) return;
    UserStore.to.updateBossInfo(data);
    update();
  }
}
