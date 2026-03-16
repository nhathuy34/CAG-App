import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTabIndex = 0;

  // Khai báo biến
  String _userName = 'Lương Quang Vinh';
  String _userPhone = '0909000999';
  String _userAvatar = 'https://picsum.photos/200';

  void _updateProfileData(String newName, String newPhone, String newAvatar) {
    setState(() {
      _userName = newName;
      _userPhone = newPhone;
      _userAvatar = newAvatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double navBarHeight = 70.0;

    return Scaffold(
      backgroundColor: const Color(0xFF050A15),

      body: Stack(
        children: [
          // 1. LỚP DƯỚI CÙNG: Nội dung
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              // Đã gọt bớt padding dưới cùng để nội dung ôm sát hơn
              bottom: navBarHeight + 60.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(userName: _userName, userAvatar: _userAvatar),
                const SizedBox(height: 24),
                const FindMatchButton(),
                const SizedBox(height: 24),
                CustomTabBar(
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 24),
                if (_selectedTabIndex == 0) ...[
                  const PerformanceStatsCard(),
                  const SizedBox(height: 20),
                  const AccessPassCard(),
                  const SizedBox(height: 20),
                  const SystemLogsSection(),
                ] else if (_selectedTabIndex == 1) ...[
                  const WalletSection(),
                ] else if (_selectedTabIndex == 2) ...[
                  const LootBoxSection(),
                ] else if (_selectedTabIndex == 3) ...[
                  const SizedBox(height: 40), // Đẩy menu xuống thấp cho đẹp
                  SystemSection(
                    userName: _userName,
                    userPhone: _userPhone,
                    userAvatar: _userAvatar,
                    onUpdateProfile: _updateProfileData,
                  ),
                  const SizedBox(height: 300), //
                ],
              ],
            ),
          ),

          // 2. LỚP THỨ HAI: Thanh Navbar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(height: navBarHeight),
          ),

          // 3. LỚP THỨ BA: 2 Nút nổi (ĐÃ HẠ XUỐNG SÁT NAVBAR)
          Positioned(
            left: 20,
            bottom: navBarHeight + 45, // Hạ xuống đè lên navbar 10px
            child: const SystemViewDropdown(),
          ),
          Positioned(
            right: 20,
            bottom: navBarHeight + 45, // Hạ nút xanh xuống đè lên navbar 15px
            child: const ActionFloatingButton(),
          ),

          // 4. LỚP TRUNG TÂM: Nút Lục giác
          Positioned(
            left: 0,
            right: 0,
            bottom: navBarHeight - 45,
            child: const Center(child: HexagonActionButton()),
          ),
        ],
      ),
    );
  }
}

