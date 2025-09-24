import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/coin_model.dart';

class CoinController extends GetxController {
  RxList<CoinModel> coinList = <CoinModel>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    coinList.clear();
    const url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        debugPrint(" $url --->>> $data");

        coinList.value = data.map((e) => CoinModel.fromJson(e)).toList();
        isLoading(false);
      } else {
        print("Failed to fetch coins: ${response.statusCode}");
      }
    } catch (e) {
      print("API Error: $e");
    }
  }
}
