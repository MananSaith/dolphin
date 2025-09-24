import 'dart:io';

import 'package:dolphin/shared/app_imports/app_imports.dart';
import 'package:flutter/cupertino.dart';

// Use final for all fields, no mutable fields in StatelessWidget
class AppButton extends StatelessWidget {
  final String buttonName;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final FontWeight fontWeight;
  final BorderRadius buttonRadius;
  final IconData icon;
  final String iconImage;
  final bool isIcon;
  final bool isCenter;
  final double iconSize;
  final double iconWidth;
  final double iconHeight;
  final double paddingButton;
  final VoidCallback onTap;
  final double borderWidth;
  final Color borderColor;
  final AppFontFamily fontFamily;
  final bool isSuffix;
  final double elevation;

  const AppButton({
    super.key,
    required this.buttonName,
    this.buttonWidth = 250,
    this.buttonHeight = 49,
    required this.buttonColor,
    required this.textColor,
    this.fontWeight = FontWeight.normal,
    this.buttonRadius = BorderRadius.zero,
    this.iconColor = Colors.white,
    this.icon = Icons.home,
    this.iconImage = "",
    this.isIcon = false,
    this.isCenter = false,
    this.iconSize = 30,
    this.iconWidth = 21,
    this.iconHeight = 14,
    this.paddingButton = 0,
    this.fontFamily = AppFontFamily.inter,
    required this.onTap,
    this.textSize = 16,
    this.borderWidth = 0,
    this.elevation = 3.0,
    this.isSuffix = false,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = isIcon
        ? (iconImage.isEmpty
              ? Icon(icon, color: iconColor, size: iconSize)
              : Image.asset(
                  iconImage,
                  height: iconSize,
                  width: iconWidth,
                  color: iconImage.isEmpty ? null : iconColor,
                ))
        : const SizedBox.shrink();

    final Widget textWidget = AppText(
      text: buttonName,
      color: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: textSize,
    );

    final mainContent = Row(
      mainAxisAlignment: paddingButton == 0
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isSuffix) iconWidget,
        if (!isSuffix)
          SizedBox(
            width: paddingButton == 0 ? (isIcon ? 0 : 0) : paddingButton,
          ),
        if (isSuffix)
          SizedBox(
            width: 60.w,
            child: Center(child: textWidget),
          )
        else
          Center(child: textWidget),
        if (isCenter) const Spacer(),
        if (isCenter && isIcon && iconImage.isEmpty) iconWidget,
        if (isSuffix && isIcon)
          iconImage.isEmpty
              ? iconWidget
              : Row(
                  children: [
                    Image.asset(
                      iconImage,
                      width: iconWidth,
                      height: iconHeight,
                      color: iconColor,
                    ),
                  ],
                ),
      ],
    );

    return Platform.isAndroid
        ? SizedBox(
            height: buttonHeight,
            width: buttonWidth,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                textStyle: AppFonts.getFontStyle(
                  fontFamily: fontFamily,
                  fontWeight: fontWeight,
                  fontSize: textSize,
                  color: textColor,
                ),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: buttonRadius),
                elevation: elevation,
                side: BorderSide(color: borderColor, width: borderWidth),
              ),
              onPressed: onTap,
              child: Padding(
                padding: isCenter
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                child: mainContent,
              ),
            ),
          )
        : Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: buttonRadius,
              border: Border.all(width: borderWidth, color: borderColor),
            ),
            child: CupertinoButton(
              borderRadius: buttonRadius,
              padding: EdgeInsets.zero,
              color: buttonColor,
              onPressed: onTap,
              child: Padding(
                padding: isCenter
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                child: mainContent,
              ),
            ),
          );
  }
}

class AppButtonWithIcon extends StatelessWidget {
  final String title;
  final String prefixIcon;
  final String suffixIcon;
  final double titleSize;
  final bool isSuffix;
  final bool isPrefix;
  final double prefixIconSize;
  final double suffixIconSize;
  final double iconSpace;
  final Color titleColor;
  final Color borderColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double paddingVertical;
  final double paddingHorizontal;
  final double buttonWidth;
  final VoidCallback onTap;

  const AppButtonWithIcon({
    super.key,
    this.title = '',
    this.prefixIcon = '',
    this.suffixIcon = '',
    this.titleSize = 16,
    this.isSuffix = false,
    this.isPrefix = false,
    this.fontWeight = FontWeight.w500,
    this.borderColor = Colors.transparent,
    this.titleColor = Colors.white,
    this.buttonColor = Colors.white,
    this.iconSpace = 10,
    this.prefixIconSize = 10,
    this.suffixIconSize = 10,
    this.paddingVertical = 10,
    this.paddingHorizontal = 10,
    this.buttonWidth = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: buttonColor,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isPrefix)
              SvgPicture.asset(
                prefixIcon,
                height: prefixIconSize,
                width: prefixIconSize,
              ),
            if (isPrefix) iconSpace.horizontalSpace,
            AppText(
              text: title,
              color: titleColor,
              fontSize: titleSize,
              fontWeight: fontWeight,
            ),
            if (isSuffix) iconSpace.horizontalSpace,
            if (isSuffix)
              SvgPicture.asset(
                suffixIcon,
                height: suffixIconSize,
                width: suffixIconSize,
              ),
            if (isSuffix) iconSpace.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
