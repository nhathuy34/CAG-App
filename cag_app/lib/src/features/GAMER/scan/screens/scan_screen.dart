import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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

  // Hàm xử lý kết quả quét
  void _processScan(String code) {
    ref.read(scanProvider.notifier).processScannedCode(code, type: 'QR_CODE');
  }

  // Hàm mô phỏng quét thành công để test logic
  void _mockScanSuccess() {
    _processScan('MOCK_QR_CODE_123');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(scanProvider, (previous, next) {
      next.whenOrNull(
        data: (scanData) {
          if (scanData != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Quét thành công: ${scanData.code}'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: $error'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    final scanState = ref.watch(scanProvider);
    final isLoading = scanState.isLoading;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              if (isLoading) return;
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _processScan(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          CustomPaint(
            size: Size.infinite,
            painter: _ScannerOverlayPainter(),
          ),

          Center(
            child: ScannerArea(
              isLoading: isLoading,
            ),
          ),

          SafeArea(
            child: Stack(
              children: [
                // Header góc trên
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(navIndexProvider.notifier).state = 0;
                          },
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
                ),

                // Text dưới khung quét
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 280 + 48), // Dời Text xuống dưới Khung quét 280px (140px từ tâm)
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLoading ? 'ĐANG QUÉT MÃ...' : 'SYSTEM SCANNING...',
                          style: const TextStyle(
                            color: Color(0xFF00F2EA),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isLoading ? 'PROCESSING' : 'ALIGN QR CODE WITHIN FRAME',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 11,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Nút Test (Bottom)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextButton(
                      onPressed: isLoading ? null : _mockScanSuccess,
                      child: const Text('TEST SCAN MOCK', style: TextStyle(color: Color(0xFF00F2EA))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Painter: Lớp phủ đen có đục lỗ ở giữa ──
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF0B0E14).withOpacity(0.85);

    // Center của ScannerArea thay đổi nhẹ vì SafeArea có AppBar top/bottom, nhưng xấp xỉ khoảng trung tâm
    final center = Offset(size.width / 2, size.height / 2);
    
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 280, height: 280),
        const Radius.circular(0), 
      ))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
