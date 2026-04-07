import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget TabBar tuỳ chỉnh với hiệu ứng Neon
class CustomTabBar extends ConsumerWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(profileTabIndexProvider);
    final List<String> tabs = ['OVERVIEW', 'WALLET', 'LOOT BOX', 'SYSTEM'];

    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1B2436), width: 2)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutQuart,
                left: selectedIndex * tabWidth,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: CustomPaint(painter: _ParallelogramPainter()),
              ),
              Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Cập nhật trạng thái qua Riverpod
                        ref.read(profileTabIndexProvider.notifier).state =
                            index;
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: GoogleFonts.rajdhani(
                            color: isSelected
                                ? const Color(0xFF00E5FF)
                                : Colors.white54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          child: Text(tabs[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

// CustomPainter để vẽ hình bình hành Neon dưới tab đã chọn
class _ParallelogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double slant = 10.0;

    // Định nghĩa màu nền (Fill)
    final Paint fillPaint = Paint()
      ..color =
          const Color(0xFF1E283B)
      ..style = PaintingStyle.fill;

    // Định nghĩa màu viền Neon
    final Paint strokePaint = Paint()
      ..color =
          const Color(0xFF00E5FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Vẽ Path
    final Path path = Path()
      ..moveTo(slant, 0)
      ..lineTo(size.width, 0)
      ..lineTo(
        size.width - slant,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();

    // Đổ màu vào hình và vẽ viền
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
