import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notification_providers.dart';
import '../widgets/notification_form_widgets.dart';

class ThongBaoSceen extends ConsumerWidget {
  const ThongBaoSceen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF060B13), // Nền đen sâu của toàn app
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "QUẢN LÝ THÔNG BÁO",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Rajdhani', // Nếu bạn có font này sẽ rất giống
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Gửi thông báo khuyến mãi, chăm sóc khách hàng cho hội viên của bạn.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Tabs
            Row(
              children: [
                _buildTab("Gửi Thông Báo Mới", true),
                const SizedBox(width: 30),
                _buildTab("Lịch Sử Gửi", false),
              ],
            ),
            const SizedBox(height: 2),
            Container(height: 1, color: Colors.white.withOpacity(0.05)),
            const SizedBox(height: 30),

            // Ô CÓ VIỀN BAO QUANH TOÀN BỘ FORM
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0B121E), // Màu của card hơi sáng hơn nền
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.08)), // Viền bao quanh
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          label: "Tiêu đề thông báo",
                          hint: "VD: Khuyến mãi x2 tài khoản...",
                          controller: provider.titleController,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: _buildDropdown(provider),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Box Lưu ý
                  _buildNoteBox(),
                  const SizedBox(height: 24),

                  CustomTextField(
                    label: "Nội dung chi tiết",
                    hint: "Nhập nội dung thông báo...",
                    controller: provider.contentController,
                    maxLines: 8,
                  ),
                  const SizedBox(height: 30),

                  // Nút gửi
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: provider.sendNotification,
                        icon: const Icon(Icons.send_rounded, size: 18),
                        label: const Text("Gửi Thông Báo", style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B7D4), // Cyan cực sáng
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF00B7D4) : Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        if (isActive)
          Container(height: 2, width: 80, color: const Color(0xFF00B7D4))
        else
          const SizedBox(height: 2),
      ],
    );
  }

  Widget _buildDropdown(NotificationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Loại thông báo", style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF090E14), // Nền đen sâu
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF00B7D4).withOpacity(0.4)), // Viền Cyan mờ
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedType,
              isExpanded: true,
              dropdownColor: const Color(0xFF111827), // Màu nền menu khi xổ xuống
              focusColor: const Color(0xFF2563EB),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
              // Tùy chỉnh danh sách item
              items: provider.notificationTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Container(
                    width: double.infinity,
                    // Khi hover hoặc chọn sẽ có màu xanh blue (Flutter xử lý mặc định gần giống ảnh)
                    child: Text(
                      type,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: provider.setNotificationType,
              // Giúp chữ trên nút luôn màu trắng, không bị đổi màu theo highlight
              selectedItemBuilder: (BuildContext context) {
                return provider.notificationTypes.map<Widget>((String item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // Màu nền xanh đen đậm đặc trưng của bản web
        color: const Color(0xFF141C28), 
        borderRadius: BorderRadius.circular(12), // Bo góc nhẹ 4px cho sắc sảo
        border: Border.all(
          // Viền xanh Cyan với độ mờ thấp (0.2) để trông tinh tế
          color: const Color(0xFF00B7D4).withOpacity(0.2), 
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 13, height: 1.4),
                children: [
                  TextSpan(
                    text: "Lưu ý: ",
                    style: TextStyle(
                      color: Color(0xFF9CF3FC), // Màu xanh Cyan sáng
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Thông báo này sẽ chỉ được gửi đến các Gamer là hội viên của phòng máy bạn.",
                    style: TextStyle(
                      color: Color(0xFF72E6EF), // Màu xám xanh cho nội dung
                      fontWeight: FontWeight.w400,
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