import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MoneyTransferController extends GetxController {
  var isLoading = true.obs;
  var users = <Map<String, dynamic>>[].obs;
  var currentCoins = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    fetchCurrentUserCoins();
  }

  Future<void> fetchUsers() async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance.collection('users').get();

    users.assignAll(
      snapshot.docs
          .where((doc) => doc.id != currentUid)
          .map((doc) => {'uid': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList(),
    );
    isLoading.value = false;
  }

  Future<void> fetchCurrentUserCoins() async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .get();
    currentCoins.value = (doc['totalCoin'] as num).toDouble();
  }

  Future<void> transferCoins(String toUid, double amount) async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final batch = FirebaseFirestore.instance.batch();

    final currentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid);
    final targetRef = FirebaseFirestore.instance.collection('users').doc(toUid);

    // Deduct from current user
    batch.update(currentRef, {'totalCoin': FieldValue.increment(-amount)});
    // Add to target user
    batch.update(targetRef, {'totalCoin': FieldValue.increment(amount)});

    await batch.commit();
    await fetchCurrentUserCoins(); // update locally
  }
}
