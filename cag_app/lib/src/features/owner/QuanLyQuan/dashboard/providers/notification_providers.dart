import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Khai báo provider toàn cục
final notificationProvider = ChangeNotifierProvider((ref) => NotificationProvider());

class NotificationProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String selectedType = 'Thông tin chung';
  final List<String> notificationTypes = ['Thông tin chung', 'Khuyến mãi / Ưu đãi', 'Cảnh báo / Bảo trì'];

  void setNotificationType(String? value) {
    if (value != null) {
      selectedType = value;
      notifyListeners();
    }
  }

  void sendNotification() {
    print("Gửi: ${titleController.text}");
  }
}