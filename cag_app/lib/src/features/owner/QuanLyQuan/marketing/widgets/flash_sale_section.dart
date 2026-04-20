import 'package:flutter/material.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4C1D95), Color(0xFF312E81)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          const Positioned(
              right: -20,
              top: -20,
              child: Text('⚡', style: TextStyle(fontSize: 120, color: Colors.white10))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tạo Flash Sale',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text(
                  'Kéo khách ngay lập tức khi quán vắng. Thông báo sẽ được gửi đến 1500+ Gamer quanh khu vực.',
                  style: TextStyle(color: Color(0xFFDDD6FE), fontSize: 13)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildSaleInput('GIẢM GIÁ (%)', '20')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSaleInput('SỐ LƯỢNG CODE', '50')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSaleInput('THÔNG ĐIỆP', 'Mừng Member mới', isSmall: true)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: const Center(
                    child: Text('BẮN THÔNG BÁO (PUSH NOTI)',
                        style: TextStyle(
                            color: Color(0xFF4C1D95), fontSize: 14, fontWeight: FontWeight.w900))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaleInput(String label, String value, {bool isSmall = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFFC4B5FD), fontSize: 9, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  color: Colors.white, fontSize: isSmall ? 13 : 24, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
