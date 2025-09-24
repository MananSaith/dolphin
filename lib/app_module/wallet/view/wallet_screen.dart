import '../../../shared/app_imports/app_imports.dart';
import '../controller/wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());

    return Scaffold(
      backgroundColor: Colors.black,

      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: AssetImage(AppImages.logo),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName.value,
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.coin,
                            width: 24.w,
                            height: 24.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            controller.totalCoin.value.toStringAsFixed(5),
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Withdraw Button
              ElevatedButton(
                onPressed: () {
                  if (controller.totalCoin.value <= 0) {
                    Get.snackbar(
                      'Error',
                      'No coins to withdraw',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  _showWithdrawSheet(context, controller);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text(
                  "Withdraw Coins",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 40.h),

              // Account Selector
              Text(
                "Select Withdraw Account",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.accounts.length,
                  itemBuilder: (context, index) {
                    final account = controller.accounts[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedAccount.value == account;
                      return ListTile(
                        tileColor: isSelected
                            ? Colors.purple.withOpacity(0.2)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        title: Text(
                          account,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.purple)
                            : null,
                        onTap: () => controller.selectedAccount.value = account,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showWithdrawSheet(BuildContext context, WalletController controller) {
    final amountController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter Amount',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter coins to withdraw',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.white24),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                final entered =
                    double.tryParse(amountController.text.trim()) ?? 0.0;

                print(
                  'entered amount $entered   totalAmount : ${controller.totalCoin.value}',
                );
                if (entered <= 0 || entered > controller.totalCoin.value) {
                  print('Invalid amount');
                  Get.snackbar(
                    'Error',
                    'Invalid amount',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                controller.withdrawCoins(entered);
                Get.back();
                Get.snackbar(
                  'Success',
                  'Withdrawn $entered coins',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text(
                "Confirm Withdraw",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
