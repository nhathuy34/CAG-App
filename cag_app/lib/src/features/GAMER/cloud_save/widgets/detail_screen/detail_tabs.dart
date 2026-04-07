import 'package:flutter/material.dart';

class DetailTabs extends StatelessWidget {
  final bool isCloudSaveTab;
  final ValueChanged<bool> onTabChanged;

  const DetailTabs({
    super.key,
    required this.isCloudSaveTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildTabItem(
            title: "CLOUD SAVE",
            icon: Icons.cloud_sync_outlined,
            isActive: isCloudSaveTab,
            activeColor: const Color(0xFF00FF75),
            onTap: () => onTabChanged(true),
          ),
          _buildTabItem(
            title: "CỘNG ĐỒNG",
            icon: Icons.chat_bubble_outline,
            isActive: !isCloudSaveTab,
            activeColor: const Color(0xFFFFD700),
            onTap: () => onTabChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required IconData icon,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    final color = isActive ? activeColor : Colors.white38;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? activeColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
