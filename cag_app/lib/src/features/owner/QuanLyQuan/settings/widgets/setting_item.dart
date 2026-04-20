import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color trailingColor;
  final bool isLast;

  const SettingItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingColor = Colors.grey,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
            bottom: isLast ? BorderSide.none : BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(subtitle,
              style: TextStyle(color: trailingColor, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
