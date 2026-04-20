import 'package:flutter/material.dart';

class GameModel {
  final String title;
  final String location;
  final String imageUrl;
  final String progressValue;
  final String? rank;
  final Color? rankColor;

  GameModel({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.progressValue,
    this.rank,
    this.rankColor,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    final String folder = json['Folder'] ?? '';
    final String folderLower = folder.toLowerCase();
    String currentRank;
    Color currentRankColor;

    if (folderLower.contains('online')) {
      currentRank = 'ONLINE';
      currentRankColor = const Color(0xFF00FF75); // Xanh neon
    } else if (folderLower.contains('tools')) {
      currentRank = 'TOOLS';
      currentRankColor = const Color(0xFF00E5FF); // Xanh dương sáng (Cyan)
    } else {
      currentRank = 'OFFLINE';
      currentRankColor = const Color(0xFFF1C40F); // Vàng cam
    }

    return GameModel(
      title: json['GameName'] ?? 'Không rõ tên',
      location: folder,
      imageUrl: "https://picsum.photos/seed/${json['GameName']}/200",
      progressValue: json['ThoiGianFormat'] ?? '',
      rank: currentRank,
      rankColor: currentRankColor,
    );
  }
}
