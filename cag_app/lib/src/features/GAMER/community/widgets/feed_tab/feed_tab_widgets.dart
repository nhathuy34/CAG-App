import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/feed_tab/postcomment_section.dart';
import 'package:CAG_App/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- CARD NHIỆM VỤ DÙNG CHUNG ---
class QuestCard extends StatelessWidget {
  final QuestModel quest;
  const QuestCard({super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAB308).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              quest.imageUrl,
              width: 64,
              height: 64,
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
                  quest.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                Text(
                  quest.shopName,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3B).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        quest.reward,
                        style: const TextStyle(
                          color: Color(0xFF4ADE80),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),

                    Text(
                      quest.deadline,
                      style: const TextStyle(
                        color: Color(0xFFF87171),
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

// --- CARD POST THEO MẪU HTML ---
// --- CARD POST THEO MẪU HTML ---
class PostItemWidget extends ConsumerStatefulWidget {
  final PostModel post;
  final void Function(Map<String, dynamic> booking)? onOpenBookingModal;
  const PostItemWidget({
    super.key,
    required this.post,
    this.onOpenBookingModal,
  });

  @override
  ConsumerState<PostItemWidget> createState() => _PostItemWidgetState();
}

// FIX: Sửa PostInputWidget thành PostItemWidget ở dòng dưới
class _PostItemWidgetState extends ConsumerState<PostItemWidget> {
  bool _showComments = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header & Content
          _buildHeader(),
          _buildContent(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppTheme.textDim,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.post.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF065F46),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final payload = {
                      'authorName': widget.post.author.fullName,
                      'authorAvatar': widget.post.author.avatarUrl,
                      'location': widget.post.location,
                      'pricePerHour': widget.post is PostModel ? 0 : 0,
                    };
                    if (widget.onOpenBookingModal != null) {
                      widget.onOpenBookingModal!(payload);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking modal not implemented'),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person_add_outlined,
                        color: Color(0xFF34D399),
                        size: 14,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'ĐẶT ĐÚNG MÁY NÀY (-10%)',
                        style: TextStyle(
                          color: Color(0xFF34D399),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.borderWhite)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAction(
                  Icons.favorite,
                  '${widget.post.likes} Yêu thích',
                  Colors.pink,
                ),

                InkWell(
                  onTap: () => setState(() => _showComments = !_showComments),
                  borderRadius: BorderRadius.circular(4),
                  child: _buildAction(
                    Icons.chat_bubble_outline,
                    '${widget.post.commentsCount} Bình luận',
                    _showComments ? Colors.cyan : AppTheme.textDim,
                  ),
                ),

                _buildAction(Icons.share_outlined, 'Chia sẻ', AppTheme.textDim),
              ],
            ),
          ),

          PostCommentSection(isOpen: _showComments),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final author = widget.post.author;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Căn lề trên để tên và avatar chuẩn
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(author.avatarUrl ?? ''),
              ),
              if (author.isVerified)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F172A),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(1),
                    child: const Icon(
                      Icons.check_circle,
                      color: Color(0xFF06B6D4),
                      size: 14,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment
                      .center, // Căn giữa theo chiều dọc các item
                  spacing: 8, // Khoảng cách ngang giữa các phần tử
                  runSpacing: 4, // Khoảng cách khi xuống dòng (nếu quá dài)
                  children: [
                    Text(
                      author.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    if (widget.post.badges != null &&
                        widget.post.badges!.isNotEmpty)
                      ...widget.post.badges!
                          .map((badgeName) => _buildBadgeWidget(badgeName))
                          .toList(),
                    _buildFollowButton(author),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.post.timestamp,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
  Widget _buildFollowButton(author) {
    bool isFollowing = author.isFollowing;

    return InkWell(
      onTap: () {
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF0891B2),
          ),
          color: isFollowing
              ? const Color(0xFF0891B2).withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isFollowing)
              const Icon(Icons.check, size: 12, color: Color(0xFF22D3EE)),
            if (!isFollowing)
              const Icon(Icons.add, size: 12, color: Color(0xFF22D3EE)),
            const SizedBox(width: 4),
            Text(
              isFollowing ? 'ĐANG THEO DÕI' : 'THEO DÕI',
              style: const TextStyle(
                color: Color(0xFF22D3EE),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBadgeWidget(String label) {
    bool isVip = label.toUpperCase() == 'VIP';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isVip ? const Color(0xFF42210B) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isVip ? const Color(0xFFEAB308) : const Color(0xFF475569),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isVip ? const Color(0xFFEAB308) : const Color(0xFF94A3B8),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          if (widget.post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: widget.post.hashtags
                  .map(
                    (tag) => Text(
                      '#$tag',
                      style: const TextStyle(color: Colors.cyan, fontSize: 12),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
class PostInputWidget extends StatelessWidget {
  final String? avatarUrl;
  const PostInputWidget({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderWhite),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white10),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                avatarUrl ??
                    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Ô nhập liệu
          Expanded(
            child: CagTextField(
              hint: 'Bạn vừa chơi ở đâu? Review ngay kiếm tiền...',
              borderRadius: 30,
              maxLines: null,
              showBorder: false,
              verticalPadding: 10,
              suffixIcon: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: AppTheme.textDim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
