class LoginResponse {
  final bool success;
  final int statusCode;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final String? refreshTokenExpires;

  LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.refreshTokenExpires,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return LoginResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      accessToken: data?['accessToken'],
      refreshToken: data?['refreshToken'],
      refreshTokenExpires: data?['refreshTokenExpires'],
    );
  }
}