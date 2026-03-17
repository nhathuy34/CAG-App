import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
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
                child: Image.network(
                  userAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF1E2638),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -6,
              right: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF00A3FF)),
                ),
                child: Text(
                  'LVL.8',
                  style: GoogleFonts.rajdhani(
                    color: const Color(0xFF00A3FF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'ID:',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '#LUONGVINH3969',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      'DIAMOND',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(width: 2, height: 12, color: Colors.white24),
                  const SizedBox(width: 16),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB800),
                      shape: BoxShape.circle,
                    ),
                  ),
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
        ),
      ],
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic, 
                left: selectedIndex * tabWidth,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: CustomPaint(
                  painter: _ParallelogramPainter(),
                ),
              ),

              Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTabChanged(index),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
    
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: GoogleFonts.rajdhani(
                            color: isSelected
                                ? const Color(0xFF00E5FF)
                                : Colors.white54,
                            fontSize: 13,
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

class _ParallelogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double slant = 14.0; 
    final Paint fillPaint = Paint()
      ..color = const Color(0xFF1E283B) // Màu nền của tab
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = const Color(0xFF00E5FF) // Màu viền neon sáng
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Vẽ khối hình bình hành (chéo cả 2 bên / /)
    final Path path = Path()
      ..moveTo(slant, 0) // Đỉnh trên - trái (thụt vào một chút)
      ..lineTo(size.width, 0) // Đỉnh trên - phải
      ..lineTo(size.width - slant, size.height) // Đỉnh dưới - phải (thụt vào)
      ..lineTo(0, size.height) // Đỉnh dưới - trái
      ..close();

    canvas.drawPath(path, fillPaint);

    // Vẽ đường viền neon (Chỉ vẽ 3 cạnh: Trái, Trên, Phải - hở cạnh Dưới)
    final Path borderPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(slant, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - slant, size.height);

    canvas.drawPath(borderPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FindMatchButton extends StatelessWidget {
  const FindMatchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF19376D)),
      ),
      child: Center(
        child: Text(
          'FIND MATCH',
          style: GoogleFonts.rajdhani(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

