import 'package:flutter/material.dart';

class FakeCloudSaveTab extends StatefulWidget {
  final bool hasAIBtn;
  final bool isEmptySave;
  final String? saveTitle;
  final String? saveTime;
  final String? saveLocation;
  final String? saveSize;
  final bool isLocked;

  const FakeCloudSaveTab({
    super.key,
    required this.hasAIBtn,
    required this.isEmptySave,
    this.saveTitle,
    this.saveTime,
    this.saveLocation,
    this.saveSize,
    required this.isLocked,
  });

  @override
  State<FakeCloudSaveTab> createState() => _FakeCloudSaveTabState();
}

class _FakeCloudSaveTabState extends State<FakeCloudSaveTab> {
  late bool _isLocked;
  late bool _isEmptySave;

  bool _isAnalyzingAI = false;
  bool _showAIResult = false;

  @override
  void initState() {
    super.initState();
    _isLocked = widget.isLocked;
    _isEmptySave = widget.isEmptySave;
  }

  void _toggleLock() {
    setState(() => _isLocked = false);
  }

  void _reLock() {
    setState(() => _isLocked = true);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        title: const Text(
          "XÁC NHẬN XOÁ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        content: const Text(
          "Bạn có chắc chắn muốn xoá bản lưu này không? Dữ liệu không thể khôi phục.",
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              "NO",
              style: TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _isEmptySave = true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB91C1C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "YES",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAIAnalysis() {
    if (_isAnalyzingAI || _showAIResult) return;
    setState(() {
      _isAnalyzingAI = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isAnalyzingAI = false;
          _showAIResult = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00FF75).withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF00FF75).withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF00FF75)),
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
            if (widget.hasAIBtn) ...[
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: _handleAIAnalysis,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _isAnalyzingAI ? const Color(0xFF2A1B54) : null,
                      gradient: _isAnalyzingAI
                          ? null
                          : const LinearGradient(
                              colors: [Color(0xFF8A2BE2), Color(0xFF0085FF)],
                            ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isAnalyzingAI) ...[
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white54,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "AI ĐANG PHÂN TÍCH...",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w900,
                              fontSize: 9,
                            ),
                          ),
                        ] else ...[
                          const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "AI PHÂN TÍCH TIẾN TRÌNH",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 25),

        if (_showAIResult) ...[
          _buildAIResultBlock(),
          const SizedBox(height: 25),
        ],

        if (_isEmptySave)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const Center(
              child: Text(
                "NO SAVE DATA FOUND",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          )
        else
          _buildSaveCard(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAIResultBlock() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF150B24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF9333EA), width: 4),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9333EA).withOpacity(0.5),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "100%",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFFB388FF), size: 16),
              SizedBox(width: 8),
              Text(
                "AI ĐÁNH GIÁ TIẾN TRÌNH",
                style: TextStyle(
                  color: Color(0xFFB388FF),
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.6,
              ),
              children: [
                TextSpan(
                  text:
                      "Dựa trên dữ liệu file save mới nhất, AI ước tính bạn đã hoàn thành ",
                ),
                TextSpan(
                  text: "100% ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "cốt truyện chính.\nChúc mừng! Bạn đã hoàn thành cốt truyện chính của game.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF080808),
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
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: const Icon(Icons.check, color: Color(0xFF00FF75)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.saveTitle ?? "",
                      style: TextStyle(
                        color: _isLocked
                            ? const Color(0xFF00FF75)
                            : Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.saveTime ?? "",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white38,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.saveLocation ?? "",
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
                      widget.saveSize ?? "",
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
          Row(
            children: [
              if (_isLocked) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: _toggleLock,
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
                ),
              ] else ...[
                Expanded(
                  child: GestureDetector(
                    onTap: _reLock,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
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
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _confirmDelete,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB91C1C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DELETE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
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
}
