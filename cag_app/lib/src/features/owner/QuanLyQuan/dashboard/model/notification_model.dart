class NotificationModel {
  final String title;
  final String content;
  final String type;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
  });
}