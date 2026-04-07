import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/features/GAMER/profile/screens/dashboard_widgets.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/lootbox_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/overview_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/system_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/widgets/wallet_tab.dart';
import 'package:CAG_App/src/models/user_model.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(profileTabIndexProvider);
    final userProfileAsync = ref.watch(userProfileProvider);


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
                  text: "SCAN QR",
                  prefixIcon: Icons.qr_code_scanner, 
                  onPressed: () {
                    // Chuyển Tab chính sang trang Scan
                   ref.read(navIndexProvider.notifier).setIndex(2);
                  },
                  backgroundColor: Colors.transparent, 
                  textColor: AppTheme.gold,           
                  isBorder: true,                     
                  boderColor: AppTheme.gold,           
                  height: 50,
                  borderRadius: 5,
                ),
                
                const SizedBox(height: 16),

                // --- NÚT FIND MATCH ---
                CagPrimaryButton(
                  text: "FIND MATCH",
                  onPressed: () {
                    ref.read(navIndexProvider.notifier).setIndex(3);
                  },
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

  

  // --- WIDGET HEADER ---
  Widget _avataHeader(BuildContext context, AsyncValue<Usermodel> userProfileAsync) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatarStack(userProfileAsync),
        const SizedBox(width: 32),
        Expanded(
          child: userProfileAsync.when(
            data: (user) => _buildUserInfo(user.username , user.id.toString()), 
            loading: () => const CircularProgressIndicator(color: AppTheme.cyanNeon),
            error: (err, stack) => _buildUserInfo("Lỗi tải dữ liệu", "N/A"),
          ),
        ),
      ],
    );
  }


  Widget _buildAvatarStack(AsyncValue<Usermodel> userProfileAsync) {
    // 1. Bóc tách URL từ AsyncValue
    final String? avatarUrl = userProfileAsync.when(
      data: (user) => user.avatarUrl,
      loading: () => null,
      error: (err, stack) => null,
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.cyanNeon, width: 2),
          ),
          // 2. Kiểm tra điều kiện: (ĐIỀU KIỆN) ? (NẾU ĐÚNG) : (NẾU SAI)
          child: (avatarUrl != null && avatarUrl.isNotEmpty)
              ? ClipRRect( // Nên dùng ClipRRect để bo góc ảnh cho đẹp
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    '$avatarUrl?t=${DateTime.now().millisecondsSinceEpoch}',
                    fit: BoxFit.cover,
                    key: ValueKey(avatarUrl),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2, 
                          color: AppTheme.cyanNeon
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.person, size: 40, color: Colors.white54),
                    ),
                  ),
                )
              : const Center( 
                  child: Icon(Icons.person, size: 40, color: Colors.white54),
                ),
        ),
        Positioned(
          bottom: -6,
          right: -10,
          child: _buildBadge('LVL.8', color: AppTheme.cyanNeon, isLevel: true),
        ),
      ],
    );
  }


  Widget _buildUserInfo(String fullName, String userId) { 
    String displayId = userId == "N/A" ? userId : userId.padLeft(6, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullName,
          style: GoogleFonts.rajdhani(
            color: AppTheme.textWhite, 
            fontSize: 26, 
            fontWeight: FontWeight.w700, 
            fontStyle: FontStyle.italic
          ),
          maxLines: 1, 
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        
        Text('ID: #$displayId', style: GoogleFonts.rajdhani(color: AppTheme.textDim, fontSize: 14)),
        
        const SizedBox(height: 8),
        Row(
          children: [
            _buildBadge('BRONZE'),
            const SizedBox(width: 16),
            Container(width: 2, height: 12, color: AppTheme.borderButton),
            const SizedBox(width: 16),
            const Icon(Icons.circle, size: 6, color: AppTheme.statsOrange),
            const SizedBox(width: 6),
            Text('0 PTS', style: GoogleFonts.rajdhani(color: AppTheme.statsOrange, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  // --- WIDGET BADGE CHUNG ---
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