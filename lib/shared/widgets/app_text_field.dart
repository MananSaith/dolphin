import 'dart:ui';

import 'package:dolphin/shared/app_imports/app_imports.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  String hint;
  String? intialvalue;
  TextEditingController controller;
  bool isPrefix;
  bool isSuffix;
  bool obscureText;
  Widget icon;
  Widget suffixIcon;
  int maxLines;
  int miniLines;
  double borderRadius;
  VoidCallback? onTap;
  TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  final Color? backgroundColor;
  final bool showBorder;
  final Color? hintColor;
  final Color? borderColor;
  final bool isBorder;

  final Color? inputColor; // ✅ NEW: user input text color

  AppTextField({
    super.key,
    this.hint = '',
    required this.controller,
    this.onChanged,
    this.borderRadius = 10.0,
    this.isPrefix = false,
    this.isSuffix = false,
    this.obscureText = false,
    this.onTap,
    this.maxLines = 1,
    this.miniLines = 1,
    this.icon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.text,
    this.intialvalue,
    this.inputFormatters,
    this.backgroundColor = Colors.transparent,
    this.showBorder = true,
    this.hintColor,
    this.borderColor,
    this.isBorder = true,
    this.inputColor, // ✅ NEW
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final showBorder = widget.showBorder && widget.isBorder;

    final border = showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.greyText,
            ),
          )
        : InputBorder.none;

    final focusedBorder = showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.darkPurple.withOpacity(.6),
            ),
          )
        : InputBorder.none;

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: SizedBox(
          child: TextFormField(
            controller: widget.controller,
            style: AppFonts.getFontStyle(
              fontFamily: AppFontFamily.roboto,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color:
                  widget.inputColor ?? AppColors.primaryBlack, // ✅ inputColor
            ),
            obscureText: widget.obscureText,
            initialValue: widget.controller.text.isEmpty
                ? widget.intialvalue
                : null,

            maxLines: widget.maxLines,
            minLines: widget.miniLines,
            onTap: widget.onTap,
            autovalidateMode: AutovalidateMode.always,
            cursorColor: AppColors.darkPurple,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
              suffixIcon: widget.isSuffix ? widget.suffixIcon : null,
              prefixIcon: widget.isPrefix ? widget.icon : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              enabledBorder: border,
              focusedBorder: focusedBorder,
              disabledBorder: border, // ✅ prevent underline when disabled
              border: border, // ✅ remove underline fallback
              filled: true,
              isDense: true,
              fillColor: widget.backgroundColor,
              hintText: widget.hint,
              hintStyle: AppFonts.getFontStyle(
                fontFamily: AppFontFamily.roboto,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: widget.hintColor ?? AppColors.greyText.withAlpha(128),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
