import 'package:flutter/material.dart';

class ProCloudSaveCard extends StatelessWidget {
  final VoidCallback onTrigger;
  const ProCloudSaveCard({super.key, required this.onTrigger});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF04121A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00FF75).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FF75).withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.language, color: Color(0xFF00E5FF), size: 24),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "PRO CLOUD SAVE - KHÔNG GIỚI HẠN VỊ TRÍ",
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.6,
              ),
              children: [
                TextSpan(text: "Chơi tiếp tựa game AAA yêu thích của bạn ở "),
                TextSpan(
                  text: "BẤT KỲ ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text:
                      "đại lý nào sử dụng phần mềm CAG Pro. Dữ liệu save game offline được đồng bộ toàn cầu thông qua Internet với độ trễ bằng 0. Sân chơi đẳng cấp dành riêng cho cộng đồng game thủ offline.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: onTrigger,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF0085FF)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0085FF).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card, color: Colors.black, size: 18),
                  SizedBox(width: 10),
                  Text(
                    "NHẬN THẺ ĐẲNG CẤP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
