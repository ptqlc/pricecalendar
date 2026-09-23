import 'package:flutter/services.dart';
import 'package:flutter_find_job/services/index.dart';
import 'package:flutter_find_job/store/index.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Future.wait([
      Get.putAsync<StorageService>(() => StorageService().init()),
    ]).whenComplete(() {
      Get.put<ConfigStore>(ConfigStore());
      Get.put<UserStore>(UserStore());
    });
  }
}
