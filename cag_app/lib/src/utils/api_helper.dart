import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CAG_App/src/constants/api_constants.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';

class ApiHelper {
  static bool _isRefreshing = false; 

  // HÀM TỰ ĐỘNG ĐỔI TOKEN 
  static Future<bool> _refreshToken() async {
    try {
      final refreshToken = await StorageHelper.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) return false;

      // Dùng chung file hằng số
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.refreshTokenEndpoint}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        await StorageHelper.saveTokens(
          accessToken: jsonBody['accessToken'],
          refreshToken: jsonBody['refreshToken'],
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // HÀM GỌI API CHÍNH (Tự động lo việc gắn Header và Đổi Token) 
  static Future<http.Response> get(Uri url) async {
    String? token = await StorageHelper.getToken();

    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Bị lỗi 401 thì đi đổi Token
    if (response.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        bool success = await _refreshToken();
        _isRefreshing = false;

        if (success) {
          // Lấy token mới và gọi lại
          String? newToken = await StorageHelper.getToken();
          return await http.get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $newToken',
            },
          );
        } else {
          // Hết hạn cả 2 thì xóa data để user đăng nhập lại
          await StorageHelper.clearAuthData();
        }
      }
    }
    return response;
  }

  // --- HÀM PUT (Dùng cho update profile) ---
  static Future<http.Response> put(Uri url, {Map<String, dynamic>? body}) async {
    String? token = await StorageHelper.getToken();

    http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      bool success = await _refreshToken();
      _isRefreshing = false;

      if (success) {
        String? newToken = await StorageHelper.getToken();
        return await http.put(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $newToken',
          },
          body: body != null ? jsonEncode(body) : null,
        );
      } else {
        await StorageHelper.clearAuthData();
      }
    }
    return response;
  }

  // --- HÀM GỬI FILE (Dùng cho upload avatar) ---
  static Future<http.Response> uploadFile(Uri url, String fileKey, String filePath) async {
    String? token = await StorageHelper.getToken();

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    // Gắn file vào request theo fileKey (chút nữa mình sẽ truyền chữ 'file' vào đây)
    request.files.add(await http.MultipartFile.fromPath(fileKey, filePath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      bool success = await _refreshToken();
      _isRefreshing = false;

      if (success) {
        String? newToken = await StorageHelper.getToken();
        var retryRequest = http.MultipartRequest('POST', url);
        retryRequest.headers['Authorization'] = 'Bearer $newToken';
        retryRequest.files.add(await http.MultipartFile.fromPath(fileKey, filePath));
        
        var retryStreamedResponse = await retryRequest.send();
        return await http.Response.fromStream(retryStreamedResponse);
      } else {
        await StorageHelper.clearAuthData();
      }
    }
    return response;
  }
}
