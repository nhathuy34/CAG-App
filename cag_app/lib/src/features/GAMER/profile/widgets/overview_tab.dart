import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OverViewTab extends ConsumerWidget {
  const OverViewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return statsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.cyanNeon),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (stats) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            _buildPerformanceCard(stats),
            const SizedBox(height: 16),

            _buildAccessPassCard(stats),
            const SizedBox(height: 16),
            
            const SystemLogsCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard(GamerStats stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PERFORMANCE STATS', style: _headerStyle),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _statItem(
                  'TRUST SCORE',
                  stats.trustScore,
                  AppTheme.statsGreen,
                ),
              ),

              Expanded(
                child: _statItem(
                  'HOURS PLAYED',
                  stats.hoursPlayed,
                  AppTheme.textWhite,
                  suffix: 'h',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _statItem(
                  'WIN RATE',
                  stats.winRate,
                  AppTheme.statsBlue,
                  suffix: '%',
                ),
              ),

              Expanded(
                child: _statItem(
                  'BALANCE',
                  stats.balance,
                  AppTheme.statsOrange,
                  suffix: ' VND',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Color color, {String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: AppTheme.textDim,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: GoogleFonts.rajdhani(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),

              if (suffix != null)
                TextSpan(
                  text: suffix,
                  style: GoogleFonts.rajdhani(
                    color: AppTheme.textDim,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccessPassCard(GamerStats stats) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppTheme.textWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: DotPainter())),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ACCESS_PASS',
                      style: GoogleFonts.rajdhani(
                        color: AppTheme.textBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    Text(
                      'CAG NETWORK VERIFIED',
                      style: GoogleFonts.rajdhani(
                        color: Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _passInfo('ID:', stats.accessId),
                        _passInfo('EXP:', 'LIFETIME'),
                        _passInfo('SEC:', 'LEVEL 4'),
                      ],
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.textBlack,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        'C',
                        style: TextStyle(
                          color: AppTheme.textBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.qr_code_2,
                      size: 80,
                      color: AppTheme.textBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _passInfo(String l, String v) => Row(
    children: [
      Text(
        l,
        style: GoogleFonts.ibmPlexMono(color: Colors.black54, fontSize: 10),
      ),
      const SizedBox(width: 8),
      Text(
        v,
        style: GoogleFonts.ibmPlexMono(
          color: AppTheme.textBlack,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: const Color(0xFF131A28),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.05)),
  );

  static final _headerStyle = GoogleFonts.rajdhani(
    color: AppTheme.textDim,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );
}

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black12;
    for (double i = 0; i < size.width; i += 10) {
      for (double j = 0; j < size.height; j += 10) {
        canvas.drawCircle(Offset(i, j), 1, p);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}

// ĐỪNG BỎ PHẦN COMAND NÀY
// import 'package:CAG_App/src/features/provider/profile_provider.dart';
// import 'package:CAG_App/src/models/gamerStats.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class OverViewTab extends ConsumerWidget {
//   const OverViewTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final statsAsync = ref.watch(userStatsProvider);
//
//     return statsAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF00C4FF))),
//       error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
//       data: (stats) => SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         child: Column(
//           children: [
//             PerformanceStatsCard(stats: stats),
//             const SizedBox(height: 16),
//             AccessPassCard(stats: stats),
//             const SizedBox(height: 16),
//             const SystemLogsCard(),
//             const SizedBox(height: 150),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PerformanceStatsCard extends StatelessWidget {
//   final GamerStats stats;
//   const PerformanceStatsCard({super.key, required this.stats});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: CardStyles.mainCardDecoration,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.bar_chart, color: Colors.white38, size: 18),
//               const SizedBox(width: 8),
//               Text('PERFORMANCE STATS', style: CardStyles.headerStyle),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _buildGrid(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGrid() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(child: _statItem('TRUST SCORE', stats.trustScore, const Color(0xFF00FF66))),
//             Expanded(child: _statItem('HOURS PLAYED', stats.hoursPlayed, Colors.white, suffix: 'h')),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             Expanded(child: _statItem('WIN RATE', stats.winRate, const Color(0xFF00C4FF), suffix: '%')),
//             Expanded(child: _statItem('BALANCE', stats.balance, const Color(0xFFFFB800), suffix: ' VND')),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _statItem(String label, String value, Color color, {String? suffix}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.rajdhani(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold)),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(text: value, style: GoogleFonts.rajdhani(color: color, fontSize: 24, fontWeight: FontWeight.w800)),
//               if (suffix != null)
//                 TextSpan(text: suffix, style: GoogleFonts.rajdhani(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AccessPassCard extends StatelessWidget {
//   final GamerStats stats;
//   const AccessPassCard({super.key, required this.stats});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 190,
//       decoration: CardStyles.lightCardDecoration,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Stack(
//           children: [
//             Positioned.fill(child: CustomPaint(painter: _DotPatternPainter())),
//             Padding(
//               padding: const EdgeInsets.all(24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('ACCESS_PASS', style: GoogleFonts.rajdhani(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
//                       Text('CAG NETWORK VERIFIED', style: GoogleFonts.rajdhani(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold)),
//                       const Spacer(),
//                       _passDetail('ID:', stats.accessId),
//                       _passDetail('EXP:', 'LIFETIME'),
//                       _passDetail('SEC:', 'LEVEL 4'),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1.5)),
//                         child: const Text('C', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                       ),
//                       const Icon(Icons.qr_code_2, size: 75, color: Colors.black),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _passDetail(String label, String value) {
//     return Row(
//       children: [
//         Text(label, style: GoogleFonts.ibmPlexMono(color: Colors.black54, fontSize: 10)),
//         const SizedBox(width: 8),
//         Text(value, style: GoogleFonts.ibmPlexMono(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }
// }

class CardStyles {
  static BoxDecoration mainCardDecoration = BoxDecoration(
    color: const Color(0xFF131A28),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.08)),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1A304D), Color(0xFF131A28)],
    ),
  );

  static BoxDecoration lightCardDecoration = BoxDecoration(
    color: const Color(0xFFF2F2F2),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static TextStyle headerStyle = GoogleFonts.rajdhani(
    color: Colors.white38,
    fontSize: 13,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );
}

// ĐỪNG BỎ PHẦN COMAND NÀY
// class _DotPatternPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.black.withOpacity(0.05);
//     for (double x = 0; x < size.width; x += 12) {
//       for (double y = 0; y < size.height; y += 12) {
//         canvas.drawCircle(Offset(x, y), 1, paint);
//       }
//     }
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

class SystemLogsCard extends StatelessWidget {
  const SystemLogsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: CardStyles.mainCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SYSTEM LOGS (TRANSACTIONS)', style: CardStyles.headerStyle),
          const SizedBox(height: 20),
          _logRow('2026-03-18', 'TOPUP', '+500,000', const Color(0xFF00C4FF)),
          const Divider(color: Colors.white10, height: 24),
          _logRow('2026-03-17', 'PAYMENT', '-50,000', const Color(0xFFFF4D4D)),
          const Divider(color: Colors.white10, height: 24),
          _logRow('2026-03-16', 'EARNING', '+150,000', const Color(0xFF00FF66)),
        ],
      ),
    );
  }

  Widget _logRow(String date, String type, String amount, Color typeColor) {
    final style = GoogleFonts.ibmPlexMono(fontSize: 11);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style: style.copyWith(color: Colors.white38)),
        Text(
          type,
          style: style.copyWith(color: typeColor, fontWeight: FontWeight.bold),
        ),
        Text(
          amount,
          style: style.copyWith(color: typeColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
