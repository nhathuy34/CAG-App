import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/profile_header.dart';
import '../widgets/setting_item.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const Column(
                children: [
                  SettingItem(title: 'Quản Lý Nhân Viên', subtitle: '3 Active'),
                  SettingItem(title: 'Cấu Hình Booking', subtitle: 'Auto-Accept: OFF'),
                  SettingItem(
                      title: 'Ví Đối Tác',
                      subtitle: '2.5M VNĐ',
                      trailingColor: Color(0xFF00E676)),
                  SettingItem(
                      title: 'Liên Hệ Hỗ Trợ Kỹ Thuật',
                      subtitle: '24/7',
                      trailingColor: Color(0xFF2979FF),
                      isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.1)),
        ),
        child: const Center(
            child: Text('ĐĂNG XUẤT',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 1.5))),
      ),
    );
  }
}
