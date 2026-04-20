import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:flutter/material.dart';

class ZoneCard extends StatelessWidget {
  final ZoneModel zone;
  const ZoneCard({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    final bool isVip = zone.title.toUpperCase().contains('VIP');
    final Color mainColor = isVip ? const Color(0xFFFFC107) : const Color(0xFF4285F4);
    final Color bgColor = const Color(0xFF1E2330);

    return Container(
      width: 290, 
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: bgColor, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: mainColor.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card (Tên Zone & Tag Còn chỗ)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    zone.title, 
                    style: TextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(4)),
                  child: const Text("CÒN CHỖ", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          
          // Row Giá tiền
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _priceCol("KHÁCH VÃNG LAI", zone.priceGuest, Colors.white, 24),
                Container(margin: const EdgeInsets.symmetric(horizontal: 15), width: 1, height: 35, color: Colors.white12),
                _priceCol("HỘI VIÊN", zone.priceMember, const Color(0xFFFFC107), 18),
              ],
            ),
          ),
          
          const Divider(color: Colors.white12, height: 30, thickness: 1),

          // Lưới Thông số (Grid Specs) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10, runSpacing: 10,
              children: [
                _buildSpecBox(Icons.memory, "CPU", zone.cpu, mainColor),
                _buildSpecBox(Icons.rocket_launch, "VGA", zone.vga, mainColor),
                _buildSpecBox(Icons.monitor, "MÀN HÌNH", zone.monitor, mainColor),
                _buildSpecBox(Icons.keyboard, "GEAR", zone.gear, mainColor),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Quà tặng
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGiftRow(isVip ? "Màn hình cong" : "Ghế Gaming"),
                const SizedBox(height: 8),
                _buildGiftRow(isVip ? "Ghế ngả lưng" : "Màn hình phẳng"),
              ],
            ),
          ),

          const Spacer(),

          // Nút Đặt máy -> Hiện snackbar đang phát triển
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tính năng đặt máy đang phát triển')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor, foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("ĐẶT MÁY NGAY", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCol(String label, String price, Color priceColor, double priceSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(price, style: TextStyle(color: priceColor, fontSize: priceSize, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildSpecBox(IconData iconData, String label, String value, Color valueColor) {
    return Container(
      width: 115, padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF141824), borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10)
      ),
      child: Row(
        children: [
          Icon(iconData, color: Colors.pinkAccent, size: 16),
          const SizedBox(width: 8),
          Expanded( // Thêm Expanded để chữ dài bị cắt chứ ko làm nát UI
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                Text(value, style: TextStyle(color: valueColor, fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGiftRow(String text) {
    return Row(
      children: [
        const Text("🎁", style: TextStyle(fontSize: 12)), 
        const SizedBox(width: 8), 
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13))
      ],
    );
  }
}
