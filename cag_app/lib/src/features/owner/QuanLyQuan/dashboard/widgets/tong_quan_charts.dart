import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TongQuanChartsSection extends StatelessWidget {
  const TongQuanChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChartContainer(
          title: "TẦN SUẤT CHƠI GAME (TUẦN)",
          icon: Icons.show_chart,
          child: SizedBox(height: 200, child: _buildLineChart()),
        ),
        const SizedBox(height: 20),
        _buildChartContainer(
          title: "PHÁT TRIỂN HỘI VIÊN MỚI",
          icon: Icons.person_add_alt_1_outlined,
          child: SizedBox(height: 220, child: _buildBarChart()),
        ),
      ],
    );
  }

  Widget _buildChartContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131720),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 650,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.05),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.05),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 650,
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  meta: meta, // Đã đổi theo thư viện mới
                  space: 8,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
            left: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1200),
              FlSpot(1, 1100),
              FlSpot(2, 1300),
              FlSpot(3, 1250),
              FlSpot(4, 1800),
              FlSpot(5, 2500),
              FlSpot(6, 2400),
            ],
            isCurved: true,
            color: const Color(0xFF00F2EA),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: const Color(0xFF00F2EA),
                    strokeWidth: 2,
                    strokeColor: const Color(0xFF0D1117),
                  ),
            ),
          ),
        ],
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 2600,
      ),
    );
  }

  Widget _buildBarChart() {
    return Column(
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 150,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.white.withOpacity(0.05),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  left: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: 150,
                    getTitlesWidget: (double value, TitleMeta meta) =>
                        SideTitleWidget(
                          meta: meta, // Đã đổi
                          space: 8,
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                            ),
                          ),
                        ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const labels = [
                        'T10/25',
                        'T11/25',
                        'T12/25',
                        'T1/26',
                        'T2/26',
                        'T3/26',
                      ];
                      if (value >= 0 && value < labels.length) {
                        return SideTitleWidget(
                          meta: meta, // Đã đổi
                          space: 10,
                          child: Text(
                            labels[value.toInt()],
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              barGroups: [
                _makeBarGroup(0, 120),
                _makeBarGroup(1, 180),
                _makeBarGroup(2, 250),
                _makeBarGroup(3, 320),
                _makeBarGroup(4, 450),
                _makeBarGroup(5, 600),
              ],
              maxY: 600,
              alignment: BarChartAlignment.spaceAround,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 12, height: 12, color: const Color(0xFF00F2EA)),
            const SizedBox(width: 8),
            const Text(
              "Hội viên mới",
              style: TextStyle(
                color: Color(0xFF00F2EA),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFF00F2EA),
          width: 35,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}

class SourceChartWidget extends StatelessWidget {
  const SourceChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00F2EA).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_outline,
                color: Color(0xFF00F2EA),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "NGUỒN KHÁCH HÀNG (CAG GUIDE VS TỰ NHIÊN)",
                style: GoogleFonts.rajdhani(
                  color: const Color(0xFF00F2EA),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 300,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white10,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white10,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 300,
                      reservedSize: 35,
                      getTitlesWidget: (double value, TitleMeta meta) =>
                          SideTitleWidget(
                            meta: meta, // Đã đổi
                            space: 8,
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                              ),
                            ),
                          ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const labels = [
                          'T10/25',
                          'T11/25',
                          'T12/25',
                          'T1/26',
                          'T2/26',
                          'T3/26',
                        ];
                        if (value >= 0 && value < labels.length) {
                          return SideTitleWidget(
                            meta: meta, // Đã đổi
                            space: 10,
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 850),
                      FlSpot(1, 880),
                      FlSpot(2, 900),
                      FlSpot(3, 920),
                      FlSpot(4, 950),
                      FlSpot(5, 1000),
                    ],
                    isCurved: true,
                    color: const Color(0xFFEC4899),
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFEC4899).withOpacity(0.4),
                    ),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 150),
                      FlSpot(1, 220),
                      FlSpot(2, 350),
                      FlSpot(3, 500),
                      FlSpot(4, 750),
                      FlSpot(5, 1200),
                    ],
                    isCurved: true,
                    color: const Color(0xFF00F2EA),
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF00F2EA).withOpacity(0.4),
                    ),
                  ),
                ],
                minY: 0,
                maxY: 1200,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem("Khách Tự Nhiên", const Color(0xFFEC4899)),
              const SizedBox(width: 16),
              _buildLegendItem("Từ CAG Guide", const Color(0xFF00F2EA)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
