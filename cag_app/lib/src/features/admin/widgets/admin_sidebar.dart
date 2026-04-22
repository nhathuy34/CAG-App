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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final sidebarWidth = isDesktop ? screenWidth * 0.2 : screenWidth * 0.7;

    return SafeArea(
      child: Container(
        width: sidebarWidth,
        decoration: const BoxDecoration(
          color: Color(0xFF0D1117), // Nền Sidebar tối đặc trưng
          border: Border(
            right: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: sidebarWidth * 0.08),
            _buildLogo(sidebarWidth),
            SizedBox(height: sidebarWidth * 0.15),
            _buildMenuItem(sidebarWidth, 0, Icons.verified_user_outlined, "KIỂM DUYỆT"),
            _buildMenuItem(sidebarWidth, 1, Icons.dashboard_outlined, "DASHBOARD"),
            _buildMenuItem(sidebarWidth, 2, Icons.storefront_outlined, "QUẢN LÝ QUÁN"),
            _buildMenuItem(sidebarWidth, 3, Icons.notifications_none_outlined, "THÔNG BÁO"),
            const Spacer(),
            _buildProfileBox(sidebarWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double sidebarWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidebarWidth * 0.08),
      child: Row(
        children: [
          Container(
            width: sidebarWidth * 0.15,
            height: sidebarWidth * 0.15,
            decoration: BoxDecoration(
              color: AppTheme.cyanNeon,
              borderRadius: BorderRadius.circular(sidebarWidth * 0.03),
            ),
            alignment: Alignment.center,
            child: Text(
              "C",
              style: TextStyle(
                color: Colors.black,
                fontSize: sidebarWidth * 0.085,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: sidebarWidth * 0.06),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CAG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: sidebarWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "ECOSYSTEM",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: sidebarWidth * 0.04,
                  letterSpacing: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(double sidebarWidth, int index, IconData icon, String title) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onMenuSelected(index),
      child: Container(
        margin: EdgeInsets.only(bottom: sidebarWidth * 0.04, right: sidebarWidth * 0.06),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF161B22) : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(sidebarWidth * 0.04),
            bottomRight: Radius.circular(sidebarWidth * 0.04),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: sidebarWidth * 0.06, horizontal: sidebarWidth * 0.08),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.cyanNeon : Colors.white54,
              size: sidebarWidth * 0.08,
            ),
            SizedBox(width: sidebarWidth * 0.06),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: sidebarWidth * 0.05,
                letterSpacing: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBox(double sidebarWidth) {
    return Padding(
      padding: EdgeInsets.all(sidebarWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: sidebarWidth * 0.07,
                backgroundColor: const Color(0xFF1E2430),
                child: Icon(Icons.person, color: Colors.white70, size: sidebarWidth * 0.08),
              ),
              SizedBox(width: sidebarWidth * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ADMIN HỆ THỐNG",
                      style: TextStyle(color: Colors.white, fontSize: sidebarWidth * 0.045, fontWeight: FontWeight.bold)),
                  SizedBox(height: sidebarWidth * 0.01),
                  Text("DIAMOND",
                      style: TextStyle(color: AppTheme.gold, fontSize: sidebarWidth * 0.04, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          SizedBox(height: sidebarWidth * 0.06),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: sidebarWidth * 0.04, horizontal: sidebarWidth * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(sidebarWidth * 0.03),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: sidebarWidth * 0.03,
                        height: sidebarWidth * 0.03,
                        decoration: const BoxDecoration(
                            color: AppTheme.cyanNeon, shape: BoxShape.circle),
                      ),
                      SizedBox(width: sidebarWidth * 0.02),
                      Flexible(
                        child: Text(
                          "SYSTEM VIEW: ADMIN",
                          style: TextStyle(color: Colors.white70, fontSize: sidebarWidth * 0.03, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white54, size: sidebarWidth * 0.05),
                    ],
                  ),
                ),
              ),
              SizedBox(width: sidebarWidth * 0.03),
              Container(
                padding: EdgeInsets.symmetric(vertical: sidebarWidth * 0.03, horizontal: sidebarWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppTheme.gold,
                  borderRadius: BorderRadius.circular(sidebarWidth * 0.03),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.black, size: sidebarWidth * 0.05),
                    SizedBox(width: sidebarWidth * 0.015),
                    Text(
                      "VIP Benefits",
                      style: TextStyle(color: Colors.black, fontSize: sidebarWidth * 0.035, fontWeight: FontWeight.bold),
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
