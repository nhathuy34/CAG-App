class OwnerHomeState {
  final String role;
  final String branch;
  final int navIndex;

  const OwnerHomeState({
    required this.role,
    required this.branch,
    required this.navIndex,
  });

  // ===== COPY =====
  OwnerHomeState copyWith({
    String? role,
    String? branch,
    int? navIndex,
  }) {
    return OwnerHomeState(
      role: role ?? this.role,
      branch: branch ?? this.branch,
      navIndex: navIndex ?? this.navIndex,
    );
  }

  // ===== DEFAULT =====
  factory OwnerHomeState.initial() {
    return const OwnerHomeState(
      role: 'BOSS',
      branch: 'ALL',
      navIndex: 0,
    );
  }

  // ===== DEBUG (optional) =====
  @override
  String toString() {
    return 'OwnerHomeState(role: $role, branch: $branch, navIndex: $navIndex)';
  }
}