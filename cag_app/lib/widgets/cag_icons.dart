import 'package:flutter/material.dart';

class SvgIcon extends StatelessWidget {
  final String svgPath;
  final Color color;
  final double width;
  final double height;
  final bool isGlowing;

  const SvgIcon({
    super.key,
    required this.svgPath,
    this.color = Colors.white,
    this.width = 24.0,
    this.height = 24.0,
    this.isGlowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: isGlowing
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            )
          : null,
      child: CustomPaint(
        painter: _SvgPathPainter(
          pathData: svgPath,
          color: color,
        ),
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

    // Scale canvas to match the 24x24 viewBox of the SVG
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

// BỘ CÁC ICON SVG ĐÃ EXTRACT TỪ WEB
class CagIcons {
  // Icon Shield Tick (CAG Guide) - Lấy từ Inspect Element trong ảnh
  static const String shieldTick = '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="transition-all duration-300 text-[#00F2EA] drop-shadow-[0_0_8px_rgba(0,242,234,0.8)]"><path d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path></svg>''';
}
