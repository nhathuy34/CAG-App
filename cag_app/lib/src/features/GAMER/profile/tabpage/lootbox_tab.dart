import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/provider/profile_provider.dart';
import 'package:CAG_App/src/models/gamerStats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LootBoxTab extends ConsumerWidget {
  const LootBoxTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return statsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.cyanNeon),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (stats) {
        if (stats.lootBoxes.isEmpty) {
          return const Center(
            child: Text(
              "No LootBoxes available",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = (constraints.maxWidth - 16) / 2;
            double itemHeight = itemWidth * 1.35;
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemCount: stats.lootBoxes.length,
              itemBuilder: (context, index) {
                return _buildLootCard(context, stats.lootBoxes[index]);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildLootCard(BuildContext context, LootBoxItem item) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              item.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppTheme.cardBg),
            ),
          ),

          // Tag (FOOD/HOURS)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.tag,
                style: GoogleFonts.rajdhani(
                  color: AppTheme.textWhite,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.textWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.price,
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.statsOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            elevatedButtonTheme: ElevatedButtonThemeData(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                              ),
                            ),
                          ),
                          child: CagPrimaryButton(
                            text: 'CLAIM',
                            onPressed: () {},
                            backgroundColor: AppTheme.cardBlue,
                            pressedColor: AppTheme.gold,
                            textColor: AppTheme.textWhite,
                            height: 25,
                            fontSize: 8,
                            borderRadius: 1,
                          ),
                        ),
                      ),
                    ],
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
