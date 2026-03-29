import 'package:flutter/material.dart';

class CreateRoomBannerWidget extends StatelessWidget {
  const CreateRoomBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF064E3B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF059669)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.group_add_outlined, color: Color(0xFF34D399)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'TÌM ĐỒNG ĐỘI - LEO RANK',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Đừng chơi một mình! Tìm team hợp cạ ngay.',
                  style: TextStyle(color: Color(0xFF34D399), fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF059669),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: const Color(0xFF059669).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.add, color: Colors.white, size: 18),
                SizedBox(width: 4),
                Text('TẠO PHÒNG', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamCardWidget extends StatelessWidget {
  const TeamCardWidget({
    super.key,
    required this.gameName,
    required this.title,
    required this.hostName,
    required this.location,
    required this.time,
    required this.slots,
    required this.progress,
  });

  final String gameName;
  final String title;
  final String hostName;
  final String location;
  final String time;
  final String slots;
  final double progress;

  @override
  Widget build(BuildContext context) {
    Color gameColor = gameName == 'CS:GO 2' ? const Color(0xFFCA8A04) : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network('https://picsum.photos/seed/${gameName.hashCode}/50', width: 45, height: 45, fit: BoxFit.cover),
              ),
              const Spacer(),
              _buildGameTag(gameName, gameColor),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text('Host: $hostName', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_outlined, location),
          const SizedBox(height: 4),
          _buildInfoRow(Icons.access_time, time),
          const SizedBox(height: 4),
          _buildInfoRow(Icons.mic_none, 'Micro: Bắt buộc'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('SLOT', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 9, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(slots, style: const TextStyle(color: Color(0xFF34D399), fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.black26,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              child: const Text('THAM GIA'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameTag(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFF0EA5E9)),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10))),
      ],
    );
  }
}
