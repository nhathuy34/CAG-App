import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class PostsTabView extends StatelessWidget {
  const PostsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildPostCard(
          badgeLabel: "BỊ BÁO CÁO (1)",
          badgeColor: Colors.redAccent,
          time: "5 giờ trước",
          userName: "GAMER ẨN DANH",
          userId: "Gamer An Danh",
          trustScore: 70,
          content: "Lỗi save game Wukong không load được ở\nchapter 4, ai biết fix không cứu với :((",
          tags: ["#LoiGame", "#Help"],
        ),
        const SizedBox(height: 20),
        _buildPostCard(
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

  Widget _buildPostCard({
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
        borderRadius: BorderRadius.circular(12),
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
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF1E2430),
                      child: Icon(Icons.person, color: Colors.white70, size: 30),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    _infoBadge("ID: $userId"),
                    const SizedBox(height: 5),
                    _infoBadge("Trust Score: $trustScore"),
                    const SizedBox(height: 5),
                    Text(
                      "Cảnh báo vi phạm",
                      style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            
            // Phần Nội dung bài viết (Ở giữa)
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(badgeLabel, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        Text(time, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22), // Màu nền hơi sáng hơn nền khung
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        content,
                        style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: tags.map((t) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(t, style: const TextStyle(color: AppTheme.cyanNeon, fontSize: 12, fontWeight: FontWeight.bold)),
                      )).toList(),
                    )
                  ],
                ),
              ),
            ),

            // Phần Action (Bên phải)
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     _actionButton(Icons.check, "DUYỆT", Colors.green, Colors.white),
                     const SizedBox(height: 6),
                     _actionButton(Icons.close, "TỪ CHỐI", Colors.white12, Colors.white),
                     const SizedBox(height: 12),
                     const Divider(color: Colors.white10, height: 1),
                     const SizedBox(height: 12),
                     _actionButton(Icons.block, "BAN USER", Colors.redAccent.withOpacity(0.2), Colors.redAccent, false),
                   ],
                 ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white54, fontSize: 10)),
    );
  }

  Widget _actionButton(IconData icon, String label, Color bgColor, Color textColor, [bool isFilled = true]) {
    return SizedBox(
      width: double.infinity,
      height: 28,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? bgColor : Colors.transparent,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: isFilled ? BorderSide.none : BorderSide(color: bgColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        onPressed: () {},
        icon: Icon(icon, size: 12),
        label: FittedBox(fit: BoxFit.scaleDown, child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
