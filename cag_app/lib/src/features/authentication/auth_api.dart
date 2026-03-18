import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

/// Thay giá trị này bằng URL thực tế của API backend của bạn.
/// Ví dụ: https://api.example.com
const String _kBaseUrl = 'https://example.com';

/// Endpoint login.
const String _kLoginPath = '/auth/login';

/// Endpoint register.
const String _kRegisterPath = '/auth/register';

/// Các kiểu lỗi có thể xảy ra khi gọi API.
enum AuthErrorType { network, unauthorized, server, unknown }

/// Exception được dùng để phân biệt lỗi và hiển thị thông báo người dùng.
class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  AuthException(this.message, {this.type = AuthErrorType.unknown});

  @override
  String toString() => message;
}

/// Model dữ liệu phản hồi sau khi đăng nhập thành công.
class AuthResponse {
  final String token;
  final String role;

  AuthResponse({required this.token, required this.role});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      role: json['role'] as String,
    );
  }
}

/// API client đơn giản cho việc xác thực.
class AuthApi {
  final http.Client _client;

  AuthApi({http.Client? client}) : _client = client ?? http.Client();

  /// Gọi API login.
  ///
  /// Parameter `isGamer` sẽ giúp backend xác định role nếu cần.
  /// Thay đổi payload theo yêu cầu của backend thực tế.
  Future<AuthResponse> login({
    required String username,
    required String password,
    required bool isGamer,
  }) async {
    final uri = Uri.parse('$_kBaseUrl$_kLoginPath');

    try {
      final response = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'password': password,
              'role': isGamer ? 'gamer' : 'owner',
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthResponse.fromJson(json);
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw AuthException(
          'Tài khoản hoặc mật khẩu không đúng.',
          type: AuthErrorType.unauthorized,
        );
      }

      if (response.statusCode >= 500) {
        throw AuthException(
          'Máy chủ gặp sự cố. Vui lòng thử lại sau.',
          type: AuthErrorType.server,
        );
      }

      final message = _parseErrorMessage(response.body);
      throw AuthException('Đăng nhập thất bại: $message');
    } on SocketException catch (_) {
      throw AuthException(
        'Không thể kết nối mạng. Vui lòng kiểm tra kết nối internet và thử lại.',
        type: AuthErrorType.network,
      );
    } on TimeoutException catch (_) {
      throw AuthException(
        'Yêu cầu mất quá nhiều thời gian. Vui lòng thử lại.',
        type: AuthErrorType.network,
      );
    } on http.ClientException catch (_) {
      throw AuthException(
        'Lỗi mạng nội bộ. Vui lòng thử lại.',
        type: AuthErrorType.network,
      );
    }
  }

  /// Gọi API register.
  ///
  /// Lưu ý: payload phải khớp với backend của bạn.
  Future<AuthResponse> register({
    required String fullName,
    required String phone,
    required String email,
    required String username,
    required String password,
    required bool isGamer,
    required String province,
    required String district,
    required String address,
  }) async {
    final uri = Uri.parse('$_kBaseUrl$_kRegisterPath');

    try {
      final response = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'fullname': fullName,
              'phone': phone,
              'email': email,
              'username': username,
              'password': password,
              'role': isGamer ? 'gamer' : 'owner',
              'province': province,
              'district': district,
              'address': address,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthResponse.fromJson(json);
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw AuthException(
          'Không có quyền thực hiện thao tác.',
          type: AuthErrorType.unauthorized,
        );
      }

      if (response.statusCode >= 500) {
        throw AuthException(
          'Máy chủ gặp sự cố. Vui lòng thử lại sau.',
          type: AuthErrorType.server,
        );
      }

      final message = _parseErrorMessage(response.body);
      throw AuthException('Đăng ký thất bại: $message');
    } on SocketException catch (_) {
      throw AuthException(
        'Không thể kết nối mạng. Vui lòng kiểm tra kết nối internet và thử lại.',
        type: AuthErrorType.network,
      );
    } on TimeoutException catch (_) {
      throw AuthException(
        'Yêu cầu mất quá nhiều thời gian. Vui lòng thử lại.',
        type: AuthErrorType.network,
      );
    } on http.ClientException catch (_) {
      throw AuthException(
        'Lỗi mạng nội bộ. Vui lòng thử lại.',
        type: AuthErrorType.network,
      );
    }
  }

  String _parseErrorMessage(String body) {
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      if (json.containsKey('message')) return json['message'] as String;
      if (json.containsKey('error')) return json['error'] as String;
    } catch (_) {
      // ignore
    }
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }
}

final authApiProvider = Provider<AuthApi>((ref) => AuthApi());
