
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Copy PerformanceStatsCard, AccessPassCard, WalletSection, LootBoxSection vào đây...

class PerformanceStatsCard extends StatelessWidget {
  const PerformanceStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(16),
        gradient: const RadialGradient(
          center: Alignment.topRight,
          radius: 1.5,
          colors: [Color(0xFF1A304D), Color(0xFF131A28)],
          stops: [0.0, 0.4],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, color: Colors.white38, size: 16),
              const SizedBox(width: 8),
              Text(
                'PERFORMANCE STATS',
                style: GoogleFonts.rajdhani(
                  color: Colors.white54,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'TRUST SCORE',
                  '100',
                  const Color(0xFF00FF66),
                  false,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'HOURS PLAYED',
                  '1,240',
                  Colors.white,
                  true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'WIN RATE',
                  '54',
                  const Color(0xFF00C4FF),
                  false,
                  suffix: '%',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'BALANCE',
                  '2,500,000',
                  const Color(0xFFFFB800),
                  false,
                  suffix: ' VND',
                  suffixSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color valueColor,
    bool hasSuffixH, {
    String? suffix,
    double? suffixSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: GoogleFonts.rajdhani(
                color: valueColor,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (hasSuffixH) ...[
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'h',
                  style: GoogleFonts.rajdhani(
                    color: Colors.white38,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            if (suffix != null) ...[
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  suffix,
                  style: GoogleFonts.rajdhani(
                    color: Colors.white38,
                    fontSize: suffixSize ?? 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class AccessPassCard extends StatelessWidget {
  const AccessPassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCESS_PASS',
                style: GoogleFonts.rajdhani(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'CAG NETWORK VERIFIED',
                style: GoogleFonts.rajdhani(
                  color: const Color(0xFF63748A),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 48),
              _buildPassDetail('ID:', '000001'),
              const SizedBox(height: 8),
              _buildPassDetail('EXP:', 'LIFETIME'),
              const SizedBox(height: 8),
              _buildPassDetail('SEC:', 'LEVEL 4'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    'C',
                    style: GoogleFonts.rajdhani(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Icon(Icons.qr_code_2, size: 80, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPassDetail(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.ibmPlexMono(color: Colors.black87, fontSize: 11),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: GoogleFonts.ibmPlexMono(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SystemLogsSection extends StatelessWidget {
  const SystemLogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SYSTEM LOGS (TRANSACTIONS)',
            style: GoogleFonts.rajdhani(
              color: Colors.white38,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),
          _buildLogItem(
            date: '2026-03-14',
            type: 'TOPUP',
            description: 'Nạp qua B...',
            amount: '+500,000',
            typeColor: const Color(0xFF00C4FF),
            amountColor: const Color(0xFF00FF66),
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildLogItem(
            date: '2026-03-13',
            type: 'PAYMENT',
            description: 'Flash Gami...',
            amount: '-50,000',
            typeColor: const Color(0xFFFF4D4D),
            amountColor: const Color(0xFFFF4D4D),
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildLogItem(
            date: '2026-03-12',
            type: 'EARNING',
            description: 'Thưởng To...',
            amount: '+150,000',
            typeColor: const Color(0xFF00FF66),
            amountColor: const Color(0xFF00FF66),
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem({
    required String date,
    required String type,
    required String description,
    required String amount,
    required Color typeColor,
    required Color amountColor,
  }) {
    final textStyle = GoogleFonts.ibmPlexMono(fontSize: 11);
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(date, style: textStyle.copyWith(color: Colors.white54)),
        ),
        Expanded(
          flex: 4,
          child: Text(
            type,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              color: typeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            description,
            textAlign: TextAlign.right,
            style: textStyle.copyWith(color: Colors.white),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            amount,
            textAlign: TextAlign.right,
            style: textStyle.copyWith(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class WalletSection extends StatelessWidget {
  const WalletSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFB800), width: 1.5),
          ),
          child: Column(
            children: [
              Text(
                'MAIN BLANCE',
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '2.500.000',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'VND',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFA67C00),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'TOP UP',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LINKED MEMBERSHIP',
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFF00FFCC), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+ ADD CARD',
                style: GoogleFonts.rajdhani(
                  color: const Color(0xFF00FFCC),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildMembershipCard(
          title: 'FLASH GAMING CENTER',
          number: '4829  1023  4512  9981',
          price: '152,000',
          memberType: 'DIAMOND MEMBER',
          imagePath: 'https://picsum.photos/seed/flash/100/100',
          isOnline: true,
        ),
        const SizedBox(height: 16),
        _buildMembershipCard(
          title: 'GAMING HOUSE PRO',
          number: '4001  2231  5566  1122',
          price: '85,000',
          memberType: 'GOLD  MEMBER',
          imagePath: 'https://picsum.photos/seed/gaming/100/100',
          isOnline: false,
        ),
        const SizedBox(height: 16),
        _buildMembershipCard(
          title: 'SPEED GAMING 2',
          number: '5123 8812 3321 0021',
          price: '12,000',
          memberType: '',
          imagePath: 'https://picsum.photos/seed/speed/100/100',
          isOnline: false,
        ),
      ],
    );
  }

  Widget _buildMembershipCard({
    required String title,
    required String number,
    required String price,
    required String memberType,
    required String imagePath,
    required bool isOnline,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (isOnline) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00FF66),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                if (number.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    number,
                    style: GoogleFonts.ibmPlexMono(
                      color: Colors.white54,
                      fontSize: 11,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'VND',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (memberType.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  memberType,
                  style: GoogleFonts.rajdhani(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class LootBoxSection extends StatelessWidget {
  const LootBoxSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - 16) / 2;
        double itemHeight = itemWidth * 1.3;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: itemWidth / itemHeight,
          children: [
            _buildLootCard(
              'FOOD',
              'MÌ TRỨNG XÚC XÍCH',
              '300 P',
              'https://picsum.photos/seed/food1/300/400',
            ),
            _buildLootCard(
              'HOURS',
              'THẺ 1 GIỜ CHƠI (VIP)',
              '800 P',
              'https://picsum.photos/seed/hours/300/400',
            ),
            _buildLootCard(
              'FOOD',
              'NƯỚC ÉP CAM',
              '150 P',
              'https://picsum.photos/seed/juice/300/400',
            ),
            _buildLootCard(
              'FOOD',
              'MÌ TRỨNG XÚC XÍCH',
              '300 P',
              'https://picsum.photos/seed/food2/300/400',
            ),
          ],
        );
      },
    );
  }

  Widget _buildLootCard(
    String tag,
    String title,
    String price,
    String imgPath,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imgPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFF1E2638)),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: GoogleFonts.rajdhani(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black87, Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.rajdhani(
                          color: const Color(0xFFFFB800),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'CLAIM',
                          style: GoogleFonts.rajdhani(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}