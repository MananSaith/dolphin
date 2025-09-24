// lib/shared/styles/app_fonts.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFontFamily {
  inter,
  roboto,
  railway,
  poppins,
}

class AppFonts {
  static TextStyle getFontStyle({
    required AppFontFamily fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
    Color? color,
  }) {
    switch (fontFamily) {
      case AppFontFamily.inter:
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
          color: color,
        );
      case AppFontFamily.railway:
        return GoogleFonts.raleway(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
          color: color,
        );
      case AppFontFamily.poppins:
        return GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
          color: color,
        );
      case AppFontFamily.roboto:
      default:
        return GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
          color: color,
        );
    }
  }
}
