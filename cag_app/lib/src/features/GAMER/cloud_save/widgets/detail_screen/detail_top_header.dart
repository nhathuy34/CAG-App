import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Thêm thư viện Riverpod
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart'; // Chỉnh lại đường dẫn này nếu cần

// Đổi thành ConsumerWidget để dùng ref
class DetailTopHeader extends ConsumerWidget {
  const DetailTopHeader({super.key});

  @override
  // Thêm WidgetRef ref vào hàm build
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.white54, size: 20),
                SizedBox(width: 10),
                Text(
                  "QUAY LẠI THƯ VIỆN",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "BLACK MYTH: WUKONG",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildBadge(Icons.access_time, "45H ĐÃ CHƠI", Colors.white70),
              const SizedBox(width: 10),
              _buildLocationBadge(),
            ],
          ),
          const SizedBox(height: 25),
          
          // --- BỌC GESTURE DETECTOR VÀO NÚT TÌM QUÁN ---
          GestureDetector(
            onTap: () {
              // 1. Đổi sang tab CAG Guide (Index 3)
              ref.read(navIndexProvider.notifier).setIndex(3);
              // 2. Thoát màn hình Detail hiện tại để trở về giao diện chính
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D6EFD),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0D6EFD).withOpacity(0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "TÌM QUÁN CHƠI NGAY",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ----------------------------------------------
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.white54, size: 14),
          SizedBox(width: 6),
          Text(
            "TẠI: ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "FLASH GAMING ...",
            style: TextStyle(
              color: Color(0xFF00FF75),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
