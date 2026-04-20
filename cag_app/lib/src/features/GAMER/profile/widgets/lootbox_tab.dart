import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LootBoxTab extends ConsumerWidget {
  const LootBoxTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return statsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.cyanNeon),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (stats) {
        if (stats.lootBoxes.isEmpty) {
          return const Center(
            child: Text(
              "No LootBoxes available",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        // Dùng GridView thay vì LayoutBuilder phức tạp
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20, top: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.78, // Tỉ lệ chiều rộng/chiều cao để giống ảnh mẫu
          ),
          itemCount: stats.lootBoxes.length,
          itemBuilder: (context, index) {
            return _LootCard(item: stats.lootBoxes[index]);
          },
        );
      },
    );
  }
}

// ==========================================
// WIDGET THẺ LOOTBOX (CÓ HIỆU ỨNG NHẤN ĐỔI MÀU)
// ==========================================
class _LootCard extends StatefulWidget {
  final LootBoxItem item;
  const _LootCard({required this.item});

  @override
  State<_LootCard> createState() => _LootCardState();
}

class _LootCardState extends State<_LootCard> {
  bool _isCardPressed = false;
  bool _isClaimPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Bắt sự kiện nhấn xuống và nhả ra cho toàn bộ Thẻ
      onTapDown: (_) => setState(() => _isCardPressed = true),
      onTapUp: (_) => setState(() => _isCardPressed = false),
      onTapCancel: () => setState(() => _isCardPressed = false),
      onTap: () {
        // Logic khi click vào thẻ Lootbox
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(6), // Khoảng hở giữa viền và nội dung (như ảnh)
        decoration: BoxDecoration(
          color: const Color(0xFF141924), // Màu nền thẻ xanh đen mờ
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // CHỖ NÀY: Viền màu vàng khi nhấn, màu xám khi bình thường
            color: _isCardPressed ? const Color(0xFFFFC107) : const Color(0xFF2A3241),
            width: _isCardPressed ? 1.5 : 1,
          ),
          boxShadow: _isCardPressed 
              ? [BoxShadow(color: const Color(0xFFFFC107).withOpacity(0.2), blurRadius: 10)] 
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. ẢNH NỀN VÀ TAG
            Expanded(
              child: Stack(
                children: [
                  // Ảnh
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF1E2532),
                    ),
                    child: Image.network(
                      widget.item.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, color: Colors.white24),
                    ),
                  ),
                  // Tag (HOURS / FOOD / CARD)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.item.tag.toUpperCase(),
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            // 2. TIÊU ĐỀ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.item.title.toUpperCase(),
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // 3. GIÁ VÀ NÚT CLAIM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Giá (Màu vàng)
                  Text(
                    widget.item.price, // Ví dụ: "500 P"
                    style: GoogleFonts.rajdhani(
                      color: const Color(0xFFFFC107), // Vàng cam
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  
                  // Nút CLAIM có hiệu ứng đổi màu
                  GestureDetector(
                    // Bắt sự kiện nhấn xuống và nhả ra cho nút CLAIM
                    onTapDown: (_) => setState(() => _isClaimPressed = true),
                    onTapUp: (_) => setState(() => _isClaimPressed = false),
                    onTapCancel: () => setState(() => _isClaimPressed = false),
                    onTap: () {
                      // Xử lý logic CLAIM phần thưởng ở đây
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        // CHỖ NÀY: Nút đổi sang vàng khi nhấn
                        color: _isClaimPressed ? const Color(0xFFFFC107) : const Color(0xFF1E2532),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'CLAIM',
                        style: GoogleFonts.rajdhani(
                          // Chữ đổi sang đen khi nền vàng để dễ đọc
                          color: _isClaimPressed ? Colors.black : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
