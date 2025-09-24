import 'dart:async';

import '../../../shared/app_imports/app_imports.dart';

class GameController extends GetxController {
  final totalCoin = 0.0.obs;
  final tiles = <Map<String, dynamic>>[].obs; // {icon, revealed, matched}
  final firstIndex = RxnInt();
  final matchesFound = 0.obs;
  final timeLeft = 60.obs;
  Timer? _timer;
  bool canTap = true;

  @override
  void onInit() {
    super.onInit();
    _loadUserCoins();
    startNewGame();
  }

  void _loadUserCoins() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        totalCoin.value = (doc['totalCoin'] as num).toDouble();
      }
    }
  }

  void _updateUserCoins(double amount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((txn) async {
        final snap = await txn.get(ref);
        final current = (snap['totalCoin'] as num).toDouble();
        txn.update(ref, {'totalCoin': current + amount});
      });
      totalCoin.value += amount;
    }
  }

  void startNewGame() {
    _timer?.cancel();
    matchesFound.value = 0;
    firstIndex.value = null;
    canTap = true;
    timeLeft.value = 60;

    // Prepare 25 tiles → 12 pairs + 1 extra icon
    final icons = [
      Icons.star,
      Icons.favorite,
      Icons.home,
      Icons.access_alarm,
      Icons.flight,
      Icons.cake,
      Icons.music_note,
      Icons.work,
      Icons.wifi,
      Icons.pets,
      Icons.camera_alt,
      Icons.sports_soccer,
      Icons.shopping_cart,
    ];

    final selected = List<IconData>.from(icons)..shuffle();

    // take 12 icons and duplicate manually
    final first12 = selected.take(12).toList();
    final used = [...first12, ...first12]..shuffle(); // repeat instead of * 2

    // Add an extra tile to make total 25
    used.add(selected.last);

    tiles.value = used
        .map((icon) => {'icon': icon, 'revealed': false, 'matched': false})
        .toList();

    // Start timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        canTap = false;
        Future.delayed(const Duration(seconds: 1), startNewGame);
      }
    });
  }

  void onTileTap(int index) {
    if (!canTap || tiles[index]['revealed'] || tiles[index]['matched']) return;

    tiles[index]['revealed'] = true;
    tiles.refresh();

    if (firstIndex.value == null) {
      firstIndex.value = index;
    } else {
      canTap = false;
      final prevIndex = firstIndex.value!;
      if (tiles[index]['icon'] == tiles[prevIndex]['icon']) {
        // Match found
        tiles[index]['matched'] = true;
        tiles[prevIndex]['matched'] = true;
        matchesFound.value++;
        firstIndex.value = null;
        canTap = true;

        // Award coin if 3 pairs found within 30s
        if (matchesFound.value == 3 && timeLeft.value >= 30) {
          _updateUserCoins(1.0);
          Get.snackbar(
            'Congratulations',
            'You earned 1 coin!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Future.delayed(const Duration(seconds: 1), startNewGame);
        }
      } else {
        // No match → flip back after 0.5s
        Future.delayed(const Duration(milliseconds: 500), () {
          tiles[index]['revealed'] = false;
          tiles[prevIndex]['revealed'] = false;
          tiles.refresh();
          firstIndex.value = null;
          canTap = true;
        });
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
