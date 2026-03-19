
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  late AnimationController _scanLineController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                  const Text(
                    'SCANNER',
                    style: TextStyle(
                      color: Color(0xFF00F2EA),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const Spacer(),

            // Vùng quét
            Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final opacity = 0.6 + (_pulseController.value * 0.4);
                        return CustomPaint(
                          size: const Size(280, 280),
                          painter: _CornerBracketsPainter(
                            color: const Color(0xFF00F2EA).withOpacity(opacity),
                            cornerLength: 40,
                            strokeWidth: 3,
                          ),
                        );
                      },
                    ),

                    // Đường quét
                    AnimatedBuilder(
                      animation: _scanLineController,
                      builder: (context, child) {
                        return Positioned(
                          top: 10 + (_scanLineController.value * 260),
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF00F2EA).withOpacity(0.8),
                                  const Color(0xFF00F2EA),
                                  const Color(0xFF00F2EA).withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00F2EA).withOpacity(0.5),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    CustomPaint(
                      size: const Size(280, 280),
                      painter: _GridLinesPainter(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'S C A N N I N G . . .',
              style: TextStyle(
                color: Color(0xFF00F2EA),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'WITHIN FRAME',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),

            const Spacer(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Painter: 4 góc viền ──
class _CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double cornerLength;
  final double strokeWidth;

  _CornerBracketsPainter({
    required this.color,
    required this.cornerLength,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final cl = cornerLength;

    canvas.drawLine(Offset(0, cl), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(cl, 0), paint);

    canvas.drawLine(Offset(w - cl, 0), Offset(w, 0), paint);
    canvas.drawLine(Offset(w, 0), Offset(w, cl), paint);

    canvas.drawLine(Offset(0, h - cl), Offset(0, h), paint);
    canvas.drawLine(Offset(0, h), Offset(cl, h), paint);

    canvas.drawLine(Offset(w, h - cl), Offset(w, h), paint);
    canvas.drawLine(Offset(w, h), Offset(w - cl, h), paint);

    // Glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawLine(Offset(0, cl), const Offset(0, 0), glowPaint);
    canvas.drawLine(const Offset(0, 0), Offset(cl, 0), glowPaint);
    canvas.drawLine(Offset(w - cl, 0), Offset(w, 0), glowPaint);
    canvas.drawLine(Offset(w, 0), Offset(w, cl), glowPaint);
    canvas.drawLine(Offset(0, h - cl), Offset(0, h), glowPaint);
    canvas.drawLine(Offset(0, h), Offset(cl, h), glowPaint);
    canvas.drawLine(Offset(w, h - cl), Offset(w, h), glowPaint);
    canvas.drawLine(Offset(w, h), Offset(w - cl, h), glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ── Painter: Grid lines mờ ──
class _GridLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2EA).withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const divisions = 6;
    for (int i = 1; i < divisions; i++) {
      final x = size.width * i / divisions;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (int i = 1; i < divisions; i++) {
      final y = size.height * i / divisions;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
