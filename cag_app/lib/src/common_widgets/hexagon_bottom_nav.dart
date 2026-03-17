import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HexagonBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HexagonBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<HexagonBottomNav> createState() => _HexagonBottomNavState();
}

class _HexagonBottomNavState extends State<HexagonBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, 'assets/icons/ic_community.svg', 'Cộng Đồng'),
              _buildNavItem(1, 'assets/icons/ic_cloud_save.svg', 'Cloud Save'),
              const SizedBox(width: 72),
              _buildNavItem(3, 'assets/icons/ic_cag_guide.svg', 'CAG Guide'),
              _buildNavItem(4, 'assets/icons/ic_profile.svg', 'Profile'),
            ],
          ),

          // Nút Hexagon giữa — nổi lên trên 24px (tương đương -top-6 trong CSS)
          Positioned(
            top: -24,
            child: GestureDetector(
              onTap: () => widget.onTap(2),
              child: _buildHexagonCenterButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String svgAsset, String label) {
    final isSelected = widget.currentIndex == index;
    final color = isSelected ? const Color(0xFF00F2EA) : const Color(0xFF94A3B8);

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgAsset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Nút Hexagon giữa
  Widget _buildHexagonCenterButton() {
    return Container(
      width: 64, // w-16 = 4rem = 64px
      height: 64, // h-16 = 4rem = 64px
      decoration: BoxDecoration(
        // shadow-[0_0_20px_rgba(0,242,234,0.3)]
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F2EA).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0B0E14), // bg-[#0B0E14]
          ),
          child: CustomPaint(
            // Vẽ viền hexagon border-2 border-[#00F2EA]
            painter: _HexagonBorderPainter(
              borderColor: const Color(0xFF00F2EA),
              borderWidth: 4.0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Lớp phủ bg-[#00F2EA]/10
                Container(
                  color: const Color(0xFF00F2EA).withOpacity(0.1),
                ),

                // Icon target (tĩnh: 2 vòng tròn + 2 vạch trên dưới)
                SvgPicture.asset(
                  'assets/icons/ic_center_target.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF00F2EA),
                    BlendMode.srcIn,
                  ),
                ),

                // Kim quay — animate-[spin_3s_linear_infinite]
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * math.pi,
                      child: CustomPaint(
                        size: const Size(28, 28),
                        painter: _NeedlePainter(
                          color: const Color(0xFF00F2EA),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Cắt hình lục giác (giống clip-path-hexagon trong CSS) ──
class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Hexagon chuẩn: 6 đỉnh đều nhau
    // Giống CSS: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%)
    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ── Vẽ viền hexagon (border-2 border-[#00F2EA]) ──
class _HexagonBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;

  _HexagonBorderPainter({required this.borderColor, required this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeJoin = StrokeJoin.miter;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.25)
      ..lineTo(w, h * 0.75)
      ..lineTo(w * 0.5, h)
      ..lineTo(0, h * 0.75)
      ..lineTo(0, h * 0.25)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Kim quay (path d="M12 12 L17 7") ──
class _NeedlePainter extends CustomPainter {
  final Color color;

  _NeedlePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Vẽ kim từ tâm (12,12) ra điểm (17,7) — tức là hướng lên-phải
    // Sau đó Transform.rotate sẽ xoay quanh tâm
    final needleEnd = Offset(
      center.dx + size.width * 0.18,  // ~5/28 tỉ lệ ≈ 0.18
      center.dy - size.height * 0.18,
    );
    canvas.drawLine(center, needleEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
