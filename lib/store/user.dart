part of 'index.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  ProfileModel _info = ProfileModel();
  bool _isLogin = false;
  String _account = '';

  String get account => _account;
  ProfileModel get info => _info;
  bool get isLogin => _isLogin;

  @override
  void onInit() {
    super.onInit();
    _account = StorageService.to.getString(C.localAccount);
  }

  Future<void> setAccount(String? value) async {
    _account = value?.toString() ?? '';
    await StorageService.to.setString(C.localAccount, _account);
    _isLogin = true;
  }

  void setProfile(ProfileModel data) {
    if (data.boss != null) {
      _info.boss = data.boss;
    } else {
      _info.geek = data.geek;
    }
    _isLogin = true;
  }

  void updateGeekInfo(GeekModel data) {
    _info.geek = _info.geek?.copyWith(
      name: data.name,
      email: data.email,
      birthday: data.birthday,
      occupation: data.occupation,
      address: data.address,
      avatar: data.avatar,
    );
    update();
  }

  void updateBossInfo(BossModel data) {
    _info.boss = _info.boss?.copyWith(
      name: data.name,
      email: data.email,
      established: data.established,
      country: data.country,
      address: data.address,
      logo: data.logo,
    );
    update();
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        Future.delayed(const Duration(seconds: 1)),
        StorageService.to.remove(C.localRole),
      ]);
    } finally {
      ConfigStore.to.setRole('');
      _account = '';
      _info = ProfileModel();
      _isLogin = false;
    }
  }
}
