import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLocalizations extends Translations {
  // Singleton pattern
  static final AppLocalizations _instance = AppLocalizations._internal();
  factory AppLocalizations() => _instance;
  AppLocalizations._internal();

  static final Map<String, Map<String, String>> _localizedValues = {};

  @override
  Map<String, Map<String, String>> get keys => _localizedValues;

  // Load translations from assets
  static Future<void> load() async {
    for (final locale in ['en', 'es']) {
      final jsonStr = await rootBundle.loadString('assets/translations/$locale.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      _localizedValues[locale] = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
  }
}
