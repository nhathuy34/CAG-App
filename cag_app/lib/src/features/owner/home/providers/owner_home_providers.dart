import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Current active role for filter
final ownerRoleProvider = StateProvider<String>((ref) => 'BOSS');

// Mapping for branches based on role
final branchMapping = {
  'BOSS': [
    {'value': 'ALL', 'label': '🏢 TOÀN BỘ HỆ THỐNG'},
    {'value': '1', 'label': '📍 Cyber All Game Q.Gò Vấp'},
    {'value': '2', 'label': '📍 Cyber All Game Q.10 Premium'},
    {'value': '3', 'label': '📍 Cyber All Game Q.7 VIP'},
  ],
  'OWNER': [
    {'value': '1', 'label': '📍 Cyber All Game Q.Gò Vấp'},
    {'value': '2', 'label': '📍 Cyber All Game Q.10 Premium'},
  ],
  'MANAGER': [
    {'value': '1', 'label': '📍 Cyber All Game Q.Gò Vấp'},
  ],
};

final selectedBranchProvider = StateProvider<String>((ref) => 'ALL');

// Index for Bottom Navigation Bar (0: Quản lý quán, 1: Thống kê, 2: Thông báo)
final ownerNavIndexProvider = StateProvider<int>((ref) => 0);
