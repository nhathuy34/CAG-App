import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/game_model.dart';
import '../../../../repositories/cloud_save_repository.dart';
import '../widgets/game_card.dart';
import '../widgets/neon_game_button.dart';
import 'cloud_save_detail_screen.dart'; // Mở trang detail khi bấm nút Cloud Save
import '../../cag_guide/screens/cag_guide_screen.dart';

class CloudSaveScreen extends StatefulWidget {
  const CloudSaveScreen({super.key});

  @override
  State<CloudSaveScreen> createState() => _CloudSaveScreenState();
}

class _CloudSaveScreenState extends State<CloudSaveScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  String _currentTime = "";
  final CloudSaveRepository _repository = CloudSaveRepository();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fireworksController;

  List<GameModel> _allGames = [];
  List<GameModel> _filteredGames = [];
  String _activeTab = "TẤT CẢ (IDC)";
  bool _isLoading = true;
  bool _showDiamondCard = false;

  // final List<GameModel> _toolsList = [
  //   GameModel(
  //     title: "DISCORD",
  //     location: "TOOLS",
  //     imageUrl: "",
  //     progressValue: "2026-03-20 17:32:21",
  //     rank: "TOOLS",
  //   ),
  //   GameModel(
  //     title: "LGHUB",
  //     location: "TOOLS",
  //     imageUrl: "",
  //     progressValue: "2026-02-25 14:03:13",
  //     rank: "TOOLS",
  //   ),
  //   GameModel(
  //     title: "VANGUARD ANTI CAG",
  //     location: "TOOLS",
  //     imageUrl: "",
  //     progressValue: "2026-02-20 11:36:09",
  //     rank: "TOOLS",
  //   ),
  //   GameModel(
  //     title: "FIREFOX",
  //     location: "TOOLS",
  //     imageUrl: "",
  //     progressValue: "2026-01-03 11:28:56",
  //     rank: "TOOLS",
  //   ),
  //   GameModel(
  //     title: "COCCOC",
  //     location: "TOOLS",
  //     imageUrl: "",
  //     progressValue: "2026-01-03 11:28:56",
  //     rank: "TOOLS",
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _currentTime = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _fireworksController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fetchInitialData();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted)
        setState(
          () => _currentTime = DateFormat(
            'HH:mm dd/MM/yyyy',
          ).format(DateTime.now()),
        );
    });
  }

  Future<void> _fetchInitialData() async {
    try {
      final games = await _repository.fetchGamesFromApi();
      if (mounted) {
        setState(() {
          _allGames = games;
          _onTabChanged(_activeTab);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onTabChanged(String tabLabel) {
    setState(() {
      _activeTab = tabLabel;
      if (tabLabel == "TẤT CẢ (IDC)") {
        _filteredGames = _allGames;
      } else if (tabLabel == "ONLINE") {
        _filteredGames = _allGames.where((g) => g.rank == "ONLINE").toList();
      } else if (tabLabel == "OFFLINE") {
        _filteredGames = _allGames.where((g) => g.rank == "OFFLINE").toList();
      } else if (tabLabel == "TOOLS") {
        _filteredGames = _allGames.where((g) => g.rank == "TOOLS").toList();;
      } else if (tabLabel == "GAME CỦA TÔI") {
        _filteredGames = _allGames.take(4).toList();
      }
    });
  }

  void _triggerCongratulation() {
    _fireworksController.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _showDiamondCard = true);
        _animationController.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _fireworksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHeader(), // Layout động mới hoàn toàn
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildProCloudSaveCard(),
                    const SizedBox(height: 30),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "THƯ VIỆN ",
                            style: TextStyle(
                              color: Color(0xFF00FF75),
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: "GAME",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTabFilter(),
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 15),
                    _buildFilterButton(),
                    const SizedBox(height: 20),
                    _buildInfoBanner(),
                    const SizedBox(height: 20),
                  ]),
                ),
              ),
              _isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF00FF75),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => GameCard(
                            game: _filteredGames[index],
                            isMyGameTab: _activeTab == "GAME CỦA TÔI",
                          ),
                          childCount: _filteredGames.length,
                        ),
                      ),
                    ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // Lớp Pháo hoa mượt mà tự làm
          IgnorePointer(
            child: NativeFireworks(animation: _fireworksController),
          ),

          // Popup Thẻ Vinh Danh (Hiện đè lên)
          if (_showDiamondCard) _buildDiamondCardOverlay(),
        ],
      ),
    );
  }

  // ===================== UI COMPONENTS =====================

  // ĐÃ SỬA LẠI LAYOUT NÀY, ĐẢM BẢO 100% KHÔNG BAO GIỜ BỊ MẤT NÚT
  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/seed/darkhouse/800/600"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.5), const Color(0xFF080808)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60), // Padding trên cùng an toàn
              // --- THẺ VINH DANH GÓC TRÊN PHẢI ---
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: _triggerCongratulation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF00E5FF).withOpacity(0.5),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Color(0xFF00E5FF),
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "THẺ ĐẲNG CẤP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 120), // Khoảng trống giữa
              // --- NỘI DUNG CHÍNH CỦA HEADER ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00FF75).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF00FF75).withOpacity(0.3),
                            ),
                          ),
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 3.5,
                                backgroundColor: Color(0xFF00FF75),
                              ),
                              SizedBox(width: 6),
                              Text(
                                "ĐANG CHƠI DỞ",
                                style: TextStyle(
                                  color: Color(0xFF00FF75),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(width: 1, height: 14, color: Colors.white24),
                        const SizedBox(width: 12),
                        Text(
                          _currentTime,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "BLACK MYTH: WUKONG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AI ƯỚC TÍNH TIẾN TRÌNH",
                                style: TextStyle(
                                  color: Color(0xFFB388FF),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "45%",
                                style: TextStyle(
                                  color: Color(0xFFB388FF),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 35, width: 1, color: Colors.white10),
                        const SizedBox(width: 15),
                        const Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ĐỊA ĐIỂM",
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Flash Gaming Center",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    NeonGameButton(
                      text: "CHIẾN TIẾP",
                      icon: Icons.play_arrow,
                      onTap: () {
                        // Chuyển trang tức thì không có hiệu ứng trượt,
                        // tạo cảm giác mượt mà y hệt như đang ấn vào Tab menu ở dưới
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const CagGuideScreen(),
                            transitionDuration:
                                Duration.zero, // Tắt hiệu ứng trượt rườm rà
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // --- NÚT CLOUD SAVE CHUẨN NỀN ĐEN CHỮ TRẮNG KHÔNG VIỀN ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CloudSaveDetailScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Nền đen thui
                          foregroundColor: Colors.white, // Chữ trắng
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide.none, // Tuyệt đối KHÔNG có viền
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_sync_outlined, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "CLOUD SAVE",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Padding an toàn dưới cùng
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProCloudSaveCard() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF04121A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00FF75).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FF75).withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.language, color: Color(0xFF00E5FF), size: 24),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "PRO CLOUD SAVE - KHÔNG GIỚI HẠN VỊ TRÍ",
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.6,
              ),
              children: [
                TextSpan(text: "Chơi tiếp tựa game AAA yêu thích của bạn ở "),
                TextSpan(
                  text: "BẤT KỲ ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text:
                      "đại lý nào sử dụng phần mềm CAG Pro. Dữ liệu save game offline được đồng bộ toàn cầu thông qua Internet với độ trễ bằng 0. Sân chơi đẳng cấp dành riêng cho cộng đồng game thủ offline.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _triggerCongratulation,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF0085FF)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0085FF).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card, color: Colors.black, size: 18),
                  SizedBox(width: 10),
                  Text(
                    "NHẬN THẺ ĐẲNG CẤP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabFilter() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterItem("TẤT CẢ (IDC)", "404", _activeTab == "TẤT CẢ (IDC)"),
            _filterItem("ONLINE", "224", _activeTab == "ONLINE"),
            _filterItem("OFFLINE", "158", _activeTab == "OFFLINE"),
            _filterItem("TOOLS", "20", _activeTab == "TOOLS"),
            _filterItem("GAME CỦA TÔI", "4", _activeTab == "GAME CỦA TÔI"),
          ],
        ),
      ),
    );
  }

  Widget _filterItem(String label, String count, bool active) {
    return GestureDetector(
      onTap: () => _onTabChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0xFF00FF75), Color(0xFF0085FF)],
                )
              : null,
          color: active ? null : Colors.transparent,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.black : Colors.white38,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: active
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                count,
                style: TextStyle(
                  color: active ? Colors.black : Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white38, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Tìm kiếm game trong kho IDC",
              style: TextStyle(
                color: Colors.white24,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "404 GAMES",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      alignment: Alignment.center,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.format_strikethrough, color: Colors.white54, size: 16),
          SizedBox(width: 8),
          Text(
            "LỌC GAME MỚI",
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF04101A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF0085FF).withOpacity(0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_none,
                color: Color(0xFF00FF75),
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                "KHO GAMES SẴN CÓ TRÊN MÁY CHỦ CAG PRO",
                style: TextStyle(
                  color: Color(0xFF00FF75),
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Hệ thống danh sách Game từ trạm IDC Master Center\n=> Không phải trên menu game tại phòng máy này\n=> Nếu phòng máy chưa tải game, vui lòng thông báo cho thu ngân / chủ phòng máy ... để hỗ trợ tải về cho bạn chiến nhé!",
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildDiamondCardOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withOpacity(0.85),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF020617)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF00FF75).withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FF75).withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CAG PRO",
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "GLOBAL PASS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "WORLD-CLASS OFFLINE GAMING",
                              style: TextStyle(
                                color: Color(0xFF00FF75),
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.gps_fixed,
                          color: const Color(0xFFFFD700),
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF00FF75),
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage("https://picsum.photos/100"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "LƯƠNG QUANG VINH",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFFFFD700),
                                ),
                              ),
                              child: const Text(
                                "DIAMOND",
                                style: TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(height: 1, color: Colors.white10),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _passStat("GIỜ BAY", "2219h"),
                        _passStat("PHÁ ĐẢO", "1"),
                        _passStat("CẤP ĐỘ", "VIP", isGreen: true),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FF75).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF00FF75).withOpacity(0.3),
                        ),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 10, height: 1.5),
                          children: [
                            TextSpan(
                              text: "ĐỒNG BỘ TOÀN CẦU: ",
                              style: TextStyle(
                                color: Color(0xFF00FF75),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Dữ liệu game offline của bạn được bảo vệ và đồng bộ tức thì. Đăng nhập và chơi tiếp tại ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextSpan(
                              text: "BẤT KỲ ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "phòng máy nào sử dụng CAG Pro trên toàn thế giới.",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: CAG-1-PRO",
                              style: TextStyle(
                                color: Colors.white24,
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "ISSUED: 2026",
                              style: TextStyle(
                                color: Colors.white24,
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.qr_code_2, color: Colors.white, size: 40),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _animationController.reverse().then(
                    (_) => setState(() => _showDiamondCard = false),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, color: Colors.black, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "KHOE CHIẾN TÍCH NGAY",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => _animationController.reverse().then(
                  (_) => setState(() => _showDiamondCard = false),
                ),
                child: const Text(
                  "ĐÓNG",
                  style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passStat(String label, String value, {bool isGreen = false}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: isGreen ? const Color(0xFF00FF75) : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// Widget Pháo hoa Native
class NativeFireworks extends AnimatedWidget {
  NativeFireworks({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> anim = listenable as Animation<double>;
    if (anim.value == 0 || anim.value == 1) return const SizedBox.shrink();

    final random = math.Random(42);
    final particles = List.generate(60, (i) {
      double startX = random.nextDouble();
      double speed = 0.5 + random.nextDouble() * 1.5;
      Color color = [
        Colors.greenAccent,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.yellow,
      ][random.nextInt(5)];
      return _ParticleDef(startX, speed, color);
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: particles.map((p) {
            double y =
                -50 + (anim.value * constraints.maxHeight * 1.5 * p.speed);
            return Positioned(
              left: p.startX * constraints.maxWidth,
              top: y,
              child: Transform.rotate(
                angle: anim.value * math.pi * 4 * p.speed,
                child: Container(
                  width: 8 + (p.speed * 4),
                  height: 8 + (p.speed * 4),
                  color: p.color,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ParticleDef {
  final double startX;
  final double speed;
  final Color color;
  _ParticleDef(this.startX, this.speed, this.color);
}
