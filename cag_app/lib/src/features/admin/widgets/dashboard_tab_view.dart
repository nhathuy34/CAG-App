import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardTabView extends StatelessWidget {
  const DashboardTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      children: [
        // 1. Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.015,
                    height: screenWidth * 0.06,
                    color: AppTheme.cyanNeon,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Text(
                      "TỔNG QUAN HỆ THỐNG CAG",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            _buildStatusBadge(screenWidth),
          ],
        ),
        SizedBox(height: screenWidth * 0.06),

        // 2. Growth Chart Section
        _buildSectionTitle(
          screenWidth,
          Icons.show_chart,
          "BIỂU ĐỒ TĂNG TRƯỞNG PHÒNG MÁY",
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildChartPlaceholder(
          screenWidth,
          height: screenWidth * 0.5,
          hasLegend: true,
        ),
        SizedBox(height: screenWidth * 0.06),

        // 3. Advisory Section (Cần tư vấn cài CAG Pro)
        _buildSectionTitle(
          screenWidth,
          Icons.warning_amber_rounded,
          "CẦN TƯ VẤN CÀI CAG PRO",
          color: Colors.pinkAccent,
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildAdvisoryCard(screenWidth),
        SizedBox(height: screenWidth * 0.08),

        // 4. Coverage Section (Google Maps + Detailed AI Analysis)
        _buildSectionTitle(
          screenWidth,
          Icons.location_on_outlined,
          "ĐỘ PHỦ CAG GUIDE TRÊN 34 TỈNH THÀNH",
          color: AppTheme.gold,
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildMapPlaceholder(screenWidth),
        SizedBox(height: screenWidth * 0.06),
        _buildDetailedAIAnalysis(screenWidth),
        SizedBox(height: screenWidth * 0.04),
        _buildCoverageTables(screenWidth),
        SizedBox(height: screenWidth * 0.08),

        // 5. Reviews Section
        _buildReviewCard(
          screenWidth,
          title: "ĐÁNH GIÁ TỪ CHỦ NÉT",
          rating: 4.8,
          count: "(1,850 đánh giá)",
          comments: [
            "Quản lý tập trung tiện lợi, tiết kiệm 30% thời gian.",
            "Lượng khách mới từ CAG Guide tăng rõ rệt.",
            "Hệ thống Flash Sale giúp lấp đầy máy trống giờ thấp điểm.",
          ],
          accentColor: AppTheme.cyanNeon,
          icon: Icons.person_add_alt_1,
        ),
        SizedBox(height: screenWidth * 0.04),
        _buildReviewCard(
          screenWidth,
          title: "ĐÁNH GIÁ TỪ GAMER",
          rating: 4.7,
          count: "(14,200 đánh giá)",
          comments: [
            "Tìm phòng máy có máy lạnh, ghế sofa cực nhanh.",
            "Nhiều khuyến mãi độc quyền từ CAG.",
            "Giao diện đẹp, dễ sử dụng, xem được cấu hình máy trước khi đến.",
          ],
          accentColor: AppTheme.gold,
          icon: Icons.chat_bubble_outline,
        ),
        SizedBox(height: screenWidth * 0.08),

        // 6. Summary Stats Section (2x2 grid)
        _buildAIAnalysisBanner(screenWidth),
        SizedBox(height: screenWidth * 0.04),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenWidth * 0.03,
          childAspectRatio: 1.4,
          children: [
            _buildStatCard(
              screenWidth,
              "TỔNG PHÒNG MÁY (HỆ THỐNG)",
              "2,500",
              "+ 15% so với tháng trước",
              Colors.white10,
              Colors.white70,
            ),
            _buildStatCard(
              screenWidth,
              "TỔNG GAMER (HỆ THỐNG)",
              "20,000",
              "● 4,000 Đang Online",
              Colors.green.withOpacity(0.1),
              Colors.greenAccent,
            ),
            _buildStatCard(
              screenWidth,
              "TỶ LỆ KHÁCH QUAY LẠI",
              "90%",
              "+ 2% so với tháng trước",
              Colors.redAccent.withOpacity(0.05),
              Colors.redAccent,
            ),
            _buildStatCard(
              screenWidth,
              "GIỜ CHƠI TRUNG BÌNH/TUẦN",
              "115,500H",
              "+ 5% so với tuần trước",
              Colors.purpleAccent.withOpacity(0.1),
              Colors.purpleAccent,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.08),

        // 7. Weekly Activity & Retention Charts
        _buildSectionTitle(
          screenWidth,
          Icons.trending_up,
          "TẦN SUẤT CHƠI GAME (TUẦN)",
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildChartPlaceholder(
          screenWidth,
          height: screenWidth * 0.4,
          isLineChart: true,
        ),
        SizedBox(height: screenWidth * 0.06),

        _buildSectionTitle(
          screenWidth,
          Icons.pie_chart_outline,
          "TỶ LỆ KHÁCH QUAY LẠI / RỜI BỎ",
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildChartPlaceholder(
          screenWidth,
          height: screenWidth * 0.4,
          isBarChart: true,
        ),
        SizedBox(height: screenWidth * 0.08),

        // 8. Top Ranking
        _buildSectionTitle(
          screenWidth,
          Icons.emoji_events_outlined,
          "TOP PHÒNG MÁY HỆ THỐNG",
          color: AppTheme.gold,
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildTopRankingList(screenWidth),
        SizedBox(height: screenWidth * 0.1),
      ],
    );
  }

  Widget _buildStatusBadge(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.green, size: screenWidth * 0.02),
          SizedBox(width: screenWidth * 0.015),
          Text(
            "HỆ THỐNG ONLINE",
            style: TextStyle(
              color: Colors.green,
              fontSize: screenWidth * 0.028,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    double screenWidth,
    IconData icon,
    String title, {
    Color color = Colors.cyanAccent,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: screenWidth * 0.045),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildChartPlaceholder(
    double screenWidth, {
    required double height,
    bool hasLegend = false,
    bool isLineChart = false,
    bool isBarChart = false,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D141A),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, color: Colors.white10, size: height * 0.4),
          if (hasLegend) ...[
            SizedBox(height: screenWidth * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(screenWidth, Colors.cyanAccent, "CAG Chuỗi"),
                SizedBox(width: screenWidth * 0.04),
                _buildLegendItem(screenWidth, AppTheme.gold, "CAG Guide"),
                SizedBox(width: screenWidth * 0.04),
                _buildLegendItem(screenWidth, Colors.pinkAccent, "Đối tác"),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLegendItem(double screenWidth, Color color, String label) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.02,
          height: screenWidth * 0.02,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: screenWidth * 0.015),
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: screenWidth * 0.025,
          ),
        ),
      ],
    );
  }

  Widget _buildAdvisoryCard(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "SkyNet Cyber",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenWidth * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                ),
                child: Text(
                  "Ưu tiên",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: screenWidth * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            "15 Nguyễn Văn Lượng, Gò Vấp",
            style: TextStyle(
              color: Colors.white54,
              fontSize: screenWidth * 0.03,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(screenWidth * 0.015),
                border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
              ),
              child: Text(
                "Liên hệ tư vấn ngay",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.035,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder(double screenWidth) {
    return Container(
      height: screenWidth * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D141A),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GOOGLE MAPS API KEY REQUIRED",
              style: TextStyle(
                color: AppTheme.gold,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.03,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "Please add your GOOGLE_MAPS_PLATFORM_KEY...",
              style: TextStyle(
                color: Colors.white38,
                fontSize: screenWidth * 0.025,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedAIAnalysis(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            screenWidth,
            Icons.attach_money,
            "AI PHÂN TÍCH ĐỘ PHỦ",
            color: AppTheme.cyanNeon,
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildAIBullet(
            screenWidth,
            "VÙNG MẠNH (TP.HCM, HÀ NỘI)",
            "Tập trung đông sinh viên, nhu cầu eSports cao.",
            "Tiếp tục duy trì và upsell các dịch vụ cao cấp (Flash Sale, Giải đấu).",
            Colors.greenAccent,
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildAIBullet(
            screenWidth,
            "VÙNG TIỀM NĂNG (CẦN THƠ, HẢI PHÒNG)",
            "Đang phát triển nhưng thiếu sự kiện kích cầu.",
            "Cần tổ chức các giải đấu phong trào liên phòng máy để thu hút thêm Gamer.",
            AppTheme.gold,
          ),
          SizedBox(height: screenWidth * 0.04),
          _buildAIBullet(
            screenWidth,
            "VÙNG TRẮNG (LAI CHÂU, ĐIỆN BIÊN)",
            "Hạ tầng mạng/thu nhập chưa phù hợp cho mô hình Cyber lớn.",
            "Đẩy mạnh mô hình CAG Guide quy mô nhỏ (10-20 máy) với chi phí đầu tư thấp.",
            Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildAIBullet(
    double screenWidth,
    String title,
    String desc,
    String action,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: color, size: screenWidth * 0.02),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          desc,
          style: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth * 0.028,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "→ ",
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: screenWidth * 0.028,
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hướng xử lý: ",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: screenWidth * 0.028,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: action,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: screenWidth * 0.028,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoverageTables(double screenWidth) {
    return Column(
      children: [
        _buildSmallTable(
          screenWidth,
          "TOP PHỦ SÓNG",
          "NHIỀU KHÁCH",
          AppTheme.cyanNeon,
          [
            {"name": "TP.HCM", "val": "850"},
            {"name": "Hà Nội", "val": "600"},
            {"name": "Đà Nẵng", "val": "225"},
          ],
        ),
        SizedBox(height: screenWidth * 0.04),
        _buildSmallTable(
          screenWidth,
          "ĐANG PHÁT TRIỂN",
          "ÍT KHÁCH",
          AppTheme.gold,
          [
            {"name": "Thanh Hóa", "val": "45"},
            {"name": "Nghệ An", "val": "40"},
            {"name": "Thừa Thiên Huế", "val": "35"},
          ],
        ),
        SizedBox(height: screenWidth * 0.04),
        _buildSmallTable(
          screenWidth,
          "VÙNG TRẮNG",
          "CHƯA CÓ CAG",
          Colors.pinkAccent,
          [
            {"name": "Lai Châu", "val": "0"},
            {"name": "Điện Biên", "val": "0"},
            {"name": "Hà Giang", "val": "0"},
          ],
        ),
      ],
    );
  }

  Widget _buildSmallTable(
    double screenWidth,
    String title,
    String tag,
    Color color,
    List<Map<String, String>> data,
  ) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.03,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenWidth * 0.005,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: color,
                    fontSize: screenWidth * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02),
          ...data.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['name']!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                  Text(
                    item['val']!,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.03,
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

  Widget _buildReviewCard(
    double screenWidth, {
    required String title,
    required double rating,
    required String count,
    required List<String> comments,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: accentColor.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: AppTheme.gold,
                            size: screenWidth * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        count,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Icon(icon, color: accentColor, size: screenWidth * 0.06),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),
          ...comments.map(
            (comment) => Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: accentColor,
                    size: screenWidth * 0.04,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Text(
                      comment,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: screenWidth * 0.03,
                      ),
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

  Widget _buildStatCard(
    double screenWidth,
    String label,
    String value,
    String subValue,
    Color borderColor,
    Color subColor,
  ) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppTheme.cardBlue,
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white54,
              fontSize: screenWidth * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subValue,
            style: TextStyle(
              color: subColor,
              fontSize: screenWidth * 0.025,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisBanner(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF0D141A),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_money,
                color: AppTheme.cyanNeon,
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  "AI PHÂN TÍCH & CẢNH BÁO TỰ ĐỘNG",
                  style: TextStyle(
                    color: AppTheme.cyanNeon,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.035,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              FittedBox(
                child: _buildSmallButton(
                  screenWidth,
                  "Phân Tích Ngay",
                  AppTheme.cyanNeon,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            "Nhấn \"Phân Tích Ngay\" để AI tổng hợp dữ liệu và đưa ra cảnh báo/gợi ý.",
            style: TextStyle(
              color: Colors.white54,
              fontSize: screenWidth * 0.03,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(double screenWidth, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(screenWidth * 0.01),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.03,
        ),
      ),
    );
  }

  Widget _buildTopRankingList(double screenWidth) {
    final List<Map<String, dynamic>> items = [
      {"rank": 1, "name": "CyberCore Premium", "value": "1,500"},
      {"rank": 2, "name": "Spartacus Gaming", "value": "1,200"},
      {"rank": 3, "name": "Vikings Esports", "value": "950"},
      {"rank": 4, "name": "X-Stadium", "value": "800"},
      {"rank": 5, "name": "QTV Center", "value": "750"},
    ];

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xFF0D141A),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: item['rank'] == 1
                            ? AppTheme.gold
                            : Colors.white12,
                        borderRadius: BorderRadius.circular(screenWidth * 0.01),
                      ),
                      child: Text(
                        item['rank'].toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      item['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item['value'],
                      style: TextStyle(
                        color: AppTheme.cyanNeon,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
