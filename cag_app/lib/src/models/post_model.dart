import 'package:CAG_App/src/models/user_model.dart';
import 'enums.dart';

class PostModel {
  final String id;
  final Usermodel author;
  final String timestamp;
  final String content;
  final List<String> hashtags;
  final int likes;
  final int commentsCount;
  final String? imageUrl;
  final String location;
  final bool isPinned;
  final bool isFeatured;
  final List<String> badges;

  // Thêm từ TS
  final PostType? type;
  final double trustScore;
  final PostStatus status;

  PostModel({
    required this.id,
    required this.author,
    required this.timestamp,
    required this.content,
    required this.hashtags,
    required this.likes,
    required this.commentsCount,
    this.imageUrl,
    required this.location,
    this.isPinned = false,
    this.isFeatured = false,
    this.badges = const [],
    this.type,
    this.trustScore = 0.0,
    this.status = PostStatus.ACTIVE,
  });
}

class QuestModel {
  final String id;
  final String title;
  final String shopName;
  final String reward;
  final String deadline;
  final String imageUrl;
  final bool isHot;

  QuestModel({
    required this.id,
    required this.title,
    required this.shopName,
    required this.reward,
    required this.deadline,
    required this.imageUrl,
    this.isHot = false,
  });
}
