import '../../../shared/app_imports/app_imports.dart';
import '../controller/money_controller.dart';

class MoneyTransferScreen extends StatelessWidget {
  const MoneyTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoneyTransferController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Coins"),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                user['name'] ?? 'Unknown User',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                _showTransferSheet(
                  context,
                  controller,
                  user['uid'],
                  user['name'],
                );
              },
            );
          },
        );
      }),
      backgroundColor: Colors.black,
    );
  }

  void _showTransferSheet(
    BuildContext context,
    MoneyTransferController controller,
    String toUid,
    String name,
  ) {
    final amountController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Send coins to $name",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                "Your coins: ${controller.currentCoins.value.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Enter amount",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final amount =
                    double.tryParse(amountController.text.trim()) ?? 0;
                if (amount <= 0) {
                  Get.snackbar(
                    "Invalid",
                    "Enter a valid amount",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                if (amount > controller.currentCoins.value) {
                  Get.snackbar(
                    "Error",
                    "You don't have enough coins",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                await controller.transferCoins(toUid, amount);
                Get.back(); // close sheet
                Get.snackbar(
                  "Success",
                  "Sent $amount coins to $name",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Send"),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
