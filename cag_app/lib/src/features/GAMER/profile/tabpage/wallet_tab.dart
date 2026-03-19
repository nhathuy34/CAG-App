import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/provider/profile_provider.dart';
import 'package:CAG_App/src/models/gamerStats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletTab extends ConsumerWidget {
  const WalletTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return statsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.cyanNeon),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (stats) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainBalance(stats.balance),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LINKED MEMBERSHIP',
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    width: 120,
                    child: CagPrimaryButton(
                      text: '+ ADD CARD',
                      onPressed: () => {},
                      isBorder: true,
                      boderColor: AppTheme.cyanNeon,
                      textColor: AppTheme.cyanNeon,
                      height: 35,
                      fontSize: 12,
                      borderRadius: 4,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              ...stats.linkedCards.map((card) => _buildMembershipCard(card)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainBalance(String balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.walletBoxBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.walletBoxBorder, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'MAIN BALANCE',
            style: GoogleFonts.rajdhani(
              color: AppTheme.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 8),
          Text(
            '$balance VND',
            style: GoogleFonts.rajdhani(
              color: AppTheme.textWhite,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 20),
          CagPrimaryButton(
            text: "TOP UP",
            onPressed: () {},
            backgroundColor: AppTheme.walletBoxBorder,
            pressedColor: AppTheme.statsOrange,
            textColor: AppTheme.textWhite,
            borderRadius: 8,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard(MembershipCard card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              card.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title,
                  style: GoogleFonts.rajdhani(
                    color: AppTheme.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  card.number,
                  style: GoogleFonts.ibmPlexMono(
                    color: AppTheme.textDim,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Text(
            '${card.price} VND',
            style: GoogleFonts.rajdhani(
              color: AppTheme.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
