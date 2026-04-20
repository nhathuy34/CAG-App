import 'package:CAG_App/src/features/authentication/service/auth_api.dart';
import 'package:CAG_App/src/models/login_response.dart';
import 'package:CAG_App/src/models/register_response.dart';
import 'package:CAG_App/src/utils/storage_helper.dart'; 

class AuthRepository {
  final AuthApi _authApi;

  AuthRepository({AuthApi? authApi}) 
      : _authApi = authApi ?? AuthApi();

  // --- 1. XỬ LÝ ĐĂNG NHẬP ---
  Future<LoginResponse> loginRepo(String account, String password, bool isRemember) async {
    final response = await _authApi.login(account, password);

    // BẮT BUỘC LUÔN LUÔN LƯU TOKEN NẾU ĐĂNG NHẬP THÀNH CÔNG
    if (response.statusCode == 200 && response.success == true) {
      await StorageHelper.saveTokens(
        accessToken: response.accessToken ?? '',
        refreshToken: response.refreshToken ?? '',
      );
    }
    return response;
  }

  // --- 2. XỬ LÝ ĐĂNG KÝ ---
  Future<RegisterResponse> registerRepo({
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
    
    final response = await _authApi.register(
      userType: userType,
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      province: province,
      commune: commune,
      addressDetail: addressDetail,
    );

    return response;
  }

  // --- 3. ĐĂNG XUẤT ---
  Future<void> logout() async {
    await StorageHelper.clearAuthData();
  }
}
