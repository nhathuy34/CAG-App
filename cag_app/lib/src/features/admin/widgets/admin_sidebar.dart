import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuSelected;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 260,
        decoration: const BoxDecoration(
          color: Color(0xFF0D1117), // Nền Sidebar tối đặc trưng
          border: Border(
            right: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildLogo(),
            const SizedBox(height: 40),
            _buildMenuItem(0, Icons.verified_user_outlined, "KIỂM DUYỆT"),
            _buildMenuItem(1, Icons.dashboard_outlined, "DASHBOARD"),
            _buildMenuItem(2, Icons.storefront_outlined, "QUẢN LÝ QUÁN"),
            _buildMenuItem(3, Icons.notifications_none_outlined, "THÔNG BÁO"),
            const Spacer(),
            _buildProfileBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.cyanNeon,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              "C",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CAG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "ECOSYSTEM",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onMenuSelected(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, right: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF161B22) : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.cyanNeon : Colors.white54,
              size: 20,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBox() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1E2430),
                child: Icon(Icons.person, color: Colors.white70, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("ADMIN HỆ THỐNG",
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text("DIAMOND",
                      style: TextStyle(color: AppTheme.gold, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: AppTheme.cyanNeon, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 5),
                      const Flexible(
                        child: Text(
                          "SYSTEM VIEW: ADMIN",
                          style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white54, size: 14),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppTheme.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.star_border, color: Colors.black, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "VIP Benefits",
                      style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
