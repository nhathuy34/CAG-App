import 'package:CAG_App/src/features/owner/QuanLyQuan/dashboard/model/notification_model.dart';
import 'package:flutter/material.dart';
import '../providers/notification_providers.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel item;

  const NotificationItem({super.key, required this.item});

  Color getColor() {
    switch (item.type) {
      case 'Cảnh báo / Bảo trì':
        return const Color(0xFFFF4D4F);
      case 'Khuyến mãi / Ưu đãi':
        return const Color(0xFFFF8C42);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')} "
        "${time.day}/${time.month}/${time.year}";
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B121E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TAG + TITLE
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.type.toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// CONTENT
                Text(
                  item.content,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                /// TIME
                Text(
                  "Gửi tới: GAMER ${formatTime(item.createdAt)}",
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT ACTION
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Xem chi tiết",
                style: TextStyle(
                  color: Color(0xFF00B7D4),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}