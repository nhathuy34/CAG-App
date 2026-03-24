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
  });

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  Usermodel copyWith({String? fullName, String? phoneNumber,String? avatarUrl}) {
    return Usermodel(
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
    );
  }
}
