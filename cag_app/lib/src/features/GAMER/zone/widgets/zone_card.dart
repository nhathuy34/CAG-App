import 'package:CAG_App/src/models/zone_model.dart';
import 'package:flutter/material.dart';

class ZoneCard extends StatelessWidget {
  final ZoneModel zone;
  const ZoneCard({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270, margin: const EdgeInsets.only(right: 20), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2035), borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(zone.title, style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Row(
            children: [
              _priceItem("VÃNG LAI", zone.priceGuest, Colors.white),
              const SizedBox(width: 25),
              _priceItem("HỘI VIÊN", zone.priceMember, Colors.orange),
            ],
          ),
          const SizedBox(height: 25),
          _specRow(Icons.memory, "CPU", zone.cpu),
          const SizedBox(height: 12),
          _specRow(Icons.vibration, "VGA", zone.vga),
          const SizedBox(height: 12),
          _specRow(Icons.monitor, "MÀN", zone.monitor),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, minimumSize: const Size(double.infinity, 50),
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
        Icon(icon, size: 16, color: Colors.blueGrey), const SizedBox(width: 10),
        Text("$label: ", style: const TextStyle(color: Colors.grey, fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}