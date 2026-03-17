import 'package:flutter/material.dart';
import 'dashboard_widgets.dart'; 
import 'profile_sections.dart'; 

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedTabIndex = 0; // Quản lý tab con (Overview, Wallet...)

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 110),
      child: Column(
        children: [
          const ProfileHeader(userName: "Lương Quang Vinh", userAvatar: "https://picsum.photos/200"),
          const SizedBox(height: 24),
          const FindMatchButton(),
          const SizedBox(height: 24),
          
          CustomTabBar(
            selectedIndex: _selectedTabIndex,
            onTabChanged: (index) => setState(() => _selectedTabIndex = index),
          ),
          const SizedBox(height: 24),

          // Nội dung thay đổi theo Tab con
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

            const SystemLogsSection(),
          ],
        ],
      ),
    );
  }
}