import 'package:CAG_App/src/features/owner/QuanLyQuan/dashboard/providers/notification_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../providers/notification_providers.dart';
import '../widgets/notification_history_widget.dart';
import '../widgets/notification_form_widgets.dart';

/// ✅ TAB STATE (đặt ngoài)
final tabIndexProvider = StateProvider<int>((ref) => 0);

class ThongBaoSceen extends ConsumerWidget {
  const ThongBaoSceen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(notificationProvider);
    final tabIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF060B13),
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
                fontFamily: 'Rajdhani',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Gửi thông báo khuyến mãi, chăm sóc khách hàng cho hội viên của bạn.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 24),

            /// ================= TABS =================
            Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      ref.read(tabIndexProvider.notifier).state = 0,
                  child: _buildTab("Gửi Thông Báo Mới", tabIndex == 0),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () =>
                      ref.read(tabIndexProvider.notifier).state = 1,
                  child: _buildTab("Lịch Sử Gửi", tabIndex == 1),
                ),
              ],
            ),

            const SizedBox(height: 2),
            Container(height: 1, color: Colors.white.withOpacity(0.05)),
            const SizedBox(height: 30),

            /// ================= CONTENT =================
            tabIndex == 0
                ? _buildForm(provider)
                : const NotificationHistoryWidget(),
          ],
        ),
      ),
    );
  }

  /// ================= FORM =================
  Widget _buildForm(NotificationProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0B121E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
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
              Expanded(flex: 2, child: _buildDropdown(provider)),
            ],
          ),
          const SizedBox(height: 24),

          _buildNoteBox(),
          const SizedBox(height: 24),

          CustomTextField(
            label: "Nội dung chi tiết",
            hint: "Nhập nội dung thông báo...",
            controller: provider.contentController,
            maxLines: 8,
          ),
          const SizedBox(height: 30),

          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: provider.sendNotification,
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text(
                  "Gửi Thông Báo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B7D4),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= TAB UI =================
  Widget _buildTab(String label, bool isActive) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color:
                  isActive ? const Color(0xFF00B7D4) : Colors.white38,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            color: isActive
                ? const Color(0xFF00B7D4)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }

  /// ================= DROPDOWN =================
  Widget _buildDropdown(NotificationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Loại thông báo",
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF090E14),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00B7D4).withOpacity(0.4),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedType,
              isExpanded: true,
              dropdownColor: const Color(0xFF111827),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
              ),
              items: provider.notificationTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: provider.setNotificationType,
            ),
          ),
        ),
      ],
    );
  }

  /// ================= NOTE BOX =================
  Widget _buildNoteBox() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF141C28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00B7D4).withOpacity(0.2),
        ),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 13, height: 1.4),
          children: [
            TextSpan(
              text: "Lưu ý: ",
              style: TextStyle(
                color: Color(0xFF9CF3FC),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  "Thông báo này sẽ chỉ được gửi đến các Gamer là hội viên của phòng máy bạn.",
              style: TextStyle(color: Color(0xFF72E6EF)),
            ),
          ],
        ),
      ),
    );
  }
}