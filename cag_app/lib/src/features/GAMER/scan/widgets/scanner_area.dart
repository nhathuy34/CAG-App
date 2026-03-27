// import 'package:flutter/material.dart';
//
// class ScannerArea extends StatefulWidget {
//   final bool isLoading;
//
//   const ScannerArea({
//     super.key,
//     required this.isLoading,
//   });
//
//   @override
//   State<ScannerArea> createState() => _ScannerAreaState();
// }
//
// class _ScannerAreaState extends State<ScannerArea> with TickerProviderStateMixin {
//   late AnimationController _scanLineController;
//   late AnimationController _pulseController;
//
//   @override
//   void initState() {
//     super.initState();
//     _scanLineController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _scanLineController.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 280,
//       height: 280,
//       child: Stack(
//         children: [
//           // Viền xung nhấp nháy
//           AnimatedBuilder(
//             animation: _pulseController,
//             builder: (context, child) {
//               final opacity = 0.6 + (_pulseController.value * 0.4);
//               return CustomPaint(
//                 size: const Size(280, 280),
//                 painter: _CornerBracketsPainter(
//                   color: const Color(0xFF00F2EA).withOpacity(opacity),
//                   cornerLength: 40,
//                   strokeWidth: 3,
//                 ),
//               );
//             },
//           ),
//
//           // Đường quét
//           if (!widget.isLoading)
//             AnimatedBuilder(
//               animation: _scanLineController,
//               builder: (context, child) {
//                 return Positioned(
//                   top: 10 + (_scanLineController.value * 260),
//                   left: 10,
//                   right: 10,
//                   child: Container(
//                     height: 2,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.transparent,
//                           const Color(0xFF00F2EA).withOpacity(0.8),
//                           const Color(0xFF00F2EA),
//                           const Color(0xFF00F2EA).withOpacity(0.8),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFF00F2EA).withOpacity(0.5),
//                           blurRadius: 12,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//           CustomPaint(
//             size: const Size(280, 280),
//             painter: _GridLinesPainter(),
//           ),
//
//           if (widget.isLoading)
//             const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF00F2EA),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Painter: 4 góc viền ──
// class _CornerBracketsPainter extends CustomPainter {
//   final Color color;
//   final double cornerLength;
//   final double strokeWidth;
//
//   _CornerBracketsPainter({
//     required this.color,
//     required this.cornerLength,
//     required this.strokeWidth,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;
//
//     final w = size.width;
//     final h = size.height;
//     final cl = cornerLength;
//
//     canvas.drawLine(Offset(0, cl), const Offset(0, 0), paint);
//     canvas.drawLine(const Offset(0, 0), Offset(cl, 0), paint);
//
//     canvas.drawLine(Offset(w - cl, 0), Offset(w, 0), paint);
//     canvas.drawLine(Offset(w, 0), Offset(w, cl), paint);
//
//     canvas.drawLine(Offset(0, h - cl), Offset(0, h), paint);
//     canvas.drawLine(Offset(0, h), Offset(cl, h), paint);
//
//     canvas.drawLine(Offset(w, h - cl), Offset(w, h), paint);
//     canvas.drawLine(Offset(w, h), Offset(w - cl, h), paint);
//
//     // Glow
//     final glowPaint = Paint()
//       ..color = color.withOpacity(0.3)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth + 4
//       ..strokeCap = StrokeCap.round
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
//
//     canvas.drawLine(Offset(0, cl), const Offset(0, 0), glowPaint);
//     canvas.drawLine(const Offset(0, 0), Offset(cl, 0), glowPaint);
//     canvas.drawLine(Offset(w - cl, 0), Offset(w, 0), glowPaint);
//     canvas.drawLine(Offset(w, 0), Offset(w, cl), glowPaint);
//     canvas.drawLine(Offset(0, h - cl), Offset(0, h), glowPaint);
//     canvas.drawLine(Offset(0, h), Offset(cl, h), glowPaint);
//     canvas.drawLine(Offset(w, h - cl), Offset(w, h), glowPaint);
//     canvas.drawLine(Offset(w, h), Offset(w - cl, h), glowPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// // ── Painter: Grid lines mờ ──
// class _GridLinesPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF00F2EA).withOpacity(0.06)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5;
//
//     const divisions = 6;
//     for (int i = 1; i < divisions; i++) {
//       final x = size.width * i / divisions;
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }
//     for (int i = 1; i < divisions; i++) {
//       final y = size.height * i / divisions;
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
import 'package:flutter/material.dart';

class ScannerArea extends StatefulWidget {
  final bool isLoading;

  const ScannerArea({super.key, required this.isLoading});

  @override
  State<ScannerArea> createState() => _ScannerAreaState();
}

class _ScannerAreaState extends State<ScannerArea>
    with SingleTickerProviderStateMixin {
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
                left: 10, // Kéo dài vệt sáng sát viền hơn
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

// ── Painter: 4 góc viền ──
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

// ── Painter: Grid lines mờ ──
class _CornerBracketsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;

    final double margin =
        20; // Chỉnh từ 40 xuống 20 để ôm sát viền giống ảnh mẫu
    final double len = 25; // Độ dài của cạnh góc L

    // Góc trên bên trái
    canvas.drawPath(
      Path()
        ..moveTo(margin, margin + len)
        ..lineTo(margin, margin)
        ..lineTo(margin + len, margin),
      paint,
    );

    // Góc trên bên phải
    canvas.drawPath(
      Path()
        ..moveTo(size.width - margin - len, margin)
        ..lineTo(size.width - margin, margin)
        ..lineTo(size.width - margin, margin + len),
      paint,
    );

    // Góc dưới bên trái
    canvas.drawPath(
      Path()
        ..moveTo(margin, size.height - margin - len)
        ..lineTo(margin, size.height - margin)
        ..lineTo(margin + len, size.height - margin),
      paint,
    );

    // Góc dưới bên phải
    canvas.drawPath(
      Path()
        ..moveTo(size.width - margin - len, size.height - margin)
        ..lineTo(size.width - margin, size.height - margin)
        ..lineTo(size.width - margin, size.height - margin - len),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
