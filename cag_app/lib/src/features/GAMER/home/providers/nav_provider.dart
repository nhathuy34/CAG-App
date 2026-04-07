import 'package:flutter_riverpod/legacy.dart';

class NavNotifier extends StateNotifier<int> {
  NavNotifier() : super(0);

  int _previousIndex = 0; 

  // Hàm chuyển tab mới
  void setIndex(int newIndex) {
    if (newIndex == 2 && state != 2) {
      _previousIndex = state;
    }
    state = newIndex;
  }

  void goBackFromScan() {
    state = _previousIndex;
  }
}

final navIndexProvider = StateNotifierProvider.autoDispose<NavNotifier, int>((ref) {
  return NavNotifier();
});