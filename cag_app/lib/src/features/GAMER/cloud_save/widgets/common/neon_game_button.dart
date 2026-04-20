import 'package:flutter/material.dart';

class NeonGameButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isSecondary;
  final VoidCallback? onTap; // <--- Thêm sự kiện onTap

  const NeonGameButton({
    super.key,
    required this.text,
    this.icon,
    this.isSecondary = false,
    this.onTap, // <--- Nhận sự kiện onTap
  });

  @override
  Widget build(BuildContext context) {
    // Màu xanh neon chủ đạo
    const Color neonGreen = Color(0xFF00FF75);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Nút chính màu solid, nút phụ màu trong suốt
        color: isSecondary ? Colors.transparent : neonGreen,
        border: Border.all(
          color: isSecondary ? neonGreen : neonGreen,
          width: 1,
        ),
        boxShadow: isSecondary
            ? []
            : [
                BoxShadow(
                  color: neonGreen.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap ?? () {}, // <--- Sử dụng sự kiện onTap
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isSecondary
                        ? neonGreen
                        : Colors.black, // <--- Đổi màu icon
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: isSecondary
                        ? neonGreen
                        : Colors.black, // <--- Đổi màu text
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
