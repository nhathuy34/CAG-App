import 'package:flutter_riverpod/legacy.dart';

// Index for Sub-features (0: Tổng quan, 1: Booking, 2: Hồ Sơ, 3: Marketing, 4: Cài Đặt)
final ownerSubFeatureIndexProvider = StateProvider<int>((ref) => 0);

// State for FAB Menu expansion
final isFABMenuOpenProvider = StateProvider<bool>((ref) => false);
