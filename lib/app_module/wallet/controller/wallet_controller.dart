import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var userName = ''.obs;
  RxDouble totalCoin = 0.0.obs;
  var selectedAccount = 'Meezan'.obs;

  final List<String> accounts = ["Meezan", "HBL", "JazzCash"];

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      userName.value = doc['name'] ?? 'User';

      totalCoin.value = (doc['totalCoin'] as num).toDouble();
    }
  }

  Future<void> withdrawCoins(double amount) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    if (amount <= 0 || amount > totalCoin.value) return;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'totalCoin': totalCoin.value - amount,
    });

    totalCoin.value -= amount;
  }
}
