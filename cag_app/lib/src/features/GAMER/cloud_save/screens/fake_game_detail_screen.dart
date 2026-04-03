import 'package:flutter/material.dart';
import '../widgets/detail_screen/detail_screen_components.dart';

import '../widgets/detail_screen/fake_community_tab.dart';
import '../widgets/detail_screen/fake_cloud_save_tab.dart';

class FakeGameDetailScreen extends StatefulWidget {
  final String bgUrl;
  final String title;
  final String playtime;
  final String location;
  final bool hasAIBtn;
  final bool isEmptySave;
  final String? saveTitle;
  final String? saveTime;
  final String? saveLocation;
  final String? saveSize;
  final bool isLocked;

  const FakeGameDetailScreen({
    super.key,
    required this.bgUrl,
    required this.title,
    required this.playtime,
    required this.location,
    this.hasAIBtn = false,
    this.isEmptySave = false,
    this.saveTitle,
    this.saveTime,
    this.saveLocation,
    this.saveSize,
    this.isLocked = false,
  });

  @override
  State<FakeGameDetailScreen> createState() => _FakeGameDetailScreenState();
}

class _FakeGameDetailScreenState extends State<FakeGameDetailScreen> {
  bool _isCloudSaveTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white54,
                              size: 18,
                            ),
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
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C1015),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: 250,
                              child: ShaderMask(
                                shaderCallback: (rect) =>
                                    const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                    ).createShader(
                                      Rect.fromLTRB(
                                        0,
                                        0,
                                        rect.width,
                                        rect.height,
                                      ),
                                    ),
                                blendMode: BlendMode.dstIn,
                                child: Image.network(
                                  widget.bgUrl,
                                  fit: BoxFit.cover,
                                  opacity: const AlwaysStoppedAnimation(0.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 60),
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      _buildBadge(
                                        Icons.access_time,
                                        widget.playtime,
                                        Colors.white70,
                                      ),
                                      const SizedBox(width: 10),
                                      _buildLocationBadge(widget.location),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  // NÚT TÌM QUÁN CHƠI NGAY
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D6EFD),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF0D6EFD,
                                          ).withOpacity(0.3),
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "TÌM QUÁN CHƠI NGAY",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 13,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(
                                            () => _isCloudSaveTab = true,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: _isCloudSaveTab
                                                      ? const Color(0xFF00FF75)
                                                      : Colors.transparent,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.cloud_sync_outlined,
                                                  color: _isCloudSaveTab
                                                      ? const Color(0xFF00FF75)
                                                      : Colors.white38,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "CLOUD SAVE",
                                                  style: TextStyle(
                                                    color: _isCloudSaveTab
                                                        ? const Color(
                                                            0xFF00FF75,
                                                          )
                                                        : Colors.white38,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 11,
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
                                          onTap: () => setState(
                                            () => _isCloudSaveTab = false,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: !_isCloudSaveTab
                                                      ? const Color(0xFFFFD700)
                                                      : Colors.transparent,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: !_isCloudSaveTab
                                                      ? const Color(0xFFFFD700)
                                                      : Colors.white38,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "CỘNG ĐỒNG",
                                                  style: TextStyle(
                                                    color: !_isCloudSaveTab
                                                        ? const Color(
                                                            0xFFFFD700,
                                                          )
                                                        : Colors.white38,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 11,
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
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 1,
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                  const SizedBox(height: 20),

                                  // --- GỌI CÁC TAB FILE Ở ĐÂY ---
                                  if (_isCloudSaveTab)
                                    FakeCloudSaveTab(
                                      hasAIBtn: widget.hasAIBtn,
                                      isEmptySave: widget.isEmptySave,
                                      saveTitle: widget.saveTitle,
                                      saveTime: widget.saveTime,
                                      saveLocation: widget.saveLocation,
                                      saveSize: widget.saveSize,
                                      isLocked: widget.isLocked,
                                    )
                                  else
                                    const FakeCommunityTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            const DetailFixedBottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 12),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBadge(String location) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white54,
            size: 12,
          ),
          const SizedBox(width: 6),
          const Text(
            "TẠI: ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            location,
            style: const TextStyle(
              color: Color(0xFF00FF75),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
