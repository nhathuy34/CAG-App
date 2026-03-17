import 'package:flutter/material.dart';
import './widgets/cafe_banner_header.dart';
import './widgets/cafe_mini_card.dart';
import '../../common_widgets/hexagon_bottom_nav.dart';
import '../zone/zone_screen.dart';
import '../scan/screen.dart';

class CagGuideScreen extends StatefulWidget {
  const CagGuideScreen({super.key});

  @override
  State<CagGuideScreen> createState() => _CagGuideScreenState();
}

class _CagGuideScreenState extends State<CagGuideScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: _buildBody(),
      bottomNavigationBar: HexagonBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 2) {
            // Nút hexagon giữa → mở ScanScreen
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ScanScreen()),
            );
          } else {
            setState(() {
              _currentNavIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Banner Header ──
          const CafeBannerHeader(
            cafeName: 'Flash Gaming Center',
            matchPercentage: '98%',
            year: '2024',
            ram: '24GB',
            pcCount: '120',
            imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
          ),

          const SizedBox(height: 24),

          // ── Section: TOP TRENDING ──
          _buildSectionHeader('TOP TRENDING - QUÁN HOT TUẦN NÀY'),
          const SizedBox(height: 12),
          _buildHorizontalCafeList(_topTrendingData),

          const SizedBox(height: 32),

          // ── Section: BOM TẤN RTX 40 SERIES ──
          _buildSectionHeader('BOM TẤN RTX 40 SERIES'),
          const SizedBox(height: 12),
          _buildHorizontalCafeList(_rtx40Data),

          const SizedBox(height: 32),

          // ── Section: COUPLE ZONE ──
          _buildSectionHeader('COUPLE ZONE - LÃNG MẠN & RIÊNG TƯ'),
          const SizedBox(height: 12),
          _buildHorizontalCafeList(_coupleZoneData),

          const SizedBox(height: 32),

          // ── Section: CAG DIAMOND COLLECTION ──
          _buildDiamondSection(),

          const SizedBox(height: 16),
        ],
      ),
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

  // ── Danh sách cuộn ngang ──
  Widget _buildHorizontalCafeList(List<Map<String, dynamic>> data) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final cafe = data[index];
          return CafeMiniCard(
            cafeName: cafe['name'] as String,
            matchScore: cafe['match'] as String,
            pcCount: cafe['pc'] as String,
            ram: cafe['ram'] as String,
            imageUrl: cafe['image'] as String,
            showRankBadge: cafe['showRank'] as bool? ?? false,
            rankNumber: cafe['rankNumber'] as int?,
            showPromoBadge: cafe['showPromo'] as bool? ?? false,
            promoText: cafe['promoText'] as String?,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ZoneScreen()),
              );
            },
          );
        },
      ),
    );
  }

  // ── Section CAG Diamond Collection ──
  Widget _buildDiamondSection() {
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
              itemCount: _diamondData.length,
              itemBuilder: (context, index) {
                final cafe = _diamondData[index];
                return CafeMiniCard(
                  cafeName: cafe['name'] as String,
                  matchScore: cafe['match'] as String,
                  pcCount: cafe['pc'] as String,
                  ram: cafe['ram'] as String,
                  imageUrl: cafe['image'] as String,
                  showRankBadge: cafe['showRank'] as bool? ?? false,
                  rankNumber: cafe['rankNumber'] as int?,
                  showPromoBadge: cafe['showPromo'] as bool? ?? false,
                  promoText: cafe['promoText'] as String?,
                  onTap: () {
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

  // ══════════════════════════════════════════
  // MOCK DATA
  // ══════════════════════════════════════════

  final List<Map<String, dynamic>> _topTrendingData = [
    {
      'name': 'Gaming House Pro',
      'match': '4.8',
      'pc': '100',
      'ram': '32',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400',
      'showRank': false,
    },
    {
      'name': 'Speed Gaming 2',
      'match': '4.5',
      'pc': '80',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400',
      'showRank': false,
    },
    {
      'name': 'Flash Gaming Center',
      'match': '5.0',
      'pc': '120',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
      'showRank': true,
      'rankNumber': 10,
      'showPromo': true,
      'promoText': 'NẠP TẶNG 50%',
    },
  ];

  final List<Map<String, dynamic>> _rtx40Data = [
    {
      'name': 'Flash Gaming Center',
      'match': '5.0',
      'pc': '120',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
      'showRank': true,
      'rankNumber': 10,
      'showPromo': true,
      'promoText': 'NẠP TẶNG 50',
    },
    {
      'name': 'Speed Gaming 2',
      'match': '4.5',
      'pc': '60',
      'ram': '32',
      'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400',
      'showRank': false,
    },
    {
      'name': 'Gaming House',
      'match': '4.0',
      'pc': '80',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400',
      'showRank': false,
    },
  ];

  final List<Map<String, dynamic>> _coupleZoneData = [
    {
      'name': 'Flash Gaming Center',
      'match': '5.0',
      'pc': '24',
      'ram': '32',
      'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
      'showRank': true,
      'rankNumber': 10,
      'showPromo': true,
      'promoText': 'NẠP TẶNG 50',
    },
    {
      'name': 'Speed Gaming 2',
      'match': '4.5',
      'pc': '60',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400',
      'showRank': false,
    },
    {
      'name': 'Gaming House',
      'match': '4.0',
      'pc': '80',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400',
      'showRank': false,
    },
  ];

  final List<Map<String, dynamic>> _diamondData = [
    {
      'name': 'Flash Gaming Center',
      'match': '5.0',
      'pc': '120',
      'ram': '24',
      'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
      'showRank': true,
      'rankNumber': 10,
      'showPromo': true,
      'promoText': 'NẠP TẶNG 50',
    },
  ];
}
