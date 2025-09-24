// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const whiteColor = Colors.white;

  // Extracted from DolphinSplash design
  static const Color primaryBlack = Color(0xFF0A000D); // deep background
  static const Color darkPurple = Color(0xFF1A001F); // card/input borders
  static const Color magenta = Color(0xFFE41EE8); // gradient start
  static const Color magenta1 = Color(0x00E41EE8); // gradient start
  static const Color pink = Color(0xFFFC33A5); // gradient end
  static const Color white = Colors.white;
  static const Color greyText = Color(0xFFB5B5B5);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [magenta, pink],
  );

  static const RadialGradient primaryRadialGradient = RadialGradient(
    center: Alignment.bottomCenter,
    radius: 1.5,
    colors: [magenta1, primaryBlack],
    stops: [0.0, 0.4],
  );
}
