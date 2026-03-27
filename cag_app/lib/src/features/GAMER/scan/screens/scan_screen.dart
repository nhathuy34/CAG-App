// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:CAG_App/src/features/GAMER/scan/providers/scan_provider.dart';
// import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
// import '../widgets/scanner_area.dart'; // Đảm bảo import đúng file ScannerArea của ông
//
// class ScanScreen extends ConsumerStatefulWidget {
//   const ScanScreen({super.key});
//
//   @override
//   ConsumerState<ScanScreen> createState() => _ScanScreenState();
// }
//
// class _ScanScreenState extends ConsumerState<ScanScreen> {
//   late MobileScannerController _scannerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _scannerController = MobileScannerController(
//       detectionSpeed: DetectionSpeed.noDuplicates,
//     );
//   }
//
//   @override
//   void dispose() {
//     _scannerController.dispose();
//     super.dispose();
//   }
//
//   // Hàm xử lý kết quả quét
//   void _processScan(String code) {
//     ref.read(scanProvider.notifier).processScannedCode(code, type: 'QR_CODE');
//   }
//
//   // Hàm mô phỏng quét thành công để test logic
//   // void _mockScanSuccess() {
//   //   _processScan('MOCK_QR_CODE_123');
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final scanState = ref.watch(scanProvider);
//     final isLoading = scanState.isLoading;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: _scannerController,
//             onDetect: (capture) {
//               if (isLoading) return;
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null) {
//                   _processScan(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
//           // 2. LỚP PHỦ ĐEN ĐỤC LỖ
//           CustomPaint(size: Size.infinite, painter: _ScannerOverlayPainter()),
//
//           Center(child: ScannerArea(isLoading: isLoading)),
//
//           SafeArea(
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 20,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             ref.read(navIndexProvider.notifier).state = 0;
//                           },
//                           icon: const Icon(
//                             Icons.close,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//
//                         Text(
//                           'SCANNER',
//                           style: GoogleFonts.rajdhani(
//                             color: const Color(0xFF00F2EA),
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 6,
//                           ),
//                         ),
//                         const SizedBox(width: 48),
//                       ],
//                     ),
//                   ),
//
//                   // Text dưới khung quét
//                   Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 400 + 48),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             isLoading
//                                 ? 'ĐANG QUÉT MÃ...'
//                                 : 'SYSTEM SCANNING...',
//                             style: const TextStyle(
//                               color: Color(0xFF00F2EA),
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 4,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             isLoading
//                                 ? 'PROCESSING'
//                                 : 'ALIGN QR CODE WITHIN FRAME',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.4),
//                               fontSize: 11,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // NÚT CANCEL
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 30),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         ref.read(navIndexProvider.notifier).state =
//                             0; // Về Home
//                       },
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: Colors.white.withOpacity(0.3)),
//                         minimumSize: const Size(150, 45),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       child: Text(
//                         'CANCEL',
//                         style: GoogleFonts.rajdhani(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Painter: Lớp phủ đen có đục lỗ ở giữa ──
// class _ScannerOverlayPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = const Color(0xFF0B0E14).withOpacity(0.85);
//
//     // Center của ScannerArea thay đổi nhẹ vì SafeArea có AppBar top/bottom, nhưng xấp xỉ khoảng trung tâm
//     final center = Offset(size.width / 2, size.height / 2);
//
//     final path = Path()
//       ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromCenter(center: center, width: 280, height: 280),
//           const Radius.circular(0),
//         ),
//       )
//       ..fillType = PathFillType.evenOdd;
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:CAG_App/src/features/GAMER/scan/providers/scan_provider.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import '../widgets/scanner_area.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanProvider);
    final isLoading = scanState.isLoading;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera nền
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              if (isLoading) return;
              final barcode = capture.barcodes.first;
              if (barcode.rawValue != null) {
                ref
                    .read(scanProvider.notifier)
                    .processScannedCode(barcode.rawValue!);
              }
            },
          ),
          // 2. LỚP PHỦ ĐEN ĐỤC LỖ
          Positioned.fill(
            child: CustomPaint(painter: _ScannerOverlayPainter()),
          ),

          // 3. Khung quét phát sáng ở giữa
          Center(child: ScannerArea(isLoading: isLoading)),

          // 4. UI Overlay (Text & Nút) - ĐÃ FIX LỆCH TRUNG TÂM
          SafeArea(
            child: SizedBox(
              width: double
                  .infinity, // <--- CÁI NÀY GIÚP ÉP TẤT CẢ RA GIỮA MÀN HÌNH
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // HEADER: Có dấu X và chữ SCANNER ở giữa
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // DẤU X ĐÂY RỒI
                        IconButton(
                          onPressed: () {
                            ref.read(navIndexProvider.notifier).state = 0;
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        // CHỮ SCANNER TRUNG TÂM
                        Text(
                          'SCANNER',
                          style: GoogleFonts.rajdhani(
                            color: const Color(0xFF00F2EA),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6,
                          ),
                        ),
                        // Cục SizedBox 48px này để cân bằng với cái IconButton (có kích thước 48px),
                        // giúp chữ SCANNER nằm đúng tâm màn hình
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  const Spacer(), // Đẩy phần chữ xuống dưới khung quét
                  // TEXT HƯỚNG DẪN
                  Text(
                    isLoading ? 'SYSTEM SCANNING...' : 'SYSTEM READY',
                    style: GoogleFonts.rajdhani(
                      color: const Color(0xFF00F2EA),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ALIGN QR CODE WITHIN FRAME',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // NÚT CANCEL
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(navIndexProvider.notifier).state =
                            0; // Về Home
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white.withOpacity(0.3)),
                        minimumSize: const Size(150, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PAINTER ĐỤC LỖ MÀN HÌNH
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.85);
    final center = Offset(size.width / 2, size.height / 2);

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 280, height: 280),
          const Radius.circular(40),
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
