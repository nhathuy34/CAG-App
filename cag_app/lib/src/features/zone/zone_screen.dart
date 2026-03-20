import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../navigation_provider.dart';
import '../scan/screen.dart';
import '../../common_widgets/hexagon_bottom_nav.dart';

class ZoneScreen extends ConsumerStatefulWidget {
  const ZoneScreen({super.key});

  @override
  ConsumerState<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends ConsumerState<ZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1321),
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
                errorBuilder: (ctx, err, st) => Container(color: const Color(0xFF0D1321)),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Khoảng trống cho navigation bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nút Back - Chỉ hiển thị nếu có thể pop (được push từ nơi khác)
                  if (Navigator.of(context).canPop())
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: const [
                        ZoneCard(
                          title: "ZONE STANDARD",
                          priceGuest: "12,000đ",
                          priceMember: "10,000đ",
                          cpu: "i5 12400F",
                          vga: "RTX 3060",
                          monitor: "165Hz",
                          gear: "Full Cơ",
                        ),
                        ZoneCard(
                          title: "ZONE VIP",
                          priceGuest: "18,000đ",
                          priceMember: "15,000đ",
                          cpu: "i7 13700K",
                          vga: "RTX 4070",
                          monitor: "240Hz",
                          gear: "Logitech G",
                        ),
                        ZoneCard(
                          title: "ZONE STREAM",
                          priceGuest: "25,000đ",
                          priceMember: "20,000đ",
                          cpu: "i9 14900K",
                          vga: "RTX 4090",
                          monitor: "360Hz",
                          gear: "Razer Pro",
                        ),
                      ],
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
                        GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.2,
                          children: [
                            _buildUtilityCard(Icons.local_parking, "BÃI XE RỘNG", "Có bảo vệ trông, Free giữ xe"),
                            _buildUtilityCard(Icons.directions_car, "BÃI Ô TÔ", "Đậu xe thoải mái, an ninh 24/7"),
                            _buildUtilityCard(Icons.bathtub, "PHÒNG TẮM", "Nước nóng lạnh - Cho dân cày đêm"),
                            _buildUtilityCard(Icons.wc, "WC RIÊNG", "Nam/Nữ tách biệt, sạch sẽ"),
                            _buildUtilityCard(Icons.restaurant, "BẾP 5 SAO", "Menu phong phú, pha chế ngon"),
                            _buildUtilityCard(Icons.videocam, "PHÒNG STREAM", "Cách âm, PC 2 màn, Cam xịn"),
                          ],
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
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(children: [_imageBox(), const SizedBox(width: 10), _imageBox()]),
                        const SizedBox(height: 10),
                        Row(children: [_imageBox(), const SizedBox(width: 10), _imageBox()]),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () => _openGoogleMaps(),
                          icon: const Icon(Icons.map_outlined),
                          label: const Text("XEM BẢN ĐỒ CHỈ ĐƯỜNG", style: TextStyle(fontWeight: FontWeight.bold)),
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
      bottomNavigationBar: HexagonBottomNav(
        currentIndex: ref.watch(navigationIndexProvider),
        onTap: (index) {
          if (index == 2) {
            // Nút hexagon giữa → mở ScanScreen
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ScanScreen()),
            );
          } else {
            // Cập nhật tab qua provider
            ref.read(navigationIndexProvider.notifier).setIndex(index);
          }
        },
      ),
    );
  }

  Widget _titleBar(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Container(
            width: 5, height: 20,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilityCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2035),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 9), maxLines: 2),
        ],
      ),
    );
  }

  Widget _imageBox() {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(color: const Color(0xFF1A2035), borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.image_outlined, color: Colors.white24, size: 30),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("FLASH GAMING CENTER", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
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
      child: Text(text, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNeonButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: 55,
      decoration: BoxDecoration(color: const Color(0xFF00FF7F), borderRadius: BorderRadius.circular(15)),
      child: const Center(
        child: Text("GIỮ VỊ TRÍ CỦA NHÀ VÔ ĐỊCH", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  Future<void> _openGoogleMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/place/Trading+Service+Co.+Ltd+An+Phat+Computer+PT/@10.803913,106.714045,17z',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class ZoneCard extends StatelessWidget {
  final String title, priceGuest, priceMember, cpu, vga, monitor, gear;
  const ZoneCard({
    super.key,
    required this.title,
    required this.priceGuest,
    required this.priceMember,
    required this.cpu,
    required this.vga,
    required this.monitor,
    required this.gear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2035),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Row(
            children: [
              _priceItem("VÃNG LAI", priceGuest, Colors.white),
              const SizedBox(width: 25),
              _priceItem("HỘI VIÊN", priceMember, Colors.orange),
            ],
          ),
          const SizedBox(height: 25),
          _specRow(Icons.memory, "CPU", cpu),
          const SizedBox(height: 12),
          _specRow(Icons.vibration, "VGA", vga),
          const SizedBox(height: 12),
          _specRow(Icons.monitor, "MÀN", monitor),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("ĐẶT MÁY NGAY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _priceItem(String label, String price, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 9)),
        Text(price, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _specRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Text("$label: ", style: const TextStyle(color: Colors.grey, fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
