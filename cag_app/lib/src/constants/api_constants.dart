class ApiConstants {
  // Đường dẫn gốc của Server
  static const String baseUrl = 'https://apicagguide.icafevietnam.com:5100/api';

  static const String domain = 'https://apicagguide.icafevietnam.com:5100';

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String profileEndpoint = '/auth/me';
  static const String refreshTokenEndpoint = '/refreshtoken';

  static const String updateProfileEndpoint = '/user/updateprofile';
  static const String uploadAvatarEndpoint = '/user/upload-avatar';
}
