import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/notification_model.dart';

/// ================== PROVIDER ==================
final notificationProvider =
    ChangeNotifierProvider((ref) => NotificationProvider());

/// ================== PROVIDER CLASS ==================
class NotificationProvider extends ChangeNotifier {
  /// Controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  /// Dropdown
  String selectedType = 'Thông tin chung';

  final List<String> notificationTypes = [
    'Thông tin chung',
    'Khuyến mãi / Ưu đãi',
    'Cảnh báo / Bảo trì',
  ];

  /// ================== HISTORY ==================
  final List<NotificationModel> _history = [];

  /// ✅ FIX LỖI WEB (.reversed)
  List<NotificationModel> get history {
    return List<NotificationModel>.from(_history.reversed);
  }

  /// ================== ACTION ==================
  void setNotificationType(String? value) {
    if (value != null) {
      selectedType = value;
      notifyListeners();
    }
  }

  void sendNotification() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) return;

    /// Lưu vào lịch sử
    _history.add(
      NotificationModel(
        title: title,
        content: content,
        type: selectedType,
        createdAt: DateTime.now(),
      ),
    );

    debugPrint("Đã gửi: $title");

    /// Clear form
    titleController.clear();
    contentController.clear();

    notifyListeners();
  }

  /// ================== OPTIONAL ==================
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}