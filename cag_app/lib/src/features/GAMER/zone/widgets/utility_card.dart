import 'package:CAG_App/src/models/zone_model.dart';
import 'package:flutter/material.dart';

class UtilityCard extends StatelessWidget {
  final UtilityModel utility;
  const UtilityCard({super.key, required this.utility});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1A2035), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(utility.icon, color: Colors.blueAccent, size: 28), const SizedBox(height: 10),
          Text(utility.title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 4),
          Text(utility.subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 9), maxLines: 2),
        ],
      ),
    );
  }
}