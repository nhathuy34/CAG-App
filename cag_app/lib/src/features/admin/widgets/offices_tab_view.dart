import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class OfficesTabView extends StatelessWidget {
  const OfficesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ListView(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      children: [
        _buildOfficeCard(
          screenWidth,
          title: "SPEED GAMING 2",
          statusLabel: "CHỜ DUYỆT",
          statusColor: const Color(0xFF1E3A8A), // Màu xanh dương nhạt
          address: "123 Trần Hưng Đạo, Q.1",
          totalMachines: "80",
          software: "CAG Pro 3.0",
        ),
        SizedBox(height: screenWidth * 0.05),
        _buildOfficeCard(
          screenWidth,
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

  Widget _buildOfficeCard(
    double screenWidth, {
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
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Phần nội dung (Bên trái)
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.035),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenWidth * 0.01),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        ),
                        child: Text(statusLabel, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.028, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    address,
                    style: TextStyle(color: Colors.white54, fontSize: screenWidth * 0.035),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  
                  // Blocks thông tin
                  Row(
                    children: [
                      Expanded(child: _infoBlock(screenWidth, "Tổng máy", totalMachines)),
                      SizedBox(width: screenWidth * 0.035),
                      Expanded(child: _infoBlock(screenWidth, "Phần mềm", software, isHighlight: true)),
                    ],
                  ),
                  
                  // Nếu có ghi chú
                  if (note != null) ...[
                    SizedBox(height: screenWidth * 0.035),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Ghi chú: ", style: TextStyle(color: AppTheme.gold, fontSize: screenWidth * 0.032, fontWeight: FontWeight.bold)),
                            TextSpan(text: note.replaceFirst("Ghi chú: ", ""), style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.032)),
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
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05, horizontal: screenWidth * 0.02),
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.white10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(screenWidth, "DUYỆT QUÁN", Colors.green, Colors.white),
                  SizedBox(height: screenWidth * 0.035),
                  _actionButton(screenWidth, "YÊU CẦU SỬA", Colors.white12, Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBlock(double screenWidth, String label, String value, {bool isHighlight = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white54, fontSize: screenWidth * 0.032)),
          SizedBox(height: screenWidth * 0.012),
          Text(
            value, 
            style: TextStyle(
              color: isHighlight ? AppTheme.cyanNeon : Colors.white, 
              fontSize: screenWidth * 0.045, 
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(double screenWidth, String label, Color bgColor, Color textColor) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(screenWidth * 0.015),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.035),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.015),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: screenWidth * 0.032, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
