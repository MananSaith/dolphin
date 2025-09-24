import 'package:dolphin/shared/widgets/loading_overly.dart';

import '../../../shared/app_imports/app_imports.dart';
import '../controller/mining_controller.dart';

class MiningScreen extends StatelessWidget {
  const MiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MiningController());

    final boxHeight = 0.42.sh;
    final boxWidth = 1.0.sw;

    // ensure coins are generated once after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.coins.isEmpty) {
        controller.generateInitialCoins(boxWidth, boxHeight);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Header / App Name ---
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              Text(
                                "Dolphin Miner",
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(color: Colors.blue, blurRadius: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Column(
                                children: [
                                  Text(
                                    "${controller.minedCoins.value.toStringAsFixed(3)}  COINS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  SizedBox(
                                    width: 180.w,
                                    child: LinearProgressIndicator(
                                      value:
                                          (controller.minedCoins.value % 1.0),
                                      backgroundColor: Colors.grey.shade800,
                                      color: Colors.cyanAccent,
                                      minHeight: 6.h,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Next reward at 1.0 coin",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // --- Coin Area ---
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          width: boxWidth,
                          height: boxHeight,
                          color: Colors.white10,
                          child: Obx(() {
                            return Stack(
                              clipBehavior: Clip.hardEdge,
                              children: List.generate(controller.coins.length, (
                                index,
                              ) {
                                final pos = controller.coins[index];
                                return AnimatedPositioned(
                                  duration: const Duration(milliseconds: 100),
                                  left: pos.dx,
                                  top: pos.dy,
                                  child: GestureDetector(
                                    onTap: () => controller.collectCoin(
                                      index,
                                      boxWidth,
                                      boxHeight,
                                    ),
                                    child: AnimatedScale(
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      scale:
                                          1.0 +
                                          (controller.minedCoins.value % 0.01),
                                      child: Container(
                                        padding: EdgeInsets.all(6.r),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.cyanAccent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Image.asset(
                                          AppImages.coin,
                                          width: 40.w,
                                          height: 40.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),

                      // --- Bottom Section ---
                      10.verticalSpace,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 30.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Keep collecting coins to unlock rewards!\nBoost your mining rate with power-ups.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.w,
                                    vertical: 12.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                icon: const Icon(Icons.account_balance_wallet),
                                label: const Text(
                                  "Withdraw Coins",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  controller.withdrawCoins();
                                },
                              ),
                              SizedBox(height: 12.h),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.cyanAccent,
                                  side: BorderSide(
                                    color: Colors.cyanAccent,
                                    width: 1.2,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 26.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                icon: const Icon(Icons.flash_on),
                                label: const Text("Boost Mining"),
                                onPressed: () {
                                  Get.snackbar(
                                    "Boost",
                                    "Mining boosted for 10 minutes!",
                                    backgroundColor: Colors.black87,
                                    colorText: Colors.cyanAccent,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Top Right Info Button ---
                Positioned(
                  top: 20.h,
                  right: 16.w,
                  child: IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.white),
                    onPressed: () {
                      Get.snackbar(
                        "Mining Tips",
                        "Tap the coins quickly to earn faster!",
                        backgroundColor: Colors.cyan.shade800.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
