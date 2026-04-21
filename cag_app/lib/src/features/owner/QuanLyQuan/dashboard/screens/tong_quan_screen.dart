import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/tong_quan_features.dart';
import '../widgets/tong_quan_metrics.dart';
import '../widgets/tong_quan_charts.dart';

class ThongKeScreen extends StatelessWidget {
  const ThongKeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Nền tối chuẩn
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        title: Text(
          "THỐNG KÊ PHÒNG MÁY",
          style: GoogleFonts.rajdhani(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [_buildOnlineStatus(), const SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MapSectionWidget(),
            SizedBox(height: 20),
            RadarSectionWidget(),
            SizedBox(height: 20),
            AiAnalysisWidget(),
            SizedBox(height: 20),
            OverviewMetricsWidget(),
            SizedBox(height: 40),
            ValuePropositionsWidget(),
            SizedBox(height: 40),
            TongQuanChartsSection(), // Biểu đồ tần suất & hội viên
            SizedBox(height: 20),
            SourceChartWidget(), // Biểu đồ nguồn khách hàng
            SizedBox(height: 20),
            TopGamersWidget(),
            SizedBox(height: 100), // Padding cho FAB khỏi che mất nội dung
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: const Row(
        children: [
          CircleAvatar(backgroundColor: Colors.green, radius: 4),
          SizedBox(width: 6),
          Text(
            "HỆ THỐNG ONLINE",
            style: TextStyle(
              color: Colors.green,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
