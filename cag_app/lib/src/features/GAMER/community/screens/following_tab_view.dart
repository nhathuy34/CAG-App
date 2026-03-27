import 'package:flutter/material.dart';

class FollowingTabView extends StatelessWidget {
  const FollowingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          _buildReviewPost(
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

  Widget _buildReviewPost({
    required String userName,
    required String userRole,
    required bool isVip,
    required bool isFollowing,
    required String timestamp,
    required double rating,
    required Map<String, int> ratings,
    required String content,
    required List<String> hashtags,
    required int likes,
    required int comments,
    required String location,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        _buildTag(userRole, const Color(0xFF475569)),
                        if (isVip) _buildTag('VIP', const Color(0xFFCA8A04)),
                        if (isFollowing)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF059669).withOpacity(0.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.check, color: Color(0xFF34D399), size: 10),
                                SizedBox(width: 4),
                                Text('ĐANG THEO DÕI', style: TextStyle(color: Color(0xFF34D399), fontSize: 8, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(timestamp, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 16),
          // Ratings Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                _buildTotalRating(rating),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 1,
                  height: 30,
                  color: Colors.white12,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ratings.entries.map((e) => _buildSubRating(e.key, e.value)).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildVerifiedBadge(),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: hashtags.map((tag) => Text(tag, style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 12))).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 14),
              const SizedBox(width: 4),
              Expanded(child: Text('Địa điểm: $location', style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 12, fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF065F46).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF059669).withOpacity(0.5)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.person_add_outlined, color: Color(0xFF34D399), size: 14),
                    SizedBox(width: 4),
                    Text('ĐẶT ĐÚNG MÁY NÀY (-10%)', style: TextStyle(color: Color(0xFF34D399), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF334155)),
          Row(
            children: [
              const Icon(Icons.favorite, color: Color(0xFFF43F5E), size: 16),
              const SizedBox(width: 4),
              Text('$likes Yêu thích', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              const Spacer(),
              const Icon(Icons.chat_bubble_outline, color: Color(0xFF64748B), size: 16),
              const SizedBox(width: 4),
              Text('$comments Bình luận', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              const SizedBox(width: 16),
              const Icon(Icons.share_outlined, color: Color(0xFF64748B), size: 16),
              const SizedBox(width: 4),
              const Text('Chia sẻ', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRating(double rating) {
    return Column(
      children: [
        Text(
          rating.toString(),
          style: const TextStyle(color: Color(0xFFFACC15), fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text(
          'ĐIỂM TB',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 8, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSubRating(String label, int value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF064E3B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF059669).withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, color: Color(0xFF34D399), size: 10),
          SizedBox(width: 4),
          Text('Verified Player', style: TextStyle(color: Color(0xFF34D399), fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }
}
