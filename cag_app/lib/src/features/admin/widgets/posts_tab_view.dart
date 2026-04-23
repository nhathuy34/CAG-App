import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class PostsTabView extends StatelessWidget {
  const PostsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      children: [
        _buildPostCard(
          screenWidth,
          badgeLabel: "BỊ BÁO CÁO (1)",
          badgeColor: Colors.redAccent,
          time: "5 giờ trước",
          userName: "GAMER ẨN DANH",
          userId: "Gamer An Danh",
          trustScore: 70,
          content: "Lỗi save game Wukong không load được ở\nchapter 4, ai biết fix không cứu với :((",
          tags: ["#LoiGame", "#Help"],
        ),
        SizedBox(height: screenWidth * 0.05),
        _buildPostCard(
          screenWidth,
          badgeLabel: "CHỜ DUYỆT MỚI",
          badgeColor: AppTheme.gold,
          time: "Vừa xong",
          userName: "NEWBIE123",
          userId: "Newbie123",
          trustScore: 50,
          content: "Có ai biết cách hack tiền trong GTA V online\nkhông? Chỉ mình với, trả phí 50k thẻ cào.",
          tags: ["#HackGame", "#Cheat"],
        ),
      ],
    );
  }

  Widget _buildPostCard(
    double screenWidth, {
    required String badgeLabel,
    required Color badgeColor,
    required String time,
    required String userName,
    required String userId,
    required int trustScore,
    required String content,
    required List<String> tags,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(color: Colors.white10),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Phần người dùng (Bên trái)
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05, horizontal: screenWidth * 0.025),
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.075,
                      backgroundColor: const Color(0xFF1E2430),
                      child: Icon(Icons.person, color: Colors.white70, size: screenWidth * 0.075),
                    ),
                    SizedBox(height: screenWidth * 0.035),
                    Text(
                      userName,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.038),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenWidth * 0.025),
                    _infoBadge(screenWidth, "ID: $userId"),
                    SizedBox(height: screenWidth * 0.012),
                    _infoBadge(screenWidth, "Trust Score: $trustScore"),
                    SizedBox(height: screenWidth * 0.012),
                    Text(
                      "Cảnh báo vi phạm",
                      style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: screenWidth * 0.028, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            
            // Phần Nội dung bài viết (Ở giữa)
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenWidth * 0.01),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(badgeLabel, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.028, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(time, style: TextStyle(color: Colors.white54, fontSize: screenWidth * 0.03)),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.035),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.035),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22), // Màu nền hơi sáng hơn nền khung
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        content,
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035, height: 1.5),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.035),
                    Wrap(
                      spacing: screenWidth * 0.02,
                      runSpacing: screenWidth * 0.01,
                      children: tags.map((t) => Text(t, style: TextStyle(color: AppTheme.cyanNeon, fontSize: screenWidth * 0.032, fontWeight: FontWeight.bold))).toList(),
                    )
                  ],
                ),
              ),
            ),

            // Phần Action (Bên phải)
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05, horizontal: screenWidth * 0.03),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     _actionButton(screenWidth, Icons.check, "DUYỆT", Colors.green, Colors.white),
                     SizedBox(height: screenWidth * 0.015),
                     _actionButton(screenWidth, Icons.close, "TỪ CHỐI", Colors.white12, Colors.white),
                     SizedBox(height: screenWidth * 0.03),
                     const Divider(color: Colors.white10, height: 1),
                     SizedBox(height: screenWidth * 0.03),
                     _actionButton(screenWidth, Icons.block, "BAN USER", Colors.redAccent.withOpacity(0.2), Colors.redAccent, false),
                   ],
                 ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoBadge(double screenWidth, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(screenWidth * 0.01),
      ),
      child: Text(text, style: TextStyle(color: Colors.white54, fontSize: screenWidth * 0.028)),
    );
  }

  Widget _actionButton(double screenWidth, IconData icon, String label, Color bgColor, Color textColor, [bool isFilled = true]) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(screenWidth * 0.015),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isFilled ? bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.015),
          border: isFilled ? null : Border.all(color: bgColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: screenWidth * 0.045),
            SizedBox(width: screenWidth * 0.015),
            Flexible(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
