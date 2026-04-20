import 'package:flutter/material.dart';

class ScannerArea extends StatefulWidget {
  final bool isLoading;

  const ScannerArea({super.key, required this.isLoading});

  @override
  State<ScannerArea> createState() => _ScannerAreaState();
}

class _ScannerAreaState extends State<ScannerArea> with SingleTickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        children: [
          // 1. Viền bo góc Neon phát sáng
          CustomPaint(
            size: const Size(280, 280),
            painter: _CyberBorderPainter(),
          ),

          // 2. Đường quét ngang (Scan Line)
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, child) {
              // Nếu đang Loading thì để ở giữa, nếu không thì chạy lên xuống
              double topPosition = widget.isLoading 
                  ? 140 
                  : 20 + (_scanController.value * 240);
              
              return Positioned(
                top: topPosition,
                left: 10,  // Kéo dài vệt sáng sát viền hơn
                right: 10,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F2EA),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00F2EA).withOpacity(0.8),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: const Color(0xFF00F2EA).withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // 3. 4 Góc L-Bracket bên trong
          CustomPaint(
            size: const Size(280, 280),
            painter: _CornerBracketsPainter(),
          ),
        ],
      ),
    );
  }
}

class _CyberBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2EA).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final glowPaint = Paint()
      ..color = const Color(0xFF00F2EA).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(40));

    canvas.drawRRect(rrect, glowPaint);
    canvas.drawRRect(rrect, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _CornerBracketsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;

    final double margin = 20; // Chỉnh từ 40 xuống 20 để ôm sát viền giống ảnh mẫu
    final double len = 25;    // Độ dài của cạnh góc L

    // Góc trên bên trái
    canvas.drawPath(Path()
      ..moveTo(margin, margin + len)
      ..lineTo(margin, margin)
      ..lineTo(margin + len, margin), paint);

    // Góc trên bên phải
    canvas.drawPath(Path()
      ..moveTo(size.width - margin - len, margin)
      ..lineTo(size.width - margin, margin)
      ..lineTo(size.width - margin, margin + len), paint);

    // Góc dưới bên trái
    canvas.drawPath(Path()
      ..moveTo(margin, size.height - margin - len)
      ..lineTo(margin, size.height - margin)
      ..lineTo(margin + len, size.height - margin), paint);

    // Góc dưới bên phải
    canvas.drawPath(Path()
      ..moveTo(size.width - margin - len, size.height - margin)
      ..lineTo(size.width - margin, size.height - margin)
      ..lineTo(size.width - margin, size.height - margin - len), paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
