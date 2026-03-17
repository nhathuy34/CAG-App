import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double size;
  final bool isGlowing;

  const SvgIcon({
    super.key,
    required this.assetPath,
    this.color = Colors.white,
    this.size = 24.0,
    this.isGlowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isGlowing
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 15, // Tăng độ nhòe cho đẹp
                  spreadRadius: 2,
                ),
              ],
            )
          : null,
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
class _SvgPathPainter extends CustomPainter {
  final String pathData;
  final Color color;

  _SvgPathPainter({required this.pathData, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Parser đơn giản để vẽ SVG path. 
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.scale(size.width / 24, size.height / 24);

    // Dữ liệu Path SVG copy từ web:
    // M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z
    
    final path = Path();
    
    // M9 12
    path.moveTo(9, 12);
    // l2 2
    path.lineTo(11, 14);
    // 4-4
    path.lineTo(15, 10);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CagIcons {
  static const String shieldTick = 'assets/icons/ic_cag_guide.svg';
  static const String community = 'assets/icons/ic_community.svg';
  // ...
}