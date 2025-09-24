import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiningController extends GetxController {
  final int coinCount = 15;
  final RxList<Offset> coins = <Offset>[].obs;
  final RxDouble minedCoins = 0.0.obs;
  final _random = Random();
  RxBool isLoading = false.obs;
  final user = FirebaseAuth.instance;

  void generateInitialCoins(double boxWidth, double boxHeight) {
    coins.clear();
    for (int i = 0; i < coinCount; i++) {
      coins.add(_randomPosition(boxWidth, boxHeight));
    }
  }

  Offset _randomPosition(double boxWidth, double boxHeight) {
    // leave 60px margin so coins don't overflow container
    final x = _random.nextDouble() * (boxWidth - 60);
    final y = _random.nextDouble() * (boxHeight - 60);
    return Offset(x, y);
  }

  void collectCoin(int index, double boxWidth, double boxHeight) {
    minedCoins.value += 0.001;
    coins[index] = _randomPosition(boxWidth, boxHeight);
    coins.refresh();
    _updateCoinInFirebase(0.001);
  }

  Future<void> _updateCoinInFirebase(double coinsValue) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'totalCoin': FieldValue.increment(coinsValue),
      });
    }
  }

  Future<void> withdrawCoins() async {
    isLoading(true);
    Future.delayed(const Duration(seconds: 1));
    minedCoins.value = 0.0;
    isLoading(false);
  }
}
