import 'package:flutter/material.dart';

class MainTabFilter extends StatelessWidget {
  final String activeTab;
  final int totalCount, onlineCount, offlineCount, toolsCount;
  final ValueChanged<String> onTabChanged;

  const MainTabFilter({
    super.key,
    required this.activeTab,
    required this.totalCount,
    required this.onlineCount,
    required this.offlineCount,
    required this.toolsCount,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterItem(
              "TẤT CẢ (IDC)",
              totalCount.toString(),
              activeTab == "TẤT CẢ (IDC)",
            ),
            _filterItem(
              "ONLINE",
              onlineCount.toString(),
              activeTab == "ONLINE",
            ),
            _filterItem(
              "OFFLINE",
              offlineCount.toString(),
              activeTab == "OFFLINE",
            ),
            _filterItem("TOOLS", toolsCount.toString(), activeTab == "TOOLS"),
            _filterItem("GAME CỦA TÔI", "4", activeTab == "GAME CỦA TÔI"),
          ],
        ),
      ),
    );
  }

  Widget _filterItem(String label, String count, bool active) {
    return GestureDetector(
      onTap: () => onTabChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0xFF00FF75), Color(0xFF0085FF)],
                )
              : null,
          color: active ? null : Colors.transparent,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.black : Colors.white38,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: active
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                count,
                style: TextStyle(
                  color: active ? Colors.black : Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
