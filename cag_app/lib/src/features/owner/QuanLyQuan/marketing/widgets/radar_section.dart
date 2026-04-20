import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadarSection extends StatelessWidget {
  final int occupancy;
  final Function(double) onSimulateOccupancy;

  const RadarSection({
    super.key,
    required this.occupancy,
    required this.onSimulateOccupancy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'AI ',
                              style: TextStyle(
                                  color: Color(0xFF00E676),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic)),
                          TextSpan(
                              text: 'AUTO-FILL & RADAR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    const Text(
                        'Automatically scan and attract customers when the shop is empty.',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                _buildLiveBadge(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildRadarDisplay(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildToggleRow('Activate Auto-Fill', true),
                      const SizedBox(height: 16),
                      _buildSliderControl('Trigger Threshold', 50, const Color(0xFF00E676),
                          disabled: true),
                      const SizedBox(height: 16),
                      _buildSliderControl('Simulate Occupancy', occupancy.toDouble(), Colors.amber,
                          onChanged: onSimulateOccupancy),
                      const SizedBox(height: 16),
                      _buildStatusMessage(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Color(0xFF00E676), shape: BoxShape.circle)),
          const SizedBox(width: 8),
          const Text('LIVE RADAR',
              style: TextStyle(color: Color(0xFF00E676), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRadarDisplay() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          // Grid lines
          ...List.generate(
              10,
              (i) => Positioned(
                  left: i * 40.0,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 1, color: Colors.white.withOpacity(0.02)))),
          ...List.generate(
              5,
              (i) => Positioned(
                  top: i * 40.0,
                  left: 0,
                  right: 0,
                  child: Container(height: 1, color: Colors.white.withOpacity(0.02)))),
          // Center point
          Center(
              child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.white, blurRadius: 10)]))),
          // Occupancy dots
          ..._generateDots(occupancy),
        ],
      ),
    );
  }

  List<Widget> _generateDots(int occupancy) {
    final random = math.Random(42);
    final List<Widget> dots = [];
    final int count = (10 + (occupancy / 100) * 50).toInt();

    for (int i = 0; i < count; i++) {
      dots.add(Positioned(
          left: random.nextDouble() * 200 + 40,
          top: random.nextDouble() * 140 + 30,
          child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF2979FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF2979FF).withOpacity(0.5), blurRadius: 4)
                  ]))));
    }
    return dots;
  }

  Widget _buildToggleRow(String title, bool val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        Switch(value: val, onChanged: (v) {}, activeColor: const Color(0xFF00E676)),
      ],
    );
  }

  Widget _buildSliderControl(String title, double val, Color color,
      {bool disabled = false, ValueChanged<double>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            Text('${val.toInt()}%',
                style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
            activeTrackColor: color,
            inactiveTrackColor: Colors.white10,
            thumbColor: color,
          ),
          child: Slider(
            value: val,
            min: 0,
            max: 100,
            onChanged: disabled ? null : onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFF00E676).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3))),
      child: const Text('AI Standby: Monitoring occupancy. Will trigger if below 50%.',
          style: TextStyle(color: Color(0xFF00E676), fontSize: 11)),
    );
  }
}
