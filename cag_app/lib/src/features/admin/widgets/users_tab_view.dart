import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class UsersTabView extends StatelessWidget {
  const UsersTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Sử dụng giá trị tỷ lệ (proportional) thay vì số mặc định 800.0
    final effectiveWidth = screenWidth > 800 ? screenWidth : screenWidth * 2.0;

    // Mock dữ liệu User để hiển thị giống hình
    final mockUsers = [
      {
        "name": "Lương Quang Vinh",
        "username": "@luongvinh3969",
        "email": "vinh.luong@cag.vn",
        "role": "GAMER",
        "rank": "DIAMOND",
        "points": "8888 pts",
        "status": "ACTIVE",
      },
      {
        "name": "Nguyễn Văn Chủ",
        "username": "@owner_flash",
        "email": "owner@flashgaming.vn",
        "role": "OWNER",
        "rank": "DIAMOND",
        "points": "100000 pts",
        "status": "ACTIVE",
      },
      {
        "name": "Admin Hệ Thống",
        "username": "@system_admin",
        "email": "admin@cag.vn",
        "role": "ADMIN",
        "rank": "DIAMOND",
        "points": "999999 pts",
        "status": "ACTIVE",
      },
      {
        "name": "Nguyễn Văn A",
        "username": "@hacker_pro",
        "email": "hacker@example.com",
        "role": "GAMER",
        "rank": "BRONZE",
        "points": "0 pts",
        "status": "BANNED",
      },
      {
        "name": "Trần Thị B",
        "username": "@cyber_owner",
        "email": "owner@cyber.com",
        "role": "OWNER",
        "rank": "GOLD",
        "points": "5000 pts",
        "status": "ACTIVE",
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(effectiveWidth * 0.015),
        border: Border.all(color: Colors.white10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: effectiveWidth, // Chiều rộng tối thiểu để không bị bóp méo layout
          child: Column(
            children: [
              // Header Row
              Container(
                padding: EdgeInsets.symmetric(horizontal: effectiveWidth * 0.025, vertical: effectiveWidth * 0.02),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white10)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: _headerText(effectiveWidth, "USER")),
                    Expanded(flex: 1, child: _headerText(effectiveWidth, "ROLE")),
                    Expanded(flex: 2, child: _headerText(effectiveWidth, "RANK / POINTS")),
                    Expanded(flex: 1, child: _headerText(effectiveWidth, "STATUS")),
                    Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: _headerText(effectiveWidth, "ACTIONS"))),
                  ],
                ),
              ),
              // Danh sách Users
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: effectiveWidth * 0.015),
                  itemCount: mockUsers.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
                  itemBuilder: (context, index) {
                    final user = mockUsers[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: effectiveWidth * 0.025, vertical: effectiveWidth * 0.02),
                      child: Row(
                        children: [
                          // Cột USER
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: effectiveWidth * 0.025,
                                  backgroundColor: const Color(0xFF1E2430),
                                  child: Icon(Icons.person, color: Colors.white70, size: effectiveWidth * 0.025),
                                ),
                                SizedBox(width: effectiveWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: effectiveWidth * 0.018)),
                                    SizedBox(height: effectiveWidth * 0.005),
                                    Text(user['username']!, style: TextStyle(color: Colors.white54, fontSize: effectiveWidth * 0.014)),
                                    Text(user['email']!, style: TextStyle(color: Colors.white54, fontSize: effectiveWidth * 0.014)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Cột ROLE
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _roleBadge(effectiveWidth, user['role']!),
                            ),
                          ),
                          // Cột RANK / POINTS
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user['rank']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: effectiveWidth * 0.016)),
                                SizedBox(height: effectiveWidth * 0.005),
                                Text(user['points']!, style: TextStyle(color: AppTheme.gold, fontSize: effectiveWidth * 0.014)),
                              ],
                            ),
                          ),
                          // Cột STATUS
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _statusBadge(effectiveWidth, user['status']!),
                            ),
                          ),
                          // Cột ACTIONS
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                spacing: effectiveWidth * 0.01,
                                runSpacing: effectiveWidth * 0.01,
                                alignment: WrapAlignment.end,
                                children: [
                                  if (user['status'] == "ACTIVE" && user['role'] != 'ADMIN')
                                    _actionBtn(effectiveWidth, "BAN", Colors.redAccent.withOpacity(0.2), Colors.redAccent),
                                  if (user['status'] == "BANNED")
                                    _actionBtn(effectiveWidth, "UNBAN", Colors.green.withOpacity(0.2), Colors.green),
                                  if (user['role'] != 'ADMIN')
                                    _actionBtn(effectiveWidth, "MAKE ADMIN", Colors.purple.withOpacity(0.2), Colors.purpleAccent),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText(double effectiveWidth, String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white70, fontSize: effectiveWidth * 0.016, fontWeight: FontWeight.bold),
    );
  }

  Widget _roleBadge(double effectiveWidth, String role) {
    Color bgColor;
    Color textColor;

    switch (role) {
      case "ADMIN":
        bgColor = Colors.purple.withOpacity(0.2);
        textColor = Colors.purpleAccent;
        break;
      case "OWNER":
        bgColor = Colors.blue.withOpacity(0.2);
        textColor = Colors.lightBlueAccent;
        break;
      default:
        bgColor = Colors.white10;
        textColor = Colors.white70;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: effectiveWidth * 0.015, vertical: effectiveWidth * 0.008),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(effectiveWidth * 0.008)),
      child: Text(role, style: TextStyle(color: textColor, fontSize: effectiveWidth * 0.014, fontWeight: FontWeight.bold)),
    );
  }

  Widget _statusBadge(double effectiveWidth, String status) {
    final isBanned = status == "BANNED";
    final bgColor = isBanned ? Colors.redAccent.withOpacity(0.2) : Colors.green.withOpacity(0.2);
    final textColor = isBanned ? Colors.redAccent : Colors.green;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: effectiveWidth * 0.015, vertical: effectiveWidth * 0.008),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(effectiveWidth * 0.008)),
      child: Text(status, style: TextStyle(color: textColor, fontSize: effectiveWidth * 0.014, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionBtn(double effectiveWidth, String label, Color bgColor, Color textColor) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(effectiveWidth * 0.008),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: effectiveWidth * 0.015, vertical: effectiveWidth * 0.008),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(effectiveWidth * 0.008)),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: effectiveWidth * 0.014, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
