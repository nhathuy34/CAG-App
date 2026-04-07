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
  final bool isGradient; // Thêm biến này

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
    this.isGradient = false, // Mặc định là false để không ảnh hưởng file cũ
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = textColor ?? (isBorder ? Colors.white : AppTheme.textBlack);
    
    // Nếu là Gradient thì dùng Container + InkWell, nếu không thì dùng ElevatedButton cũ
    if (isGradient && !isBorder) {
      return _buildGradientButton(effectiveTextColor);
    }

    // Logic cũ của m giữ nguyên để các file khác không bị lỗi
    final Color effectiveBgColor = backgroundColor ?? (isBorder ? Colors.transparent : AppTheme.gold);
    final Color effectivePressedColor = pressedColor ??
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
          shadowColor: !isBorder ? effectiveBgColor.withOpacity(0.4) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isBorder
                ? BorderSide(color: boderColor ?? AppTheme.textDim, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: _buildButtonContent(effectiveTextColor),
      ),
    );
  }

  // Hàm build nội dung Row (Icon + Text) dùng chung
  // Hàm build nội dung Row (Icon + Text) dùng chung
  Widget _buildButtonContent(Color color) {
    return Row(
      mainAxisAlignment: contentAlignment,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, color: color, size: 18), // Thu nhỏ icon xíu cho dễ thở
          const SizedBox(width: 4), // Rút bớt khoảng cách
        ],
        Flexible(
          child: FittedBox( // THÊM CÁI NÀY VÀO LÀ VÔ ĐỐI
            fit: BoxFit.scaleDown, // Tự động scale nhỏ lại nếu thiếu chỗ
            child: Text(
              text,
              maxLines: 1, // Bắt buộc 1 dòng
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: fontSize,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 4),
          Icon(suffixIcon, color: color, size: 18),
        ],
      ],
    );
  }

  // Hàm build riêng cho nút Gradient (Xanh Cyan chuẩn ảnh)
  Widget _buildGradientButton(Color color) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF06B6D4).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: _buildButtonContent(color),
      ),
    );
  }
}