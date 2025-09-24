import 'package:dolphin/app_module/trade/view/trade_screen.dart';

import '../../../shared/app_imports/app_imports.dart';
import '../../Blog/view/blog_screen.dart';
import '../../Mining/view/mining_screen.dart';
import '../../MoneyTransfer/view/money_transfer_screen.dart';
import '../../chat/view/chatscreen.dart';
import '../../game/view/game_screen.dart';
import '../../wallet/view/wallet_screen.dart';
import '../controller/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final MainController controller = Get.put(MainController());

  final List<Widget> screens = [
    MiningScreen(),
    TradeScreen(),
    GameScreen(),
    ChatScreen(),
    BlogScreen(),
    WalletScreen(),
    MoneyTransferScreen(),
  ];

  final List<String> titles = const [
    "Mining",
    "Trade",
    "Game",
    "Ai Chat",
    "Blog",
    "Wallet",
    "Money Transfer",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          title: Text(
            titles[controller.selectedIndex.value],
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.darkPurple,
        ),
        drawer: _buildDrawer(context),
        body: screens[controller.selectedIndex.value],
      );
    });
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      backgroundColor: AppColors.darkPurple,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Image.asset(AppImages.logo, height: 100.w, width: 100.w),
            SizedBox(height: 30.h),
            ...List.generate(titles.length, (index) {
              return ListTile(
                title: Text(
                  titles[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  controller.changeIndex(index);
                  Navigator.pop(context);
                },
              );
            }),
            const Spacer(),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.put(AuthController());
                Get.offAllNamed(AppRoutes.loginScreen);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
