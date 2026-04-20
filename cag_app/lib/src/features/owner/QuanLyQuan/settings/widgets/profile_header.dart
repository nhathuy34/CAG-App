import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                  colors: [Color(0xFFFFD700), Colors.orange, Color(0xFFFFD700)]),
              border: Border.all(color: const Color(0xFF1E1E1E), width: 2),
              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.2), blurRadius: 10)],
            ),
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=68'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('NGUYỄN VĂN CHỦ',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
              const Text('CAG DIAMOND PARTNER',
                  style: TextStyle(
                      color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green.withOpacity(0.3))),
                child: const Text('VERIFIED OWNER',
                    style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
