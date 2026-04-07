import 'package:flutter/material.dart';

class FakeCommunityTab extends StatefulWidget {
  const FakeCommunityTab({super.key});

  @override
  State<FakeCommunityTab> createState() => _FakeCommunityTabState();
}

class _FakeCommunityTabState extends State<FakeCommunityTab> {
  bool _isWritingReview = false;
  String _activeCommunityFilter = "NEWEST";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Stack(
            children: [
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
                  Row(
                    children: [
                      _buildFilterBtn("NEWEST"),
                      const SizedBox(width: 10),
                      _buildFilterBtn("HIGHEST"),
                      const SizedBox(width: 10),
                      _buildFilterBtn("HARDCORE"),
                    ],
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => setState(() => _isWritingReview = true),
                    child: Container(
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
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        if (_isWritingReview) ...[
          _ReviewForm(onCancel: () => setState(() => _isWritingReview = false)),
          const SizedBox(height: 25),
        ],

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
      ],
    );
  }

  Widget _buildFilterBtn(String text) {
    bool isActive = _activeCommunityFilter == text;
    return GestureDetector(
      onTap: () => setState(() => _activeCommunityFilter = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFD700) : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.white24,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _ReviewForm extends StatefulWidget {
  final VoidCallback onCancel;
  const _ReviewForm({required this.onCancel});

  @override
  State<_ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<_ReviewForm> {
  double _gameplay = 5, _graphics = 5, _story = 5;
  bool _isDraggingGameplay = false,
      _isDraggingGraphics = false,
      _isDraggingStory = false,
      _isSubmitting = false;

  void _submitReview() {
    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        widget.onCancel();
      }
    });
  }

  Widget _buildSliderItem(
    String title,
    double value,
    bool isDragging,
    ValueChanged<double> onChanged,
    ValueChanged<double> onChangeStart,
    ValueChanged<double> onChangeEnd,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDragging
              ? const Color(0xFFFFD700)
              : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFFFD700),
              inactiveTrackColor: Colors.white.withOpacity(0.1),
              thumbColor: const Color(0xFFFFD700),
              overlayColor: const Color(0xFFFFD700).withOpacity(0.2),
              trackHeight: 6.0,
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 6, color: const Color(0xFFFFD700)),
            const SizedBox(width: 10),
            const Text(
              "BATTLE REPORT LOG",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildSliderItem(
          "GAMEPLAY",
          _gameplay,
          _isDraggingGameplay,
          (val) => setState(() => _gameplay = val),
          (val) => setState(() => _isDraggingGameplay = true),
          (val) => setState(() => _isDraggingGameplay = false),
        ),
        _buildSliderItem(
          "GRAPHICS",
          _graphics,
          _isDraggingGraphics,
          (val) => setState(() => _graphics = val),
          (val) => setState(() => _isDraggingGraphics = true),
          (val) => setState(() => _isDraggingGraphics = false),
        ),
        _buildSliderItem(
          "STORY",
          _story,
          _isDraggingStory,
          (val) => setState(() => _story = val),
          (val) => setState(() => _isDraggingStory = true),
          (val) => setState(() => _isDraggingStory = false),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF14141E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                maxLines: 4,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
                decoration: InputDecoration(
                  hintText:
                      "MISSION LOG: Ghi lại trải nghiệm chiến đấu của bạn...",
                  hintStyle: TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Text(
                "0 KÝ TỰ",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
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
                onTap: widget.onCancel,
                child: const Center(
                  child: Text(
                    "HỦY BỎ",
                    style: TextStyle(
                      color: Colors.white38,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: _isSubmitting ? null : _submitReview,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _isSubmitting
                        ? Colors.white
                        : const Color(0xFFEAB308),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: _isSubmitting
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 15,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      _isSubmitting ? "ĐANG GỬI..." : "GỬI BÁO CÁO",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
