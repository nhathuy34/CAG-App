import 'package:flutter/material.dart';
import 'save_data_card.dart';

class CloudSaveTabContent extends StatefulWidget {
  const CloudSaveTabContent({super.key});

  @override
  State<CloudSaveTabContent> createState() => _CloudSaveTabContentState();
}

class _CloudSaveTabContentState extends State<CloudSaveTabContent> {
  bool _isAnalyzingAI = false;
  bool _showAIResult = false;

  void _handleAIAnalysis() {
    if (_isAnalyzingAI || _showAIResult) return;
    setState(() => _isAnalyzingAI = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted)
        setState(() {
          _isAnalyzingAI = false;
          _showAIResult = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
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
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: _handleAIAnalysis,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
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
                        // if (_isAnalyzingAI) ...[
                        //   const SizedBox(
                        //     width: 12,
                        //     height: 12,
                        //     child: CircularProgressIndicator(
                        //       strokeWidth: 2,
                        //       valueColor: AlwaysStoppedAnimation<Color>(
                        //         Colors.white54,
                        //       ),
                        //     ),
                        //   ),
                        //   const SizedBox(width: 8),
                        //   const Text(
                        //     "AI ĐANG PHÂN TÍCH...",
                        //     style: TextStyle(
                        //       color: Colors.white54,
                        //       fontWeight: FontWeight.w900,
                        //       fontSize: 9,
                        //     ),
                        //   ),
                        // ] else ...[
                        //   const Icon(
                        //     Icons.auto_awesome,
                        //     color: Colors.white,
                        //     size: 12,
                        //   ),
                        //   const SizedBox(width: 6),
                        const Text(
                          "AI PHÂN TÍCH TIẾN TRÌNH",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 9,
                          ),
                        ),
                      ],
                      //],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          if (_showAIResult) ...[
            _buildAIResultBlock(),
            const SizedBox(height: 25),
          ],

          const SaveDataCard(
            title: "AUTOSAVE_CHAPTER4",
            time: "11:50 29/03/2026",
            location: "FLASH GAMING CENTER",
            size: "15.2MB",
            isLocked: false,
          ),
          const SaveDataCard(
            title: "MANUAL_BOSSFIGHT",
            time: "11:50 28/03/2026",
            location: "GAMING HOUSE PRO",
            size: "14.8MB",
            isLocked: true,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildAIResultBlock() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF150B24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Đang phát triển",
              style: TextStyle(
                color: Color(0xFFB388FF),
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
