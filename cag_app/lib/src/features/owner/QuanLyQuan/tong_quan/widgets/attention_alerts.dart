import 'package:flutter/material.dart';

class AttentionAlerts extends StatelessWidget {
  const AttentionAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 16),
              const SizedBox(width: 8),
              Text(
                'Cần Xử Lý Ngay (2)'.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAlertItem(
            severity: 'HIGH',
            color: const Color(0xFFFF1744),
            title: 'Máy 25 (Zone A) báo lỗi nhiệt độ GPU > 85°C.',
            subtitle: 'Cyber All Game Q.Gò Vấp',
            time: '5 phút trước',
          ),
          const SizedBox(height: 12),
          _buildAlertItem(
            severity: 'MEDIUM',
            color: Colors.amber,
            title: '3 Đơn Booking chưa được xử lý quá 10 phút.',
            subtitle: 'Cyber All Game Q.10 Premium',
            time: '10 phút trước',
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem({
    required String severity,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color),
                ),
                child: Text(severity,
                    style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w900)),
              ),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 8)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle.toUpperCase(), style: const TextStyle(color: Colors.grey, fontSize: 8)),
        ],
      ),
    );
  }
}
