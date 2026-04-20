import '../enums.dart'; 

class Usermodel {
  // --- 1. CÁC FIELD KẾT NỐI API THỰC TẾ CỦA M ---
  final int id;
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
  final UserRank? rank;
  final int cagPoints;
  final bool isVerified;
  final String? badge;      
  final List<String> badges; 
  final bool isFollowing;

  Usermodel({
    required this.id,
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
    // Giá trị mặc định giúp app không crash nếu API chưa trả về các field này
    this.isVip = false,
    this.rank,
    this.cagPoints = 0,
    this.isVerified = false,
    this.badge,
    this.badges = const [],
    this.isFollowing = false,
  });

  // --- 3. HÀM CHUYỂN TỪ JSON SANG MODEL (CÓ CHECK NULL) ---
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'] as int? ?? 0,
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
      
      // Các field cộng đồng
      isVip: json['isVip'] as bool? ?? false,
      cagPoints: json['cagPoints'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      badge: json['badge'] as String?, 
      badges: (json['badges'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      isFollowing: json['isFollowing'] as bool? ?? false,
      rank: json['rank'] != null ? UserRank.values.byName(json['rank']) : null,
    );
  }

  // --- 4. HÀM CHUYỂN TỪ MODEL SANG JSON ĐỂ ĐẨY LÊN API ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userType': userType,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'username': username,
      'password': password,
      'province': province,
      'commune': commune,
      'district': district,
      'avatarUrl': avatarUrl,
      'isVip': isVip,
      'cagPoints': cagPoints,
      'isVerified': isVerified,
      'badge': badge,
      'badges': badges,
      'isFollowing': isFollowing,
    };
  }

  // --- 5. HÀM SAO CHÉP ĐỂ CẬP NHẬT STATE (DÙNG TRONG PROVIDER/UI) ---
  Usermodel copyWith({
    int? id,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    bool? isVip,
    int? cagPoints,
    bool? isVerified,
    String? badge,
    List<String>? badges,
    bool? isFollowing,
    UserRank? rank,
  }) {
    return Usermodel(
      id: id ?? this.id,
      userType: userType,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email,
      username: username,
      password: password,
      province: province,
      commune: commune,
      district: district,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVip: isVip ?? this.isVip,
      cagPoints: cagPoints ?? this.cagPoints,
      isVerified: isVerified ?? this.isVerified,
      badge: badge ?? this.badge,
      badges: badges ?? this.badges,
      isFollowing: isFollowing ?? this.isFollowing,
      rank: rank ?? this.rank,
    );
  }
}
