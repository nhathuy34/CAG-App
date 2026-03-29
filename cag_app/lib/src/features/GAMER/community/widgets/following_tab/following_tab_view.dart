import 'package:flutter/material.dart';
import 'review_post_widget.dart';

class FollowingTabView extends StatelessWidget {
  const FollowingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          ReviewPostWidget(
            userName: 'Thành Long',
            userRole: 'CAG Creator',
            isVip: true,
            isFollowing: true,
            timestamp: '15 phút trước',
            rating: 4.5,
            ratings: {
              'Cấu hình': 5,
              'Không gian': 4,
              'Phục vụ': 5,
              'Giá': 3,
            },
            content: 'Review nhẹ Flash Gaming Center: Máy mượt, ghế êm, máy lạnh run người. Ae ghé test ngay dàn RTX 4090 nhé! ❄️',
            hashtags: ['#ReviewQuan', '#KiemTienOnline', '#NetCo'],
            likes: 154,
            comments: 2,
            location: 'Flash Gaming Center',
            imageUrl: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f',
          ),
        ],
      ),
    );
  }
}
