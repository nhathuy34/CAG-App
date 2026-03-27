import 'package:flutter/material.dart';

class FeedTabView extends StatelessWidget {
  const FeedTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAB308),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'NHIỆM VỤ CHỦ QUÁN (SĂN THƯỞNG)',
                style: TextStyle(
                  color: Color(0xFFEAB308),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildQuestCard(
                  title: 'REVIEW TRẢI NGHIỆM PHÒNG VIP MỚI (RTX 4060)',
                  subtitle: 'StarGaming Q10',
                  reward: '50.000đ + 1 Sting',
                  timeLeft: 'Còn 2 ngày',
                  imageUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36',
                ),
                const SizedBox(width: 12),
                _buildQuestCard(
                  title: 'CHECK-IN MENU CƠM TẤM ĐÊM',
                  subtitle: 'Cyber All Game Gò Vấp',
                  reward: 'Coupon 2h Chơi',
                  timeLeft: 'Hết hạn hôm nay',
                  isExpiringSoon: true,
                  imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          _buildPostInput(),
          
          const SizedBox(height: 24),

          _buildFeaturedPost(
            userName: 'CAG Guide',
            userRole: 'CAG Creator',
            isVip: true,
            isPinned: true,
            content: 'CAG Guide - Pro Gaming Ecosystem: Nền tảng kết nối Gamer và Cyber Game hàng đầu Việt Nam. Tìm quán ngon, đặt máy xịn, nhận quà khủng!',
            hashtags: ['#CAGGuide', '#ProGaming', '#Ecosystem'],
            likes: 999,
          ),

          const SizedBox(height: 16),

          _buildPostItem(
            userName: 'Flash Gaming Center',
            userRole: 'CAG Creator',
            isVip: true,
            timestamp: '5 giờ trước',
            content: '🎉 MỪNG SINH NHẬT FLASH GAMING Q.7 🎉 Giảm giá 50% tất cả các hạng phòng trong 3 ngày cuối tuần này. Nạp 100k tặng 100k. Đến ngay kèo lỡ!',
            hashtags: ['#KhuyenMai', '#SinhNhat', '#FlashGaming'],
            likes: 890,
            comments: 125,
            location: 'Cyber All Game Q.7 VIP',
            hasPromotion: true,
            imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e',
          ),
        ],
      ),
    );
  }

  Widget _buildPostInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Bạn vừa chơi ở đâu? Review ngay kiếm tiền...',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    color: Color(0xFF94A3B8),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedPost({
    required String userName,
    required String userRole,
    required bool isVip,
    required bool isPinned,
    required String content,
    required List<String> hashtags,
    required int likes,
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
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'),
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
                        const Text('+ THEO DÕI', style: TextStyle(color: Color(0xFF34D399), fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    if (isPinned) const Text('Ghim', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          _buildFeaturedBadge(),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: hashtags.map((tag) => Text(tag, style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 12))).toList(),
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
              const Text('0 Bình luận', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
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

  Widget _buildPostItem({
    required String userName,
    required String userRole,
    required bool isVip,
    required String timestamp,
    required String content,
    required List<String> hashtags,
    required int likes,
    required int comments,
    required String location,
    bool hasPromotion = false,
    String? imageUrl,
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
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1542751371-adc38448a05e'),
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
                        const Text('+ THEO DÕI', style: TextStyle(color: Color(0xFF34D399), fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(timestamp, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: hashtags.map((tag) => Text(tag, style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 12))).toList(),
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 14),
              const SizedBox(width: 4),
              Expanded(child: Text('Địa điểm: $location', style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 12, fontWeight: FontWeight.bold))),
              if (hasPromotion)
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

  Widget _buildFeaturedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF701A75).withOpacity(0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.star, color: Color(0xFFF472B6), size: 10),
          SizedBox(width: 4),
          Text('FEATURED', style: TextStyle(color: Color(0xFFF472B6), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuestCard({
    required String title,
    required String subtitle,
    required String reward,
    required String timeLeft,
    required String imageUrl,
    bool isExpiringSoon = false,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF475569)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reward,
                      style: const TextStyle(
                        color: Color(0xFF4ADE80),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      timeLeft,
                      style: TextStyle(
                        color: isExpiringSoon ? const Color(0xFFEF4444) : const Color(0xFFFCA5A5),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
