import 'package:dolphin/shared/app_imports/app_imports.dart';

import '../../app_module/trade/controller/coin_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('========================= AuthBinding =======================');
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<CoinController>(() => CoinController());
  }
}
