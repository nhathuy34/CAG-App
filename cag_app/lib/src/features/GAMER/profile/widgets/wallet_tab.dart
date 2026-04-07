import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/models/gamer_stats.dart';
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
              // Giữ lại Main Balance của bạn
              _buildMainBalance(stats.balance),

              const SizedBox(height: 30),
              
              // --- HEADER LINKED MEMBERSHIPS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LINKED MEMBERSHIPS',
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.textDim, // Màu xám nhạt như ảnh
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    width: 100, // Thu nhỏ nút lại cho tinh tế
                    child: CagPrimaryButton(
                      text: '+ ADD CARD',
                      onPressed: () {},
                      isBorder: true,
                      boderColor: AppTheme.cyanNeon.withOpacity(0.5),
                      textColor: AppTheme.cyanNeon,
                      height: 32,
                      fontSize: 12,
                      borderRadius: 4,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              
              // --- LIST CARDS ---
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

  // --- HÀM BUILD CARD CHUẨN THEO HÌNH ---
  Widget _buildMembershipCard(MembershipCard card) {
    // Tự động fake màu và hạng thành viên dựa theo tên quán (vì model của bạn có thể chưa có)
    Color leftStripColor = Colors.grey;
    String tierText = 'SILVER MEMBER';

    if (card.title.toUpperCase().contains('FLASH')) {
      leftStripColor = const Color(0xFFECA311); // Vàng Cam
      tierText = 'DIAMOND MEMBER';
    } else if (card.title.toUpperCase().contains('PRO')) {
      leftStripColor = const Color(0xFFE53935); // Đỏ
      tierText = 'GOLD MEMBER';
    } else {
      leftStripColor = const Color(0xFF546E7A); // Xám xanh
      tierText = 'SILVER MEMBER';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue, // Nền xanh đen
        borderRadius: BorderRadius.circular(12),
        // Viền tổng thể mờ mờ
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias, // Cắt góc để thanh màu bên trái bo tròn theo
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thanh màu bên trái
            Container(width: 5, color: leftStripColor),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Hình ảnh
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          card.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.image, color: Colors.white38),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Thông tin Tên & Mã thẻ
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  card.title,
                                  style: GoogleFonts.rajdhani(
                                    color: AppTheme.textWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Chấm xanh lá cây (Online/Active)
                              Container(
                                width: 6, height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00E676),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Chữ số thẻ dùng font Mono để cách đều nhau
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              card.number,
                              style: GoogleFonts.ibmPlexMono(
                                color: Colors.white54,
                                fontSize: 11,
                                letterSpacing: 1.5, // Giảm nhẹ khoảng cách chữ xuống một xíu cho an toàn
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(width: 8),

                    // Giá tiền & Hạng thành viên
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: card.price,
                                style: GoogleFonts.rajdhani(
                                  color: AppTheme.textWhite,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: ' VND',
                                style: GoogleFonts.rajdhani(
                                  color: Colors.white54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tierText,
                          style: GoogleFonts.ibmPlexMono(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}