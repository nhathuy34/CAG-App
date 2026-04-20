import 'package:flutter/material.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ĐÁNH GIÁ MỚI NHẤT',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text('HuyMe',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  Row(children: List.generate(5, (_) => const Icon(Icons.star, color: Colors.amber, size: 12))),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                  '"Máy mạnh chiến Wukong max setting ngon lành. Ghế hơi cứng xíu nhưng sạch sẽ."',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: const Color(0xFF2979FF), borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Text('Trả lời nhanh (AI Suggest)',
                        style: TextStyle(
                            color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
