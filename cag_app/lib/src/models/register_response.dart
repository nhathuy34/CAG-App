class RegisterResponse {
  final bool success;
  final int statusCode;
  final String message;
  final RegisterData? data;

  RegisterResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
    );
  }
}

class RegisterData {
  final int? userId;
  final String? username;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? province;
  final String? commune;
  final String? addressDetail;

  RegisterData({
    this.userId,
    this.username,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.province,
    this.commune,
    this.addressDetail,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userId: json['userId'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      province: json['province'],
      commune: json['commune'],
      addressDetail: json['addressdetail'], // 'd' viết thường theo Postman
    );
  }
}