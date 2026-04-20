import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'color': Colors.orange,
        'text': 'Gamer VIP-05 vừa gọi 1 Sting Dâu + 1 Mì Trứng',
        'time': 'Vừa xong'
      },
      {
        'color': const Color(0xFF00E676),
        'text': 'Nguyễn Văn A vừa check-in máy VIP-12',
        'time': '2 phút trước'
      },
      {
        'color': const Color(0xFF2979FF),
        'text': 'Trần B đặt trước máy Standard-05 (14:00)',
        'time': '15 phút trước'
      },
      {
        'color': Colors.grey,
        'text': 'Hệ thống đã đồng bộ dữ liệu CSM thành công',
        'time': '30 phút trước'
      },
    ];

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
              const Icon(Icons.show_chart, color: Color(0xFF2979FF), size: 16),
              const SizedBox(width: 8),
              Text(
                'Hoạt Động Gần Đây'.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.05)),
            itemBuilder: (context, index) {
              final act = activities[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 8,
                      height: 8,
                      decoration:
                          BoxDecoration(color: act['color'] as Color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(act['text'] as String,
                              style: const TextStyle(color: Colors.white, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text((act['time'] as String).toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
