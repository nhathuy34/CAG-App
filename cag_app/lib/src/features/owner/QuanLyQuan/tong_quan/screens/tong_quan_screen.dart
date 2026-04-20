import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/providers/owner_home_providers.dart';
import '../../../../../constants/app_theme.dart';
import '../widgets/kpi_card.dart';
import '../widgets/recent_activity.dart';
import '../widgets/attention_alerts.dart';

class TongQuanScreen extends ConsumerWidget {
  const TongQuanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBranchId = ref.watch(selectedBranchProvider);

    final branchLabels = {
      'ALL': 'TOÀN BỘ HỆ THỐNG',
      '1': 'Cyber All Game Q.Gò Vấp',
      '2': 'Cyber All Game Q.10 Premium',
      '3': 'Cyber All Game Q.7 VIP',
    };

    final currentLabel = branchLabels[selectedBranchId] ?? 'TOÀN BỘ HỆ THỐNG';

    return Container(
      color: AppTheme.darkBg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Branch Label (Subtle)
            Row(
              children: [
                Container(
                  width: 8,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2979FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  currentLabel.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // KPI Grid
            _buildKPIGrid(context),
            const SizedBox(height: 24),

            // Activity & Alerts
            const RecentActivity(),
            const SizedBox(height: 16),
            const AttentionAlerts(),
            const SizedBox(height: 40), // Spacing for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildKPIGrid(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 4 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: const [
        KPICard(
          title: 'Doanh thu (24h)',
          value: '15.450.000',
          unit: ' ₫',
          trend: '▲ 12% so với hôm qua',
          trendColor: Color(0xFF00E676),
          bgColor: Color(0xFF0D47A1),
          valueColor: Color(0xFFFFD700),
          icon: Icons.monetization_on_outlined,
        ),
        KPICard(
          title: 'Lượng Khách',
          value: '85',
          unit: ' / 100',
          progress: 0.85,
          bgColor: Color(0xFF1E1E1E),
          icon: Icons.people_outline,
        ),
        KPICard(
          title: 'Chờ Duyệt',
          value: '2',
          unit: ' đơn',
          trend: 'Xử lý ngay →',
          trendColor: Color(0xFF2979FF),
          bgColor: Color(0xFF1E1E1E),
          icon: Icons.calendar_today_outlined,
        ),
        KPICard(
          title: 'Hệ Thống',
          value: '99.9%',
          unit: ' Uptime',
          trend: '● Tất cả máy Online',
          trendColor: Color(0xFF00E676),
          bgColor: Color(0xFF1E1E1E),
          valueColor: Color(0xFF00E676),
          icon: Icons.sensors_outlined,
        ),
      ],
    );
  }
}
