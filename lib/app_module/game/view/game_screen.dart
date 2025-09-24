import '../../../shared/app_imports/app_imports.dart';
import '../controller/game_controller.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameController());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          'Memory Match',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade700,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Timer + Coins row
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoBadge(
                  icon: Icons.timer,
                  label: '${controller.timeLeft.value}s',
                  color: Colors.blueAccent,
                ),
                _infoBadge(
                  icon: Icons.monetization_on,
                  label: controller.totalCoin.value.toStringAsFixed(2),
                  color: Colors.amber.shade600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Grid
          Expanded(
            child: Obx(() {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.tiles.length,
                itemBuilder: (context, index) {
                  final tile = controller.tiles[index];
                  final revealed = tile['revealed'] || tile['matched'];

                  return GestureDetector(
                    onTap: () => controller.onTileTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      decoration: BoxDecoration(
                        gradient: revealed
                            ? const LinearGradient(
                                colors: [Colors.white, Colors.grey],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.deepPurple.shade800,
                                  Colors.deepPurple.shade400,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: revealed
                                ? Colors.yellowAccent.withOpacity(0.5)
                                : Colors.black54,
                            blurRadius: revealed ? 15 : 8,
                            spreadRadius: revealed ? 3 : 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedOpacity(
                          opacity: revealed ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            tile['icon'],
                            size: 32,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 12),
          // Reset Button
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: controller.startNewGame,
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Reset Game',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Badge widget for timer/coins
  Widget _infoBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
