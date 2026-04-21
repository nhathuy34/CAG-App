import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class OfficesTabView extends StatelessWidget {
  const OfficesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildOfficeCard(
          title: "SPEED GAMING 2",
          statusLabel: "CHỜ DUYỆT",
          statusColor: const Color(0xFF1E3A8A), // Màu xanh dương nhạt
          address: "123 Trần Hưng Đạo, Q.1",
          totalMachines: "80",
          software: "CAG Pro 3.0",
        ),
        const SizedBox(height: 20),
        _buildOfficeCard(
          title: "GAMING HOUSE PRO",
          statusLabel: "CẦN CẬP NHẬT",
          statusColor: const Color(0xFF1E3A8A), 
          address: "70 Lê Lai, Q.1",
          totalMachines: "100",
          software: "CAG Pro 3.0",
          note: "Ghi chú: Cần cập nhật hình ảnh không gian quán.",
        ),
      ],
    );
  }

  Widget _buildOfficeCard({
    required String title,
    required String statusLabel,
    required Color statusColor,
    required String address,
    required String totalMachines,
    required String software,
    String? note,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Phần nội dung (Bên trái)
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(statusLabel, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address,
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  
                  // Blocks thông tin
                  Row(
                    children: [
                      Expanded(child: _infoBlock("Tổng máy", totalMachines)),
                      const SizedBox(width: 15),
                      Expanded(child: _infoBlock("Phần mềm", software, isHighlight: true)),
                    ],
                  ),
                  
                  // Nếu có ghi chú
                  if (note != null) ...[
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(text: "Ghi chú: ", style: TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold)),
                            TextSpan(text: note.replaceFirst("Ghi chú: ", ""), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ]
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),

          // Phần buttons (Bên phải)
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.white10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton("DUYỆT QUÁN", Colors.green, Colors.white),
                  const SizedBox(height: 15),
                  _actionButton("YÊU CẦU SỬA", Colors.white12, Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBlock(String label, String value, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 5),
          Text(
            value, 
            style: TextStyle(
              color: isHighlight ? AppTheme.cyanNeon : Colors.white, 
              fontSize: 16, 
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {},
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
