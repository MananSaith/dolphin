import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/contants/app_colors.dart';
import '../../../core/utils/app_loader.dart';
import '../controller/coin_controller.dart';
import '../widget/trade_functions.dart';

class TradeScreen extends StatelessWidget {
  TradeScreen({super.key});
  CoinController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchCoins();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.verticalSpace,

                  Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Center(child: customLoader(AppColors.magenta));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.coinList.length,
                      itemBuilder: (context, index) {
                        final coin = controller.coinList[index];
                        String coinId = coin.id.toString();

                        List<double> trend = [
                          (coin.currentPrice ?? 0) - 50,
                          (coin.currentPrice ?? 0) - 1,
                          (coin.currentPrice ?? 0),
                          (coin.currentPrice ?? 0) + 70,
                          (coin.currentPrice ?? 0) + 20,
                        ];

                        bool isLoss = (coin.priceChangePercentage24h ?? 0) < 0;
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(coin.image ?? ""),
                                radius: 18,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      coin.name ?? "No name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      coin.symbol?.toUpperCase() ?? "",
                                      style: TextStyle(color: Colors.grey[600]),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              buildSparkline(trend, isLoss),
                              SizedBox(width: Get.width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${coin.currentPrice?.toStringAsFixed(2) ?? '--'}",
                                    style: TextStyle(
                                      color: AppColors.primaryBlack,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '--'}%",
                                    style: TextStyle(
                                      color: isLoss ? Colors.red : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
