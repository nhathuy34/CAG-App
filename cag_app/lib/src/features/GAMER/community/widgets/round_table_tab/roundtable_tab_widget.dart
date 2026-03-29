import 'package:flutter/material.dart';

class DiscussionInputWidget extends StatelessWidget {
  const DiscussionInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF22D3EE), size: 18),
          ),
          const SizedBox(width: 16),
          const Text(
            'Bắt đầu thảo luận, hỏi đáp hoặc chia sẻ mẹo...',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class CategoryFiltersWidget extends StatelessWidget {
  const CategoryFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildTabTag('Tất cả', const Color(0xFF22D3EE), isActive: true),
          const SizedBox(width: 8),
          _buildTabTag('🔥 Hot Topic', const Color(0xFFF43F5E)),
          const SizedBox(width: 8),
          _buildTabTag('💻 Phần Cứng', const Color(0xFF38BDF8)),
          const SizedBox(width: 8),
          _buildTabTag('🎮 Wukong', const Color(0xFF818CF8)),
          const SizedBox(width: 8),
          _buildTabTag('⚠️ Lỗi Game', const Color(0xFFFBBF24)),
        ],
      ),
    );
  }

  Widget _buildTabTag(String label, Color color, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.2) : const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? color : const Color(0xFF334155)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? color : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DiscussionThreadWidget extends StatelessWidget {
  const DiscussionThreadWidget({
    super.key,
    required this.userName,
    required this.timestamp,
    required this.isFollowing,
    required this.upvotes,
    required this.title,
    required this.hashtags,
    required this.comments,
  });

  final String userName;
  final String timestamp;
  final bool isFollowing;
  final int upvotes;
  final String title;
  final List<String> hashtags;
  final int comments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155).withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vote Column
          Column(
            children: [
              const Icon(Icons.keyboard_arrow_up, color: Color(0xFF94A3B8), size: 18),
              Text(
                upvotes.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8), size: 18),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 12, backgroundColor: Colors.grey),
                    const SizedBox(width: 8),
                    Text(userName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    const Text('+ FOLLOW', style: TextStyle(color: Color(0xFF22D3EE), fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text(timestamp, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  children: hashtags.map((tag) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tag, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline, color: Color(0xFF94A3B8), size: 14),
                    const SizedBox(width: 4),
                    Text('$comments bình luận', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                    const Spacer(),
                    const Icon(Icons.share_outlined, color: Color(0xFF94A3B8), size: 14),
                    const SizedBox(width: 4),
                    const Text('Chia sẻ', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
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
