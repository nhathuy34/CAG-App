import 'package:flutter/material.dart';
// Import thanh menu Hexagon của bạn
import 'package:CAG_App/src/common_widgets/hexagon_bottom_nav.dart';

class CloudSaveDetailScreen extends StatefulWidget {
  const CloudSaveDetailScreen({super.key});

  @override
  State<CloudSaveDetailScreen> createState() => _CloudSaveDetailScreenState();
}

class _CloudSaveDetailScreenState extends State<CloudSaveDetailScreen> {
  bool _isCloudSaveTab = true; // True = Tab Cloud Save, False = Tab Cộng Đồng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // CHỈ CÓ MÀU ĐEN, KHÔNG ẢNH NỀN
      body: SafeArea(
        bottom: false, // Để thanh menu dưới cùng tràn viền đáy
        child: Column(
          children: [
            // ==========================================
            // PHẦN NỘI DUNG CUỘN ĐƯỢC
            // ==========================================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopHeader(context),
                    _buildTabs(),

                    // Nội dung chuyển đổi giữa 2 tab
                    _isCloudSaveTab
                        ? _buildCloudSaveTab()
                        : _buildCommunityTab(),
                  ],
                ),
              ),
            ),

            // ==========================================
            // PHẦN THANH MENU CỐ ĐỊNH BÊN DƯỚI
            // ==========================================
            _buildFixedBottomMenu(),
          ],
        ),
      ),
    );
  }

  // --- 1. HEADER (TIÊU ĐỀ & NÚT TÌM QUÁN) ---
  Widget _buildTopHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Nút quay lại
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.white54, size: 20),
                SizedBox(width: 10),
                Text(
                  "QUAY LẠI THƯ VIỆN",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            "BLACK MYTH: WUKONG",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 15),

          // Badges: 45H và TẠI FLASH GAMING
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white54, size: 14),
                    SizedBox(width: 6),
                    Text(
                      "45H ĐÃ CHƠI",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white54,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "TẠI: ",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "FLASH GAMING ...",
                      style: TextStyle(
                        color: Color(0xFF00FF75),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Nút TÌM QUÁN CHƠI NGAY (Màu Xanh Dương Chuẩn)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D6EFD), // Xanh lam chuẩn như ảnh
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "TÌM QUÁN CHƠI NGAY",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- 2. TABS CHUYỂN ĐỔI ---
  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isCloudSaveTab = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _isCloudSaveTab
                          ? const Color(0xFF00FF75)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_sync_outlined,
                      color: _isCloudSaveTab
                          ? const Color(0xFF00FF75)
                          : Colors.white38,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "CLOUD SAVE",
                      style: TextStyle(
                        color: _isCloudSaveTab
                            ? const Color(0xFF00FF75)
                            : Colors.white38,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isCloudSaveTab = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: !_isCloudSaveTab
                          ? const Color(0xFFFFD700)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: !_isCloudSaveTab
                          ? const Color(0xFFFFD700)
                          : Colors.white38,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "CỘNG ĐỒNG",
                      style: TextStyle(
                        color: !_isCloudSaveTab
                            ? const Color(0xFFFFD700)
                            : Colors.white38,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 3A. NỘI DUNG TAB CLOUD SAVE (Y hệt ảnh 16.06.15) ---
  Widget _buildCloudSaveTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Hàng nút Sync và AI
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF00FF75).withOpacity(0.5),
                    ),
                    color: const Color(0xFF00FF75).withOpacity(0.05),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Color(0xFF00FF75),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "REAL-TIME SYNC",
                        style: TextStyle(
                          color: Color(0xFF00FF75),
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8A2BE2), Color(0xFF0085FF)],
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "AI PHÂN TÍCH TIẾN TRÌNH",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Card 1: Bấm DELETE
          _buildSaveCard(
            title: "AUTOSAVE_CHAPTER4",
            time: "11:50 29/03/2026",
            location: "FLASH GAMING CENTER",
            size: "15.2MB",
            isLocked: false,
          ),
          const SizedBox(height: 15),

          // Card 2: Đã LOCK
          _buildSaveCard(
            title: "MANUAL_BOSSFIGHT",
            time: "11:50 28/03/2026",
            location: "GAMING HOUSE PRO",
            size: "14.8MB",
            isLocked: true,
          ),
          const SizedBox(height: 40), // Spacing đáy
        ],
      ),
    );
  }

  // Component Card Save
  Widget _buildSaveCard({
    required String title,
    required String time,
    required String location,
    required String size,
    required bool isLocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.check, color: Color(0xFF00FF75)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white38,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      size,
                      style: const TextStyle(
                        color: Color(0xFF0085FF),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // NÚT BẤM BÊN TRONG CARD
          Row(
            children: [
              if (!isLocked) ...[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Colors.white54,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "LOCK",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D0A0A), // Nền đỏ thẫm
                      border: Border.all(
                        color: const Color(0xFF8B0000),
                      ), // Viền đỏ
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "DELETE",
                        style: TextStyle(
                          color: Color(0xFFFF4D4D),
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF003311),
                      border: Border.all(color: const Color(0xFF00FF75)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color(0xFF00FF75),
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "LOCK",
                          style: TextStyle(
                            color: Color(0xFF00FF75),
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // --- 3B. NỘI DUNG TAB CỘNG ĐỒNG (Y hệt ảnh 16.07.20) ---
  Widget _buildCommunityTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 25),

          // THẺ CỘNG ĐỒNG ĐÁNH GIÁ
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Stack(
              children: [
                // Ngôi sao chìm phía sau
                const Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.star_border_rounded,
                    size: 150,
                    color: Colors.white10,
                  ),
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        // Vòng tròn điểm số
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: const Color(0xFFFFD700),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withOpacity(0.2),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "N/A",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "/ 5.0 SCORE",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Tiêu đề cộng đồng
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CỘNG ĐỒNG ĐÁNH\nGIÁ",
                                style: TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "DỰA TRÊN 0 VERIFIED REVIEWS",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Nút Lọc
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "NEWEST",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "HIGHEST",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "HARDCORE",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Nút VIẾT REVIEW trắng
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: Colors.black, size: 16),
                          SizedBox(width: 8),
                          Text(
                            "VIẾT REVIEW",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Trạng thái NO DATA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "NO DATA RECORDS FOUND",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // --- 4. THANH MENU CỐ ĐỊNH BÊN DƯỚI (Y hệt ảnh chụp) ---
  Widget _buildFixedBottomMenu() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hàng nút SYSTEM VIEW, VIP, Nút Xanh Lơ
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: Row(
              children: [
                // SYSTEM VIEW
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Color(0xFF00FF75),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "SYSTEM VIEW: ",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "GAMER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white54,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // VIP Benefits
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star_border, color: Colors.black, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "VIP Benefits",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // Nút tròn xanh lơ (có mũi tên trỏ ra ngoài)
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF007BFF),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF007BFF).withOpacity(0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.outbound_outlined,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          // IMPORT TRỰC TIẾP THANH BOTTOM NAV CỦA BẠN (CÓ LỤC GIÁC QUAY)
          HexagonBottomNav(
            currentIndex: 1, // Focus vào Tab Cloud Save
            onTap: (index) {
              // Xử lý chuyển tab nếu cần
            },
          ),
        ],
      ),
    );
  }
}
