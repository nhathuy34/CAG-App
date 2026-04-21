import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class UsersTabView extends StatelessWidget {
  const UsersTabView({super.key});

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 800, // Chiều rộng tối thiểu để không bị bóp méo layout
          child: Column(
            children: [
              // Header Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white10)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: _headerText("USER")),
                    Expanded(flex: 1, child: _headerText("ROLE")),
                    Expanded(flex: 2, child: _headerText("RANK / POINTS")),
                    Expanded(flex: 1, child: _headerText("STATUS")),
                    Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: _headerText("ACTIONS"))),
                  ],
                ),
              ),
              // Danh sách Users
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: mockUsers.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
                  itemBuilder: (context, index) {
                    final user = mockUsers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          // Cột USER
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xFF1E2430),
                                  child: Icon(Icons.person, color: Colors.white70),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text(user['username']!, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                                    Text(user['email']!, style: const TextStyle(color: Colors.white54, fontSize: 10)),
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
                              child: _roleBadge(user['role']!),
                            ),
                          ),
                          // Cột RANK / POINTS
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user['rank']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(height: 2),
                                Text(user['points']!, style: const TextStyle(color: AppTheme.gold, fontSize: 10)),
                              ],
                            ),
                          ),
                          // Cột STATUS
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _statusBadge(user['status']!),
                            ),
                          ),
                          // Cột ACTIONS
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.end,
                                children: [
                                  if (user['status'] == "ACTIVE" && user['role'] != 'ADMIN')
                                    _actionBtn("BAN", Colors.redAccent.withOpacity(0.2), Colors.redAccent),
                                  if (user['status'] == "BANNED")
                                    _actionBtn("UNBAN", Colors.green.withOpacity(0.2), Colors.green),
                                  if (user['role'] != 'ADMIN')
                                    _actionBtn("MAKE ADMIN", Colors.purple.withOpacity(0.2), Colors.purpleAccent),
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

  Widget _headerText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
    );
  }

  Widget _roleBadge(String role) {
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Text(role, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _statusBadge(String status) {
    final isBanned = status == "BANNED";
    final bgColor = isBanned ? Colors.redAccent.withOpacity(0.2) : Colors.green.withOpacity(0.2);
    final textColor = isBanned ? Colors.redAccent : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionBtn(String label, Color bgColor, Color textColor) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
