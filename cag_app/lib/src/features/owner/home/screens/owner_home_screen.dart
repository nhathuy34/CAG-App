import 'package:CAG_App/src/features/owner/QuanLyQuan/dashboard/screens/quan_ly_quan_dashboard_screen.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/widgets/owner_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/owner/home/providers/owner_home_providers.dart';
import 'package:CAG_App/src/constants/app_theme.dart';

class OwnerHomeScreen extends ConsumerWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNavIndex = ref.watch(ownerNavIndexProvider);
    final activeRole = ref.watch(ownerRoleProvider);
    final selectedBranch = ref.watch(selectedBranchProvider);

    final mainScreens = [
      // Index 0: Quản lý quán
      const QuanLyQuanDashboardScreen(),
      // Index 1: Thống kê
      const OwnerPlaceholder(title: 'THỐNG KÊ'),
      // Index 2: Thông báo
      const OwnerPlaceholder(title: 'THÔNG BÁO'),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Custom Sticky Header
          _buildHeader(context, ref, activeRole, selectedBranch),
          
          // Main Content (3 Main Tabs)
          Expanded(
            child: IndexedStack(
              index: selectedNavIndex,
              children: mainScreens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context, ref, selectedNavIndex),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, String activeRole, String selectedBranch) {
    final branches = branchMapping[activeRole] ?? branchMapping['BOSS']!;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Logo
              Transform(
                transform: Matrix4.skewX(-0.15),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2979FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'PARTNER',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rajdhani',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 12),

              // Role Selector
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  children: ['BOSS', 'OWNER', 'MANAGER'].map((role) {
                    final isActive = activeRole == role;
                    return GestureDetector(
                      onTap: () {
                        ref.read(ownerRoleProvider.notifier).state = role;
                        // RESET branch if current selection is not available for the new role
                        final newBranches = branchMapping[role] ?? branchMapping['BOSS']!;
                        final currentBranch = ref.read(selectedBranchProvider);
                        if (!newBranches.any((b) => b['value'] == currentBranch)) {
                          ref.read(selectedBranchProvider.notifier).state = newBranches.first['value']!;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF2979FF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              
              // VIP Badge
              _buildVIPBadge(),
            ],
          ),
          const SizedBox(height: 12),

          // Branch Dropdown
          _buildBranchDropdown(selectedBranch, branches, ref),
        ],
      ),
    );
  }

  Widget _buildVIPBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAB308).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEAB308).withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.emoji_events, color: Color(0xFFEAB308), size: 14),
          SizedBox(width: 4),
          Text('VIP', style: TextStyle(color: Color(0xFFEAB308), fontSize: 10, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildBranchDropdown(String selectedBranch, List<Map<String, String>> branches, WidgetRef ref) {
    // FIX: Ensure selectedBranch exists in the current branches list for the selected role.
    // If not, use the first available branch.
    final hasCurrentValue = branches.any((b) => b['value'] == selectedBranch);
    final displayValue = hasCurrentValue ? selectedBranch : branches.first['value'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: displayValue,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E1E),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: branches.map((branch) {
            return DropdownMenuItem<String>(
              value: branch['value'],
              child: Text(
                branch['label']!,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) ref.read(selectedBranchProvider.notifier).state = val;
          },
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, WidgetRef ref, int selectedIndex) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(ref, 0, Icons.storefront_rounded, 'Quản lý quán', selectedIndex == 0),
              _buildNavItem(ref, 1, Icons.bar_chart_rounded, 'Thống kê', selectedIndex == 1),
              _buildNavItem(ref, 2, Icons.notifications_none_rounded, 'Thông báo', selectedIndex == 2, hasAlert: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, int index, IconData icon, String label, bool isActive, {bool hasAlert = false}) {
    final color = isActive ? const Color(0xFF2979FF) : Colors.grey;

    return GestureDetector(
      onTap: () {
        ref.read(ownerNavIndexProvider.notifier).state = index;
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: color, size: 28),
              if (hasAlert)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
