import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/owner_home_providers.dart';

class OwnerHomeController {
  final WidgetRef ref;

  OwnerHomeController(this.ref);

  // ===== ROLE =====
  void changeRole(String role) {
    // cập nhật role
    ref.read(ownerRoleProvider.notifier).state = role;

    // lấy danh sách branch theo role
    final newBranches = branchMapping[role] ?? branchMapping['BOSS']!;

    // kiểm tra branch hiện tại có hợp lệ không
    final currentBranch = ref.read(selectedBranchProvider);

    final isValid =
        newBranches.any((b) => b['value'] == currentBranch);

    // nếu không hợp lệ thì reset
    if (!isValid) {
      ref.read(selectedBranchProvider.notifier).state =
          newBranches.first['value']!;
    }
  }

  // ===== BRANCH =====
  void changeBranch(String branch) {
    ref.read(selectedBranchProvider.notifier).state = branch;
  }

  // ===== NAVIGATION =====
  void changeTab(int index) {
    ref.read(ownerNavIndexProvider.notifier).state = index;
  }

  // ===== GET BRANCH LIST =====
  List<Map<String, String>> getBranches(String role) {
    return branchMapping[role] ?? branchMapping['BOSS']!;
  }
}