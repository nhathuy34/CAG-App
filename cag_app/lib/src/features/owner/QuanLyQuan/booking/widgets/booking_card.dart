import 'package:flutter/material.dart';
import '../../../../../models/owner_models.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final String activeTab;

  const BookingCard({
    super.key,
    required this.booking,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${booking.avatar}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      booking.member,
                      style: TextStyle(
                        color: _getMemberColor(booking.member),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (activeTab == 'lichsu') _buildStatusBadge(booking.status),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.laptop, '${booking.room} (${booking.roomType})'),
          const SizedBox(height: 4),
          _buildInfoRow(Icons.access_time, booking.time),
          if (booking.note.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                booking.note,
                style: const TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const Spacer(),
          if (activeTab == 'choduyet')
            Row(
              children: [
                Expanded(
                  child: _buildButton('Từ chối', Colors.red.withOpacity(0.1), Colors.red),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildButton('Duyệt', const Color(0xFF2979FF).withOpacity(0.1), const Color(0xFF2979FF)),
                ),
              ],
            )
          else if (activeTab == 'sapden')
            _buildButton('Check-in', const Color(0xFF00E676).withOpacity(0.1), const Color(0xFF00E676), width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, {double? width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    Color color;
    String text;
    switch (status) {
      case 'completed':
        color = Colors.green;
        text = 'Hoàn thành';
        break;
      case 'cancelled':
        color = Colors.orange;
        text = 'Đã hủy';
        break;
      case 'rejected':
        color = Colors.red;
        text = 'Từ chối';
        break;
      default:
        color = Colors.grey;
        text = 'NaN';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getMemberColor(String member) {
    if (member.contains('GOLD')) return Colors.amber;
    if (member.contains('DIAMOND')) return Colors.cyan;
    if (member.contains('SILVER')) return Colors.grey;
    return Colors.brown;
  }
}
