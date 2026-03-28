class GameModel {
  final String id;
  final String name;
  final String category;
  final String posterUrl;
  final int totalPlayTime;
  final bool isFavorite;

  GameModel({
    required this.id,
    required this.name,
    required this.category,
    required this.posterUrl,
    required this.totalPlayTime,
    this.isFavorite = false,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      posterUrl: json['posterUrl'] as String,
      totalPlayTime: json['totalPlayTime'] as int? ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}