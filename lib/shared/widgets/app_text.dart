// lib/shared/widgets/app_text.dart

import 'package:flutter/material.dart';
import '../styles/app_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextDecoration decoration;
  final Color? underLineColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final AppFontFamily fontFamily;
  final TextStyle? style;
  final bool underline; // <-- New flag

  const AppText({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.decoration = TextDecoration.none,
    this.underLineColor,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.maxLines,
    this.overflow,
    this.color,
    this.fontFamily = AppFontFamily.inter,
    this.style,
    this.underline = false, // <-- Default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ??
        AppFonts.getFontStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: underline
              ? TextDecoration.underline
              : decoration,
          decorationColor: underLineColor,
          color: color,
        );

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: effectiveStyle,
    );
  }
}

