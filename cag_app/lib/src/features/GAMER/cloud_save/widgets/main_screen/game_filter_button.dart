import 'package:flutter/material.dart';

class GameFilterButton extends StatelessWidget {
  final bool isFiltering;
  final VoidCallback onTap;

  const GameFilterButton({
    super.key,
    required this.isFiltering,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          // Đổi màu nền: Xanh mờ khi bật, đen xám khi tắt
          color: isFiltering
              ? const Color(0xFF00FF75).withOpacity(0.05)
              : const Color(0xFF121212),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFiltering
                ? const Color(0xFF00FF75)
                : Colors.white.withOpacity(0.05),
            width: isFiltering ? 1.5 : 1,
          ),
          // Hiệu ứng tỏa sáng Neon
          boxShadow: isFiltering
              ? [
                  BoxShadow(
                    color: const Color(0xFF00FF75).withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.attach_money, // Icon $ chuẩn theo ảnh
              color: isFiltering ? const Color(0xFF00FF75) : Colors.white54,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              isFiltering ? "ĐANG HIỆN GAME MỚI" : "LỌC GAME MỚI",
              style: TextStyle(
                color: isFiltering ? const Color(0xFF00FF75) : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
