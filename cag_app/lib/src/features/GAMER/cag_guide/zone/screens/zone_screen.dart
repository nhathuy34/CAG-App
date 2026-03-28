import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../common_widgets/hexagon_bottom_nav.dart';
import '../../../home/providers/nav_provider.dart';
import '../../../scan/screens/scan_screen.dart';
import '../providers/zone_provider.dart';
import '../widgets/zone_card.dart';
import '../widgets/utility_card.dart';
import '../../map/screens/map_screen.dart';

class ZoneScreen extends ConsumerWidget {
  const ZoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNavIndex = ref.watch(navIndexProvider);
    final zonesAsync = ref.watch(zonesProvider);
    final utilitiesAsync = ref.watch(utilitiesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1321),
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: Opacity(
              opacity: 0.2,
              child: Image.network(
                'https://img.freepik.com/free-photo/view-illuminated-neon-gaming-keyboard-setup_23-2149529350.jpg',
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) =>
                    Container(color: const Color(0xFF0D1321)),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  _buildHeader(),
                  _buildNeonButton(),
                  const SizedBox(height: 20),

                  _titleBar("CHỌN KHU VỰC CHƠI (ZONES)"),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 420,
                    child: zonesAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(
                        child: Text(
                          'Lỗi: $err',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      data: (zones) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: zones.length,
                        itemBuilder: (context, index) =>
                            ZoneCard(zone: zones[index]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleBar("TIỆN ÍCH MỞ RỘNG"),
                        const SizedBox(height: 10),
                        const Text(
                          "HƠN CẢ MỘT CHỖ NGỒI. ĐÂY LÀ HỆ SINH THÁI GAMING TOÀN DIỆN",
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                        const SizedBox(height: 25),

                        utilitiesAsync.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (err, stack) =>
                              Center(child: Text('Lỗi: $err')),
                          data: (utilities) => GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1.0,
                                ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: utilities.length,
                            itemBuilder: (context, index) =>
                                UtilityCard(utility: utilities[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            "THƯ VIỆN ẢNH & TRAILER",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _imageBox(),
                            const SizedBox(width: 10),
                            _imageBox(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _imageBox(),
                            const SizedBox(width: 10),
                            _imageBox(),
                          ],
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const MapScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.map_outlined),
                          label: const Text(
                            "XEM BẢN ĐỒ CHỈ ĐƯỜNG",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBar(String text) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageBox() {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2035),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.image_outlined,
          color: Colors.white24,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FLASH GAMING CENTER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            children: [
              _buildBadge("💎 CAG DIAMOND", Colors.blue),
              _buildBadge("✅ PRO INSTALLED", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNeonButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF00FF7F),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          "GIỮ VỊ TRÍ CỦA NHÀ VÔ ĐỊCH",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
