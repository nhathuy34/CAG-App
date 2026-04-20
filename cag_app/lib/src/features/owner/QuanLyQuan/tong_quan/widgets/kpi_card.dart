import 'package:flutter/material.dart';

class KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String? trend;
  final Color? trendColor;
  final Color bgColor;
  final Color valueColor;
  final IconData icon;
  final double? progress;

  const KPICard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.trend,
    this.trendColor,
    required this.bgColor,
    this.valueColor = Colors.white,
    required this.icon,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: bgColor != const Color(0xFF1E1E1E)
            ? [BoxShadow(color: bgColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]
            : null,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Icon(icon, size: 60, color: Colors.white.withOpacity(0.05)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: TextStyle(
                          color: valueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Rajdhani'),
                    ),
                    TextSpan(
                      text: unit,
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (progress != null) ...[
                const SizedBox(height: 8),
                _buildProgressBar(),
              ] else if (trend != null) ...[
                const SizedBox(height: 4),
                Text(
                  trend!,
                  style: TextStyle(
                      color: trendColor ?? Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress!,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2979FF), Color(0xFF00E676)]),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
