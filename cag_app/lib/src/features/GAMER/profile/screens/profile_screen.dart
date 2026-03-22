import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/features/GAMER/profile/screens/dashboard_widgets.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/lootbox_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/overview_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/system_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/wallet_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(profileTabIndexProvider);
    final userProfileAsync = ref.watch(userProfileProvider); // Lấy tên thật từ provider

    return Column(
      children: [
        Container(
          color: AppTheme.surfaceDark,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              children: [
                _avataHeader(context, userProfileAsync),
                const SizedBox(height: 24),
                CagPrimaryButton(
                  text: "FIND MATCH",
                  onPressed: () {},
                  backgroundColor: Colors.transparent,
                  textColor: AppTheme.cyanNeon,
                  isBorder: true,
                  prefixIcon: Icons.search,
                  height: 50,
                  borderRadius: 5,
                  boderColor: AppTheme.cyanNeon,
                ),
                const SizedBox(height: 24),
                const CustomTabBar(),
              ],
            ),
          ),
        ),

        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: const [
              OverViewTab(),
              WalletTab(),
              LootBoxTab(),
              SystemTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _avataHeader(BuildContext context, AsyncValue userProfileAsync) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatarStack(),
        const SizedBox(width: 32),
        Expanded(
          child: userProfileAsync.when(
            data: (user) => _buildUserInfo(user.fullName),
            loading: () => const CircularProgressIndicator(color: AppTheme.cyanNeon),
            error: (_, __) => _buildUserInfo("Lương Quang Vinh"),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 70, height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.statsBlue, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const Center(child: Icon(Icons.person, size: 40, color: Colors.white54)),
          ),
        ),
        Positioned(
          bottom: -6, right: -10,
          child: _buildBadge('LVL.8', color: AppTheme.statsBlue, isLevel: true),
        ),
      ],
    );
  }

  Widget _buildUserInfo(String fullName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullName,
          style: GoogleFonts.rajdhani(color: AppTheme.textWhite, fontSize: 26, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text('ID: #LUONGVINH3969', style: GoogleFonts.rajdhani(color: AppTheme.textDim, fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildBadge('DIAMOND'),
            const SizedBox(width: 16),
            Container(width: 2, height: 12, color: AppTheme.borderButton),
            const SizedBox(width: 16),
            const Icon(Icons.circle, size: 6, color: AppTheme.statsOrange),
            const SizedBox(width: 6),
            Text('8,888 PTS', style: GoogleFonts.rajdhani(color: AppTheme.statsOrange, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(String label, {Color color = Colors.white70, bool isLevel = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isLevel ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isLevel ? color : AppTheme.borderWhite),
      ),
      child: Text(label, style: GoogleFonts.rajdhani(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}