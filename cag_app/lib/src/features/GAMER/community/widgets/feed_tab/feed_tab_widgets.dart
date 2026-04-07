import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- IMPORTS CỦA BẠN ---
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/models/post_model.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/feed_tab/postcomment_section.dart'; 
// (Lưu ý: Nếu PostCommentSection đang nằm cùng file này thì bạn XÓA DÒNG IMPORT TRÊN đi để tránh lỗi)

// =====================================================================
// 1. QUEST CARD
// =====================================================================
class QuestCard extends StatelessWidget {
  final QuestModel quest;
  const QuestCard({super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProviderScope.containerOf(context).read(navIndexProvider.notifier).setIndex(3);
      },
      child: Container(
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
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    quest.shopName,
                    style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF064E3B).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          quest.reward,
                          style: const TextStyle(color: Color(0xFF4ADE80), fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                      Text(
                        quest.deadline,
                        style: const TextStyle(color: Color(0xFFF87171), fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 2. POST ITEM WIDGET
// =====================================================================
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

class _PostItemWidgetState extends ConsumerState<PostItemWidget> {
  bool _showComments = false;
  late bool _isFollowing;

  // Quản lý thả tim
  late int _likeCount;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    // KIỂM TRA XEM ĐÃ CÓ TRONG KHO THEO DÕI CHƯA
    final followingList = ref.read(followingListProvider);
    bool isAlreadyFollowed = followingList.any((p) => p.author.fullName == widget.post.author.fullName);
    _isFollowing = widget.post.author.isFollowing || isAlreadyFollowed;
    
    // Khởi tạo lượt tim
    _likeCount = int.tryParse(widget.post.likes.toString()) ?? 0;
  }

  // Hàm dùng chung để kiểm tra auth cho Tim / Bình luận / Chia sẻ
  void _handleAuthAction(VoidCallback action) {
    final authState = ref.read(authStateProvider);
    if (authState == null) {
      // Chưa đăng nhập -> Hiện popup
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black26,
          pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        ),
      );
    } else {
      // Đã đăng nhập -> Cho phép hành động
      action();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2636),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),         
          if (widget.post.content.toLowerCase().contains("test khu thi đấu")) 
            _buildRatingBox(),
          if (widget.post.content.toLowerCase().contains("giảm giá 50%"))
            _buildImage(),
          if (widget.post.location.isNotEmpty) 
            _buildBookingSection(),
          _buildFooterActions(),
          PostCommentSection(isOpen: _showComments),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final author = widget.post.author;
    
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + Tích xanh
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(author.avatarUrl ?? 'https://picsum.photos/200'),
              ),
              if (author.isVerified)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E2636),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.check_circle, color: Color(0xFF06B6D4), size: 14),
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
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Text(
                      author.fullName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
                    ),
                    if (widget.post.badges.isNotEmpty)
                      ...widget.post.badges.map((badge) => _buildBadgeWidget(badge)),
                    _buildFollowButton(), 
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.post.timestamp,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
          
          // Nút 3 chấm
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF64748B), size: 20),
            color: const Color(0xFF1F2937),
            onSelected: (_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đang phát triển')));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'report', child: Text('Tố cáo bài viết', style: TextStyle(color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }

  // --- NỘI DUNG ---
  Widget _buildContent() {
    bool isFeatured = widget.post.content.toLowerCase().contains("cag guide - pro gaming");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFeatured) ...[
            _buildFeaturedBadge(),
            const SizedBox(height: 8),
          ],
          Text(
            widget.post.content,
            style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 14, height: 1.4),
          ),
          if (widget.post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: widget.post.hashtags.map((tag) => Text(
                '#$tag',
                style: const TextStyle(color: Color(0xFF06B6D4), fontSize: 13, fontWeight: FontWeight.w500),
              )).toList(),
            ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // --- ẢNH ---
  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Image.network(
        'https://picsum.photos/800/400',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  // --- BẢNG ĐÁNH GIÁ ---
  Widget _buildRatingBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF141B26), 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRatingItem('4.5', 'ĐIỂM TB', isMain: true),
          Container(width: 1, height: 30, color: Colors.white10),
          _buildRatingItem('5', 'Cấu hình'),
          _buildRatingItem('5', 'Không gian'),
          _buildRatingItem('4', 'Phục vụ'),
          _buildRatingItem('4', 'Giá'),
        ],
      ),
    );
  }

  Widget _buildRatingItem(String score, String label, {bool isMain = false}) {
    return Column(
      children: [
        Text(
          score,
          style: TextStyle(
            color: isMain ? const Color(0xFFEAB308) : Colors.white,
            fontSize: isMain ? 22 : 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 10),
        ),
      ],
    );
  }

  // --- ĐỊA ĐIỂM & ĐẶT MÁY ---
  Widget _buildBookingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 16),
              const SizedBox(width: 4),
              const Text('Địa điểm: ', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
              Text(
                widget.post.location,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Nhảy tab 3 (CAG Guide)
                ProviderScope.containerOf(context).read(navIndexProvider.notifier).setIndex(3);
              },
              icon: const Icon(Icons.person_add_alt_1, color: Colors.white, size: 18),
              label: const Text(
                'ĐẶT ĐÚNG MÁY NÀY (-10%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- FOOTER (Thả tim, Bình luận) ---
  Widget _buildFooterActions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // NÚT THẢ TIM
          InkWell(
            onTap: () => _handleAuthAction(() {
              setState(() {
                _isLiked = !_isLiked;
                _isLiked ? _likeCount++ : _likeCount--;
              });
            }),
            child: _buildActionItem(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              '$_likeCount Yêu thích', 
              _isLiked ? const Color(0xFFF43F5E) : const Color(0xFF94A3B8),
            ),
          ),
          
          // NÚT BÌNH LUẬN
          InkWell(
            onTap: () => _handleAuthAction(() {
              setState(() => _showComments = !_showComments);
            }),
            child: _buildActionItem(
              Icons.chat_bubble_outline, 
              '${widget.post.commentsCount} Bình luận', 
              const Color(0xFF94A3B8),
            ),
          ),
          
          // NÚT CHIA SẺ
          InkWell(
            onTap: () => _handleAuthAction(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tính năng chia sẻ đang phát triển')),
              );
            }),
            child: _buildActionItem(
              Icons.share_outlined, 
              'Chia sẻ', 
              const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // --- CÁC WIDGET BỔ TRỢ ---
  Widget _buildBadgeWidget(String label) {
    bool isVip = label.toUpperCase() == 'VIP';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isVip ? Colors.transparent : const Color(0xFF334155),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isVip ? const Color(0xFFEAB308) : Colors.transparent, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isVip ? const Color(0xFFEAB308) : Colors.white,
          fontSize: 10,
          fontWeight: isVip ? FontWeight.w900 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFollowButton() {
    return InkWell(
      onTap: () {
        // --- 1. KIỂM TRA ĐĂNG NHẬP TRƯỚC ---
        final authState = ref.read(authStateProvider);
        if (authState == null) {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.black26,
              pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
              transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
            ),
          );
          return;
        }

        // --- 2. XỬ LÝ NẾU ĐANG THEO DÕI -> BẤM ĐỂ HỦY THEO DÕI ---
        if (_isFollowing) {
          setState(() {
            _isFollowing = false; // Đổi UI về lại "THEO DÕI"
          });
          ref.read(followingListProvider.notifier).removePost(widget.post.author.fullName);
          return; 
        }

        // --- 3. XỬ LÝ NẾU CHƯA THEO DÕI -> BẤM ĐỂ THEO DÕI ---
        setState(() {
          _isFollowing = true; // Đổi UI thành "ĐANG THEO DÕI"
        });

        ref.read(followingListProvider.notifier).addPost(widget.post);

        Future.delayed(const Duration(milliseconds: 300), () {
          ref.read(communityTabIndexProvider.notifier).state = 1;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF06B6D4)),
          color: _isFollowing ? const Color(0xFF06B6D4).withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isFollowing) ...[
              const Icon(Icons.check, size: 12, color: Color(0xFF06B6D4)),
              const SizedBox(width: 4),
            ],
            if (!_isFollowing) ...[
              const Icon(Icons.add, size: 12, color: Color(0xFF06B6D4)),
              const SizedBox(width: 4),
            ],
            Text(
              _isFollowing ? 'ĐANG THEO DÕI' : 'THEO DÕI',
              style: const TextStyle(color: Color(0xFF06B6D4), fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)]),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.star, color: Colors.white, size: 12),
          SizedBox(width: 4),
          Text('FEATURED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

// =====================================================================
// 3. Ô NHẬP LIỆU (POST INPUT)
// =====================================================================
class PostInputWidget extends ConsumerWidget {
  final String? avatarUrl;
  const PostInputWidget({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // KIỂM TRA ĐĂNG NHẬP TRƯỚC
        final authState = ref.read(authStateProvider);
        if (authState == null) {
          // Chưa đăng nhập -> Hiện màn hình đăng nhập
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.black26,
              pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
              transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
            ),
          );
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tính năng tạo bài viết đang phát triển')),
        );
      },
      child: AbsorbPointer(
        child: Container(
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
                    avatarUrl ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: CagTextField(
                  hint: 'Bạn vừa chơi ở đâu? Review ngay kiếm tiền...',
                  borderRadius: 30,
                  maxLines: null,
                  showBorder: false,
                  verticalPadding: 10,
                  suffixIcon: Icon(Icons.edit_outlined, size: 18, color: AppTheme.textDim),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}