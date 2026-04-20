import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tong_quan/providers/tong_quan_providers.dart';
import '../../../../../constants/app_theme.dart';
import '../widgets/radar_section.dart';
import '../widgets/flash_sale_section.dart';
import '../widgets/reviews_section.dart';

class MarketingScreen extends ConsumerWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final occupancy = ref.watch(occupancySimProvider);

    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadarSection(
              occupancy: occupancy,
              onSimulateOccupancy: (v) => ref.read(occupancySimProvider.notifier).state = v.toInt(),
            ),
            const SizedBox(height: 24),
            const FlashSaleSection(),
            const SizedBox(height: 24),
            const ReviewsSection(),
          ],
        ),
      ),
    );
  }
}
