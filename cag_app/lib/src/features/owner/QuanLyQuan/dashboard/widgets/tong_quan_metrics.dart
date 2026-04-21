import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewMetricsWidget extends StatelessWidget {
  const OverviewMetricsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMetricItem(
          "TỔNG PHÒNG MÁY (QUẢN LÝ)",
          "0",
          "↑ 15% so với tháng trước",
          const Color(0xFF3B82F6),
        ), // Blue
        const SizedBox(height: 12),
        _buildMetricItem(
          "TỔNG GAMER (QUẢN LÝ)",
          "0",
          "● 0 Đang Online",
          const Color(0xFF22C55E),
        ), // Green
        const SizedBox(height: 12),
        _buildMetricItem(
          "HỘI VIÊN MỚI (THÁNG NÀY)",
          "600",
          "↑ 33% so với tháng trước",
          const Color(0xFFEF4444),
        ), // Red
        const SizedBox(height: 12),
        _buildMetricItem(
          "GIỜ CHƠI TRUNG BÌNH/TUẦN",
          "1,500H",
          "↑ 5% so với tuần trước",
          const Color(0xFFA855F7),
        ), // Purple
      ],
    );
  }

  Widget _buildMetricItem(String label, String value, String sub, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117), // Nền đen theo ảnh
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.6), width: 1),
        // Ánh sáng viền mờ ảo bên trái
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(-5, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            sub,
            style: const TextStyle(
              color: Color(0xFF22C55E),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


class ValuePropositionsWidget extends StatelessWidget {
  const ValuePropositionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildValueCard(
          "KHÁCH HÀNG TỪ CAG GUIDE",
          "1,200",
          "GAMER",
          "↑ 45% so với tháng trước",
          "CAG GUIDE mang lại nguồn khách hàng ổn định và chất lượng cao, giúp tối ưu hóa công suất phòng máy.",
          const Color(0xFF00F2EA),
        ),
        const SizedBox(height: 16),
        _buildValueCard(
          "TỶ LỆ CHUYỂN ĐỔI",
          "68%",
          "",
          "↑ 12% so với tháng trước",
          "Tỷ lệ gamer xem thông tin trên app và đến phòng máy thực tế rất cao nhờ các chương trình khuyến mãi độc quyền.",
          const Color(0xFFFFD700),
        ),
        const SizedBox(height: 16),
        _buildValueCard(
          "DOANH THU ƯỚC TÍNH TỪ APP",
          "120M",
          "VNĐ",
          "↑ 30% so với tháng trước",
          "Định vị CAG GUIDE là đối tác tin cậy, giúp gia tăng doanh thu và xây dựng cộng đồng gamer trung thành.",
          const Color(0xFFEC4899),
        ),
      ],
    );
  }


  Widget _buildValueCard(
    String title,
    String val,
    String unit,
    String sub,
    String desc,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF131720),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.rajdhani(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                val,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: const TextStyle(color: Color(0xFF22C55E), fontSize: 12),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
