import 'package:flutter/material.dart';
import '../../../../../models/gamer_models.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final bool isMyGameTab;

  const GameCard({super.key, required this.game, this.isMyGameTab = false});

  @override
  Widget build(BuildContext context) {
    bool isTool = game.location == "TOOLS";

    // --- 1. LOGIC TÍNH TOÁN ĐỘ MỚI (ẨN TAG UPDATE) ---
    DateTime updateTime =
        DateTime.tryParse(game.progressValue) ?? DateTime.now();
    DateTime now = DateTime.now();
    int daysDiff = now.difference(updateTime).inDays;
    bool isRecentUpdate = daysDiff <= 3;

    // --- 2. GỌI HÀM TÍNH THỜI GIAN ĐỂ HIỂN THỊ ---
    String timeAgo = _formatTimeAgo(game.progressValue);

    if (isMyGameTab) {
      return Container(); // Không dùng nữa, vì đã tách ra dùng FakeMyGameCard
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF080808),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                game.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              if (!isTool && isRecentUpdate)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "NEW UPDATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              game.location.toUpperCase(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.white38,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    game.progressValue,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      color: Color(0xFFFF512F),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const Text(
                    "trước",
                    style: TextStyle(
                      color: Color(0xFFFF512F),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(String dateTimeString) {
    try {
      DateTime updateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();
      Duration diff = now.difference(updateTime);

      if (diff.inDays > 0) {
        int days = diff.inDays;
        int hours = diff.inHours % 24;
        return hours > 0 ? "$days ngày $hours giờ" : "$days ngày";
      }
      if (diff.inHours > 0) {
        int hours = diff.inHours;
        int mins = diff.inMinutes % 60;
        return mins > 0 ? "$hours giờ $mins phút" : "$hours giờ";
      }
      if (diff.inMinutes > 0) return "${diff.inMinutes} phút";
      return "Vừa xong";
    } catch (e) {
      return "Vừa xong";
    }
  }
}

// =====================================================
// WIDGET DÀNH RIÊNG CHO TAB "GAME CỦA TÔI" (FAKE DATA )
// =====================================================
class FakeMyGameCard extends StatelessWidget {
  final String title;
  final String type;
  final String time;
  final String location;
  final double progress;
  final String progressText;
  final String imageUrl;

  const FakeMyGameCard({
    super.key,
    required this.title,
    required this.type,
    required this.time,
    required this.location,
    required this.progress,
    required this.progressText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1015), // Nền tối giống trong ảnh thiết kế
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // 1. Cột Ảnh bên trái (Có Badge Online/Offline đè lên)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              height: 110,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  if (type.isNotEmpty)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),

          // 2. Cột Thông tin bên phải
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 15),
                // Thanh tiến trình xanh lam
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        alignment: Alignment.centerLeft,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              width: constraints.maxWidth * progress,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF3B82F6,
                                ), // Màu xanh dương giống ảnh
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF3B82F6,
                                    ).withOpacity(0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      progressText,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Icon đồng hồ (Tím) + Thời gian
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Color(0xFFA855F7),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Icon địa điểm (Xanh dương) + Vị trí
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF0EA5E9),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