class HexagonActionButton extends StatelessWidget {
  const HexagonActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 80,
        height: 90,
        child: CustomPaint(
          painter: _HexagonPainter(),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              child: const Icon(
                Icons.gps_fixed,
                color: Color(0xFF00FFCC),
                size: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = const Color(0xFF0A111A)
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = const Color(0xFF00FFCC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double w = size.width;
    double h = size.height;

    Path hexPath = Path();
    hexPath.moveTo(w * 0.5, 0);
    hexPath.lineTo(w, h * 0.25);
    hexPath.lineTo(w, h * 0.75);
    hexPath.lineTo(w * 0.5, h);
    hexPath.lineTo(0, h * 0.75);
    hexPath.lineTo(0, h * 0.25);
    hexPath.close();

    canvas.drawPath(hexPath, fillPaint);

    Path highlightPath = Path();
    highlightPath.moveTo(0, h * 0.75);
    highlightPath.lineTo(0, h * 0.25);
    highlightPath.moveTo(w, h * 0.25);
    highlightPath.lineTo(w, h * 0.75);
    canvas.drawPath(highlightPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF007BFF), width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  userAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF1E2638),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -6,
              right: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF00A3FF)),
                ),
                child: Text(
                  'LVL.8',
                  style: GoogleFonts.rajdhani(
                    color: const Color(0xFF00A3FF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'ID:',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '#LUONGVINH3969',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      'DIAMOND',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(width: 2, height: 12, color: Colors.white24),
                  const SizedBox(width: 16),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB800),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '8,888 PTS',
                    style: GoogleFonts.rajdhani(
                      color: const Color(0xFFFFB800),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FindMatchButton extends StatelessWidget {
  const FindMatchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF19376D)),
      ),
      child: Center(
        child: Text(
          'FIND MATCH',
          style: GoogleFonts.rajdhani(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        children: [
          _buildTabItem(0, 'OVERVIEW', isLast: false),
          _buildTabItem(1, 'WALLET', isLast: false),
          _buildTabItem(2, 'LOOT BOX', isLast: false),
          _buildTabItem(3, 'SYSTEM', isLast: true), // Cờ đánh dấu tab cuối
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label, {required bool isLast}) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: CustomPaint(
          painter: isSelected ? _TabSlantPainter(isLastTab: isLast) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.rajdhani(
                  color: isSelected ? const Color(0xFF00C4FF) : Colors.white38,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabSlantPainter extends CustomPainter {
  final bool isLastTab;

  _TabSlantPainter({required this.isLastTab});

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..color = const Color(0xFF1B2436)
      ..style = PaintingStyle.fill;
    Paint strokePaint = Paint()
      ..color = const Color(0xFF00C4FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();
    Path borderPath = Path();

    if (isLastTab) {
      // Vát chéo ở bên TRÁI cho Tab cuối cùng
      path.moveTo(0, size.height);
      path.lineTo(20, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.close();

      borderPath.moveTo(0, size.height);
      borderPath.lineTo(20, 0);
      borderPath.lineTo(size.width, 0);
    } else {
      // Vát chéo ở bên PHẢI cho các Tab khác
      path.moveTo(0, size.height);
      path.lineTo(0, 4);
      path.lineTo(4, 0);
      path.lineTo(size.width - 20, 0);
      path.lineTo(size.width, size.height);
      path.close();

      borderPath.moveTo(0, 4);
      borderPath.lineTo(4, 0);
      borderPath.lineTo(size.width - 20, 0);
      borderPath.lineTo(size.width, size.height);
    }

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(borderPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

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

class SystemViewDropdown extends StatelessWidget {
  const SystemViewDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF00FFCC),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'SYSTEM VIEW: ',
            style: GoogleFonts.rajdhani(
              color: Colors.white54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'GAMER',
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white54,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class ActionFloatingButton extends StatelessWidget {
  const ActionFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF00C4FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x6600C4FF),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.dashboard_customize, color: Colors.black, size: 28),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4D4D),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF00C4FF), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final double height;
  const CustomBottomNavBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F19),
        border: Border(top: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_outlined, 'Cộng Đồng', true),
          _buildNavItem(Icons.cloud_outlined, 'Cloud Save', false),
          const SizedBox(width: 80),
          _buildNavItem(Icons.security, 'CAG Guide', false),
          _buildNavItem(Icons.person_outline, 'Hồ Sơ', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF626A7C),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: isSelected ? Colors.white : const Color(0xFF626A7C),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
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

class SystemSection extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String userAvatar;
  final Function(String, String, String) onUpdateProfile;

  const SystemSection({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userAvatar,
    required this.onUpdateProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          _buildSystemRow(
            'EDIT PROFILE DATA',
            actionWidget: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 14,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => UpdateOperatorDialog(
                  initialName: userName,
                  initialPhone: userPhone,
                  initialAvatar: userAvatar,
                  onSave: onUpdateProfile,
                ),
              );
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'SECURITY PROTOCOL',
            actionWidget: Text(
              'ENCRYPTED',
              style: GoogleFonts.rajdhani(
                color: const Color(0xFF00FF66),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'LINKED ACCOUNT',
            actionWidget: Text(
              'GOOGLE, FACEBOOK',
              style: GoogleFonts.rajdhani(color: Colors.white38, fontSize: 12),
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'TERMINATE SESSION',
            textColor: const Color(0xFFFF4D4D),
            actionWidget: const Icon(
              Icons.logout,
              color: Color(0xFFFF4D4D),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemRow(
    String title, {
    Widget? actionWidget,
    Color textColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.rajdhani(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            if (actionWidget != null) actionWidget,
          ],
        ),
      ),
    );
  }
}

class UpdateOperatorDialog extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialAvatar;
  final Function(String, String, String) onSave;

  const UpdateOperatorDialog({
    super.key,
    required this.initialName,
    required this.initialPhone,
    required this.initialAvatar,
    required this.onSave,
  });

  @override
  State<UpdateOperatorDialog> createState() => _UpdateOperatorDialogState();
}

class _UpdateOperatorDialogState extends State<UpdateOperatorDialog> {
  late TextEditingController _companyController;
  late TextEditingController _phoneController;
  late String _currentAvatar;

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _currentAvatar = widget.initialAvatar;
  }

  @override
  void dispose() {
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleChangeAvatar() {
    setState(() {
      _currentAvatar =
          'https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1426),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      color: const Color(0xFF00C4FF),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'UPDATE OPERATOR DATA',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white54,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: _handleChangeAvatar,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _currentAvatar,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 64,
                          height: 64,
                          color: Colors.white12,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white38,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00C4FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildEditableInputField('COMPANY', _companyController),
            const SizedBox(height: 16),
            _buildEditableInputField(
              'COMM. (PHONE)',
              _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                widget.onSave(
                  _companyController.text,
                  _phoneController.text,
                  _currentAvatar,
                );
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C4FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'SAVE CHANGES',
                    style: GoogleFonts.rajdhani(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableInputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
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
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF050A15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: const Color(0xFF00C4FF),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
