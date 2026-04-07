import 'package:flutter/material.dart';

class MainInfoBanner extends StatelessWidget {
  const MainInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF04101A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF0085FF).withOpacity(0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_none,
                color: Color(0xFF00FF75),
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                "KHO GAMES SẴN CÓ TRÊN MÁY CHỦ CAG PRO",
                style: TextStyle(
                  color: Color(0xFF00FF75),
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Hệ thống danh sách Game từ trạm IDC Master Center\n=> Không phải trên menu game tại phòng máy này\n=> Nếu phòng máy chưa tải game, vui lòng thông báo cho thu ngân / chủ phòng máy ... để hỗ trợ tải về cho bạn chiến nhé!",
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.6),
          ),
        ],
      ),
    );
  }
}
