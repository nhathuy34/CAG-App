import 'package:CAG_App/src/features/owner/QuanLyQuan/booking/screens/booking_screen.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/marketing/screens/marketing_screen.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/settings/screens/settings_screen.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/store_profile/screens/store_profile_screen.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/tong_quan/screens/tong_quan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/owner/QuanLyQuan/dashboard/providers/dashboard_providers.dart';

class QuanLyQuanDashboardScreen extends ConsumerWidget {
  const QuanLyQuanDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubIndex = ref.watch(ownerSubFeatureIndexProvider);
    final isMenuOpen = ref.watch(isFABMenuOpenProvider);

    final subScreens = [
      const TongQuanScreen(),
      const BookingScreen(),
      const StoreProfileScreen(),
      const MarketingScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Sub-feature Content
          IndexedStack(index: selectedSubIndex, children: subScreens),

          // Custom FAB Menu Overlay
          if (isMenuOpen)
            GestureDetector(
              onTap: () =>
                  ref.read(isFABMenuOpenProvider.notifier).state = false,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          if (isMenuOpen)
            Positioned(
              right: 16,
              bottom: 80, // Above the FAB position
              child: _buildVerticalMenu(context, ref, selectedSubIndex),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(isFABMenuOpenProvider.notifier).state = !isMenuOpen,
        backgroundColor: const Color(0xFF2979FF),
        child: AnimatedRotation(
          duration: const Duration(milliseconds: 300),
          turns: isMenuOpen ? 0.125 : 0, // 45 degrees rotation for X effect
          child: Icon(
            isMenuOpen ? Icons.add_rounded : Icons.apps_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalMenu(
    BuildContext context,
    WidgetRef ref,
    int selectedSubIndex,
  ) {
    final menuItems = [
      {'icon': Icons.grid_view_rounded, 'label': 'Tổng quan'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'Booking'},
      {'icon': Icons.storefront_outlined, 'label': 'Hồ Sơ'},
      {'icon': Icons.edit_note_rounded, 'label': 'Marketing'},
      {'icon': Icons.settings_outlined, 'label': 'Cài Đặt'},
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(menuItems.length, (index) {
        final isSelected = selectedSubIndex == index;
        final item = menuItems[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              ref.read(ownerSubFeatureIndexProvider.notifier).state = index;
              ref.read(isFABMenuOpenProvider.notifier).state = false;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Label
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2979FF)
                        : const Color(0xFF262626),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Icon Circle
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2979FF)
                        : const Color(0xFF262626),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected ? Colors.white24 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: isSelected ? Colors.white : Colors.white60,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      }).reversed.toList(),
    );
  }
}
