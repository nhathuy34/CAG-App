import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/models/cafe.dart';
import '../widgets/cafe_banner_header.dart';
import '../widgets/cafe_mini_card.dart';
import '../providers/cag_guide_provider.dart';
import '../zone/screens/zone_screen.dart';

class CagGuideScreen extends ConsumerWidget {
  const CagGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: _buildBody(ref),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Banner Header ──
          const CafeBannerHeader(
            cafe: Cafe(
              name: 'Flash Gaming Center',
              match: '98%',
              pc: '120',
              ram: '24GB',
              image:
                  'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
              year: '2024',
            ),
          ),

          const SizedBox(height: 24),

          // ── Section: TOP TRENDING ──
          _buildSectionHeader('TOP TRENDING - QUÁN HOT TUẦN NÀY'),
          const SizedBox(height: 12),
          _buildTopTrendingSection(ref),

          const SizedBox(height: 32),

          // ── Section: BOM TẤN RTX 40 SERIES ──
          _buildSectionHeader('BOM TẤN RTX 40 SERIES'),
          const SizedBox(height: 12),
          _buildRtx40Section(ref),

          const SizedBox(height: 32),

          // ── Section: COUPLE ZONE ──
          _buildSectionHeader('COUPLE ZONE - LÃNG MẠN & RIÊNG TƯ'),
          const SizedBox(height: 12),
          _buildCoupleZoneSection(ref),

          const SizedBox(height: 32),

          // ── Section: CAG DIAMOND COLLECTION ──
          _buildDiamondSection(ref),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTopTrendingSection(WidgetRef ref) {
    final cafesAsync = ref.watch(topTrendingCafesProvider);
    return cafesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF00F2EA)),
      ),
      error: (err, _) => Center(
        child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (cafes) => _buildHorizontalCafeList(cafes),
    );
  }

  Widget _buildRtx40Section(WidgetRef ref) {
    final cafesAsync = ref.watch(rtx40CafesProvider);
    return cafesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF00F2EA)),
      ),
      error: (err, _) => Center(
        child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (cafes) => _buildHorizontalCafeList(cafes),
    );
  }

  Widget _buildCoupleZoneSection(WidgetRef ref) {
    final cafesAsync = ref.watch(coupleZoneCafesProvider);
    return cafesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF00F2EA)),
      ),
      error: (err, _) => Center(
        child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (cafes) => _buildHorizontalCafeList(cafes),
    );
  }

  Widget _buildDiamondSection(WidgetRef ref) {
    final cafesAsync = ref.watch(diamondCafesProvider);
    return cafesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF00F2EA)),
      ),
      error: (err, _) => Center(
        child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
      ),
      data: (cafes) => _buildDiamondList(cafes),
    );
  }

  // ── Tiêu đề section ──
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHorizontalCafeList(List<Cafe> cafes) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cafes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 220,
              child: CafeMiniCard(
                cafe: cafes[index],
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const ZoneScreen()));
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Section CAG Diamond Collection ──
  Widget _buildDiamondList(List<Cafe> cafes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CAG DIAMOND COLLECTION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'BỘ SƯU TẬP CYBER GAME CHUẨN THI ĐẤU QUỐC TẾ - CHỈ CÓ TRÊN CAG.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cafes.length,
              itemBuilder: (context, index) {
                final cafe = cafes[index];
                return CafeMiniCard(
                  cafe: cafe,
                  onTap: () {
                    // ĐÃ MỞ KHÓA CHUYỂN TRANG
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ZoneScreen()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
