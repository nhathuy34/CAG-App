import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/screen/dashboard_widgets.dart';
import 'package:CAG_App/src/features/GAMER/profile/tabpage/lootbox_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/tabpage/overview_tab.dart';
import 'package:CAG_App/src/features/GAMER/profile/tabpage/wallet_tab.dart';
import 'package:CAG_App/src/features/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(profileTabIndexProvider);

    return Column(
      children: [
        // Phần Header cố định phía trên
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        //   child: Column(
        //     children: [
        //       _avataHeader(context),
        //       const SizedBox(height: 24),
        //       CagPrimaryButton(
        //         text: "FIND MATCH",
        //         onPressed: () {},
        //         backgroundColor: Colors.transparent,
        //         textColor: AppTheme.cyanNeon,
        //         isBorder: true,
        //         prefixIcon: Icons.search,
        //         height: 50,
        //         borderRadius: 5,
        //         boderColor: AppTheme.cyanNeon,
        //       ),
        //       const SizedBox(height: 24),
        //       const CustomTabBar(),
        //     ],
        //   ),
        // ),
        Container(
          color: const Color(0xFF050919), // Thêm màu nền #050919 tại đây
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              children: [
                _avataHeader(context),
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

        // Phần nội dung Tab - Tự động đo theo không gian còn lại
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: const [
              OverViewTab(), // Bên trong file này sẽ có SingleChildScrollView
              WalletTab(),
              LootBoxTab(),
              Center(child: Text("Logs")),
            ],
          ),
        ),
      ],
    );
  }

  // Các hàm helper UI di chuyển vào trong class State
  Widget _avataHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatarStack(),
        const SizedBox(width: 32),
        _buildUserInfo(),
      ],
    );
  }

  Widget _buildAvatarStack() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF007BFF), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const Center(
              child: Icon(Icons.person, size: 40, color: Colors.white54),
            ),
          ),
        ),
        Positioned(
          bottom: -6,
          right: -10,
          child: _buildBadge(
            'LVL.8',
            color: const Color(0xFF00A3FF),
            isLevel: true,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lương Quang Vinh",
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ID: #LUONGVINH3969',
            style: GoogleFonts.rajdhani(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildBadge('DIAMOND'),
              const SizedBox(width: 16),
              Container(width: 2, height: 12, color: Colors.white24),
              const SizedBox(width: 16),
              const Icon(Icons.circle, size: 6, color: Color(0xFFFFB800)),
              const SizedBox(width: 6),
              Text(
                '8,888 PTS',
                style: GoogleFonts.rajdhani(
                  color: const Color(0xFFFFB800),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    String label, {
    Color color = Colors.white70,
    bool isLevel = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isLevel ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isLevel ? color : Colors.white24),
      ),
      child: Text(
        label,
        style: GoogleFonts.rajdhani(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
