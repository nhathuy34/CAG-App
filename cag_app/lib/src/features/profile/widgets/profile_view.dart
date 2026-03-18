import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Thêm thư viện này
import 'package:CAG_App/src/features/welcome_screen.dart'; // Đảm bảo đúng đường dẫn của bạn
import 'dashboard_widgets.dart'; 
import 'profile_sections.dart'; 
import 'system_settings.dart'; 

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedTabIndex = 0; 

  // State mặc định
  String _userName = "Lương Quang Vinh";
  String _userPhone = "0909888999"; 
  String _userAvatar = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Tải dữ liệu ngay khi mở tab Profile
  }

  // Hàm đọc dữ liệu từ bộ nhớ máy
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Nếu không có dữ liệu cũ, nó sẽ lấy giá trị mặc định ở vế phải (??)
      _userName = prefs.getString('userName') ?? "Lương Quang Vinh";
      _userPhone = prefs.getString('userPhone') ?? "0909888999";
      _userAvatar = prefs.getString('userAvatar') ?? "https://picsum.photos/200";
    });
  }

  // Hàm cập nhật và LƯU dữ liệu vào bộ nhớ máy
  Future<void> _updateProfile(String newName, String newPhone, String newAvatar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', newName);
    await prefs.setString('userPhone', newPhone);
    await prefs.setString('userAvatar', newAvatar);

    setState(() {
      _userName = newName;
      _userPhone = newPhone;
      _userAvatar = newAvatar;
    });
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(), 
      ),
      (route) => false, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 110),
      child: Column(
        children: [
          ProfileHeader(
            userName: _userName, 
            userAvatar: _userAvatar
          ),
          const SizedBox(height: 24),
          const FindMatchButton(),
          const SizedBox(height: 24),
          
          CustomTabBar(
            selectedIndex: _selectedTabIndex,
            onTabChanged: (index) => setState(() => _selectedTabIndex = index),
          ),
          const SizedBox(height: 24),

          if (_selectedTabIndex == 0) ...[
            const PerformanceStatsCard(),
            const SizedBox(height: 20),
            const AccessPassCard(),
            const SizedBox(height: 20),
            const SystemLogsSection(),
          ] else if (_selectedTabIndex == 1) ...[
            const WalletSection(),
          ] else if (_selectedTabIndex == 2) ...[
            const LootBoxSection(),
          ] else if (_selectedTabIndex == 3) ...[
            SystemSection(
              userName: _userName,
              userPhone: _userPhone,
              userAvatar: _userAvatar,
              onUpdateProfile: _updateProfile,
              onLogout: _handleLogout,
            ),
          ],
        ],
      ),
    );
  }
}