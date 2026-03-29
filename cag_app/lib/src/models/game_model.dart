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
    final bool isOnline = folder.toLowerCase().contains('online');

    return GameModel(
      title: json['GameName'] ?? 'Không rõ tên',
      location: folder,
      imageUrl: "https://picsum.photos/seed/${json['GameName']}/200",
      progressValue: json['ThoiGianFormat'] ?? '',
      rank: isOnline ? 'ONLINE' : 'OFFLINE',
      rankColor: isOnline ? const Color(0xFF00FF75) : const Color(0xFFF1C40F),
    );
  }
}
