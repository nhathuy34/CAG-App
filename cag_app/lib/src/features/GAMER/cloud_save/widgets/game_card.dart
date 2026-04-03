import 'package:flutter/material.dart';
import '../../../../models/game_model.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final bool isMyGameTab;

  const GameCard({super.key, required this.game, this.isMyGameTab = false});

  @override
  Widget build(BuildContext context) {
    bool isTool = game.location == "TOOLS";

    // --- 1. LOGIC TÍNH TOÁN ĐỘ MỚI (ẨN TAG UPDATE) ---
    DateTime updateTime = DateTime.tryParse(game.progressValue) ?? DateTime.now();
    DateTime now = DateTime.now();
    int daysDiff = now.difference(updateTime).inDays;
    // Nếu quá 3 ngày thì coi là cũ -> Không hiện tag NEW UPDATE
    bool isRecentUpdate = daysDiff <= 3;

    // --- 2. GỌI HÀM TÍNH THỜI GIAN ĐỂ HIỂN THỊ ---
    String timeAgo = _formatTimeAgo(game.progressValue);

    if (isMyGameTab) {
      return _buildMyGameCard();
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
              // CHỈ HIỆN TAG NẾU KHÔNG PHẢI TOOL VÀ MỚI CẬP NHẬT TRONG 3 NGÀY
              if (!isTool && isRecentUpdate) 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  const Icon(Icons.access_time, color: Colors.white38, size: 14),
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
              // HIỂN THỊ THỜI GIAN 2 DÒNG MÀU CAM ĐỎ
              
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

  // Hàm tính toán thời gian chi tiết
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

  Widget _buildMyGameCard() {
    return Container(); // Placeholder
  }
}