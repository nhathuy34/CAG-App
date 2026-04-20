import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CAG_App/src/constants/api_constants.dart'; 
import 'package:CAG_App/src/models/login_response.dart'; 
import 'package:CAG_App/src/models/register_response.dart';

class AuthApi {
  Future<LoginResponse> login(String account, String password) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "account": account,
          "password": password,
        }),
      );
      
      final jsonBody = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonBody);
    } catch (e) {
      return LoginResponse(
        success: false,
        statusCode: 500,
        message: 'Lỗi kết nối máy chủ: $e',
      );
    }
  }

  // --- 2. API ĐĂNG KÝ ---
  Future<RegisterResponse> register({
    required int userType,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required String province,
    required String commune,
    required String addressDetail,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}'); 
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userType": userType,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "email": email,
          "username": username,
          "password": password,
          "confirmPassword": confirmPassword,
          "province": province,
          "commune": commune,
          "addressDetail": addressDetail,
        }),
      );
      
      final jsonBody = jsonDecode(response.body);
      return RegisterResponse.fromJson(jsonBody);
    } catch (e) {
      return RegisterResponse(
        success: false,
        statusCode: 500,
        message: 'Lỗi kết nối máy chủ: $e',
      );
    }
  }

}
