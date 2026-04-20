import 'dart:convert';
import 'package:CAG_App/src/constants/api_constants.dart';
import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:CAG_App/src/utils/api_helper.dart'; 

class ProfileApi {
  Future<Usermodel?> getMe() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.profileEndpoint}');
      final response = await ApiHelper.get(url); 

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody['success'] == true && jsonBody['data'] != null) {
          
          var rawData = jsonBody['data'];
          String? rawPath = rawData['url'] ?? rawData['avatarUrl'];
          if (rawPath != null && rawPath.isNotEmpty) {
          if (rawPath.startsWith('/')) {
            rawData['avatarUrl'] = '${ApiConstants.domain}$rawPath';
          } else {
            rawData['avatarUrl'] = rawPath;
          }
        }

          if (rawData['avatarUrl'] != null && rawData['avatarUrl'].toString().startsWith('/')) {
            rawData['avatarUrl'] = '${ApiConstants.domain}${rawData['avatarUrl']}';
          }

          if (rawData['fullName'] == null && rawData['username'] != null) {
            rawData['fullName'] = rawData['username'];
          }

          return Usermodel.fromJson(rawData);
        }
      } else {
        print("Lỗi API Profile: ${response.statusCode} - ${response.body}");
      }
      return null;
    } catch (e) {
      print("Ngoại lệ khi gọi API Profile: $e");
      return null;
    }
  }

  // 1. Cập nhật Thông tin
  // Hàm này nằm trong class ProfileApi nhé!
  Future<bool> updateProfile(String username, String phoneNumber, {String? avatarUrl}) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateProfileEndpoint}');
      
      final Map<String, dynamic> bodyData = {
        "username": username,
        "phoneNumber": phoneNumber,
      };
      
      if (avatarUrl != null) {
        bodyData["avatarUrl"] = avatarUrl;
      }

      final response = await ApiHelper.put(url, body: bodyData);

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        return jsonBody['success'] == true;
      }
      return false;
    } catch (e) {
      print("Lỗi API Update Profile: $e");
      return false;
    }
  }

  Future<String?> uploadAvatar(String imagePath) async {
  try {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.uploadAvatarEndpoint}');
    final response = await ApiHelper.uploadFile(url, 'file', imagePath);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      
      final String? relativeUrl = jsonBody['url']; 
      
      if (relativeUrl != null) {
        return relativeUrl.startsWith('/') 
            ? '${ApiConstants.domain}$relativeUrl' 
            : relativeUrl;
      }
    }
    return null;
  } catch (e) {
    return null;
  }
}
}
