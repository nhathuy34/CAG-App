import 'package:flutter/material.dart';
import 'package:CAG_App/src/models/gamer_models.dart';

class CafeMiniCard extends StatelessWidget {
  final Cafe cafe;
  final VoidCallback? onTap;

  const CafeMiniCard({
    super.key,
    required this.cafe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh + Badges
          Stack(
            children: [
              // Ảnh nền
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  cafe.image,
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, st) => Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2035),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, color: Colors.white24, size: 30),
                  ),
                ),
              ),

              // Badge CAG PRO (góc trên trái)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'CAG PRO',
                    style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Badge Rank (TOP 10) - nếu có
              if (cafe.showRank && cafe.rankNumber != null)
                Positioned(
                  top: 24,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00F2EA),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'TOP ${cafe.rankNumber}',
                      style: const TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              // Badge Promo (NẠP TẶNG $) - nếu có
              if (cafe.showPromo && cafe.promoText != null)
                Positioned(
                  top: cafe.showRank ? 42 : 24,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      cafe.promoText!,
                      style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Tên quán
          Text(
            cafe.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Specs: Match Score + PC + RAM
          Row(
            children: [
              Text(
                '${cafe.match} ',
                style: const TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const Text('Match', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10)),
              const SizedBox(width: 8),
              _specBadge(cafe.pc),
              const Text(' PC', style: TextStyle(color: Colors.white54, fontSize: 9)),
              const SizedBox(width: 6),
              _specBadge(cafe.ram),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _specBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 9),
      ),
    );
  }
}
