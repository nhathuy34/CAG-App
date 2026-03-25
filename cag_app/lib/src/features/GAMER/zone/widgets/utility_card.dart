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
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF11141E), 
              shape: BoxShape.circle
            ),
            child: Icon(
              utility.icon, 
              color: Colors.blueAccent, 
              size: 24
            ),
          ),
          const SizedBox(height: 12),
          
          // Tiêu đề
          Text(
            utility.title, 
            textAlign: TextAlign.center, 
            style: const TextStyle(
              color: Colors.white, // Chữ trắng hết
              fontWeight: FontWeight.w900, 
              fontSize: 13
            )
          ),
          const SizedBox(height: 4),
          
          // Mô tả
          Text(
            utility.subtitle, 
            textAlign: TextAlign.center, 
            style: const TextStyle(color: Colors.grey, fontSize: 10), 
            maxLines: 2
          ),
        ],
      ),
    );
  }
}