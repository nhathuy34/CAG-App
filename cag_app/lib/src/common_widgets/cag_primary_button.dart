import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';

class CagPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? pressedColor;
  final bool isBorder;
  final double height;
  final double fontSize;
  final double borderRadius;
  final Color? boderColor;
  final MainAxisAlignment contentAlignment;

  const CagPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.pressedColor,
    this.isBorder = false,
    this.height = 60,
    this.fontSize = 16,
    this.borderRadius = 15,
    this.boderColor,
    this.contentAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBgColor =
        backgroundColor ?? (isBorder ? Colors.transparent : AppTheme.gold);
    final Color effectiveTextColor =
        textColor ?? (isBorder ? Colors.white : AppTheme.textBlack);
    final Color effectivePressedColor =
        pressedColor ??
        (isBorder
            ? (boderColor ?? AppTheme.cyanNeon).withOpacity(0.1)
            : effectiveTextColor.withOpacity(0.15));

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          foregroundColor: effectiveTextColor,
          overlayColor: effectivePressedColor,

          elevation: isBorder ? 0 : 4,
          shadowColor: !isBorder
              ? effectiveBgColor.withOpacity(0.4)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isBorder
                ? BorderSide(color: boderColor ?? AppTheme.textDim, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: contentAlignment,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, color: effectiveTextColor, size: 22),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: TextStyle(
                    color: effectiveTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: fontSize,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 10),
              Icon(suffixIcon, color: effectiveTextColor, size: 22),
            ],
          ],
        ),
      ),
    );
  }
}
