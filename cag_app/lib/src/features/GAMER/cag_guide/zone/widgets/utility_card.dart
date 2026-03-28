import 'package:CAG_App/src/models/zone_model.dart';
import 'package:flutter/material.dart';

class UtilityCard extends StatelessWidget {
  final UtilityModel utility;
  const UtilityCard({super.key, required this.utility});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B29),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF11141E),
              shape: BoxShape.circle,
            ),
            child: Icon(utility.icon, color: Colors.blueAccent, size: 24),
          ),
          const SizedBox(height: 8),

          Flexible(
            child: Text(
              utility.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 2),

          Flexible(
            child: Text(
              utility.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
