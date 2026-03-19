import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CafeBannerHeader extends StatelessWidget {
  final String cafeName;
  final String matchPercentage;
  final String year;
  final String ram;
  final String pcCount;
  final String imageUrl;

  const CafeBannerHeader({
    super.key,
    required this.cafeName,
    required this.matchPercentage,
    required this.year,
    required this.ram,
    required this.pcCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
          ),
          
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF020617).withOpacity(0.5), // Deep Black
                  const Color(0xFF020617),
                ],
                stops: const [0.4, 0.8, 1.0],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CAG GUIDE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Row(
                          children: [
                            Container(width: 3, height: 12, color: Colors.amber),
                            const SizedBox(width: 6),
                            const Text(
                              'ĐỊNH VỊ TINH HOA',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 10,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _openGoogleMaps(),
                          child: const Icon(Icons.explore_outlined, color: Color(0xFF00F2EA), size: 28),
                        ),
                        const SizedBox(width: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            color: Colors.white,
                            width: 30,
                            height: 30,
                            child: const Icon(Icons.access_time_filled, color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildBadge('CAG ORIGINAL', Colors.redAccent, isSolid: false),
                        const SizedBox(width: 8),
                        _buildBadge('CAG PRO CERTIFIED', const Color(0xFF00F2EA), isSolid: false, bgColor: const Color(0xFF00F2EA).withOpacity(0.2)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      cafeName.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text('$matchPercentage Match', style: const TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 13)), // Success Green
                        const SizedBox(width: 16),
                        _buildSpecText(year),
                        const SizedBox(width: 12),
                        _buildSpecText(ram, withBorder: true),
                        const SizedBox(width: 12),
                        _buildSpecText('$pcCount PC'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow, color: Colors.black),
                            label: const Text('Khám Phá', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, color: Colors.white),
                            label: const Text('Thông Tin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2), 
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color, {bool isSolid = true, Color? bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: isSolid ? color : (bgColor ?? Colors.transparent),
        border: isSolid ? null : Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSolid ? Colors.white : color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSpecText(String text, {bool withBorder = false}) {
    return Container(
      padding: withBorder ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2) : EdgeInsets.zero,
      decoration: withBorder ? BoxDecoration(
        border: Border.all(color: Colors.white54, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ) : null,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Future<void> _openGoogleMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/place/Trading+Service+Co.+Ltd+An+Phat+Computer+PT/@10.803913,106.714045,17z',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
