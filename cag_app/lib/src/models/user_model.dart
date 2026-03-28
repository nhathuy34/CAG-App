import 'enums.dart'; // Bạn cần tạo file enums.dart trước

class Usermodel {
  final int userType;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String username;
  final String password;
  final String province;
  final String commune;
  final String district;
  final String? avatarUrl;
  final bool isVip;
  final String? badge;
  
  // Các field mới từ TS
  final UserRole? role;
  final UserRank? rank;
  final int rankProgress;
  final double balance;
  final int cagPoints;
  final bool isVerified;

  Usermodel({
    required this.userType,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.password,
    required this.province,
    required this.commune,
    required this.district,
    this.avatarUrl,
    this.isVip = false,
    this.badge,
    this.role,
    this.rank,
    this.rankProgress = 0,
    this.balance = 0.0,
    this.cagPoints = 0,
    this.isVerified = false,
  });
  Usermodel copyWith({
    int? userType,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? username,
    String? password,
    String? province,
    String? commune,
    String? district,
    String? avatarUrl,
    bool? isVip,
    String? badge,
    UserRole? role,
    UserRank? rank,
    int? rankProgress,
    double? balance,
    int? cagPoints,
    bool? isVerified,
  }) {
    return Usermodel(
      userType: userType ?? this.userType,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      province: province ?? this.province,
      commune: commune ?? this.commune,
      district: district ?? this.district,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVip: isVip ?? this.isVip,
      badge: badge ?? this.badge,
      role: role ?? this.role,
      rank: rank ?? this.rank,
      rankProgress: rankProgress ?? this.rankProgress,
      balance: balance ?? this.balance,
      cagPoints: cagPoints ?? this.cagPoints,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      userType: json['userType'] as int? ?? 0,
      fullName: json['fullName'] as String? ?? "N/A",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      email: json['email'] as String? ?? "",
      username: json['username'] as String? ?? "",
      password: json['password'] as String? ?? "",
      province: json['province'] as String? ?? "",
      commune: json['commune'] as String? ?? "",
      district: json['district'] as String? ?? "",
      avatarUrl: json['avatarUrl'] as String?,
      isVip: json['isVip'] as bool? ?? false,
      badge: json['badge'] as String?,
      // Map từ TS
      role: json['role'] != null ? UserRole.values.byName(json['role']) : null,
      rank: json['rank'] != null ? UserRank.values.byName(json['rank']) : null,
      rankProgress: json['rankProgress'] as int? ?? 0,
      balance: (json['balance'] as num? ?? 0).toDouble(),
      cagPoints: json['cagPoints'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'userType': userType,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'email': email,
    'username': username,
    'avatarUrl': avatarUrl,
    'isVip': isVip,
    'balance': balance,
    'cagPoints': cagPoints,
  };
}