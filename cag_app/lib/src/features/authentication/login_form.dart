import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/auth_api.dart';
import 'package:CAG_App/src/features/authentication/auth_provider.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  final Color activeColor;
  final bool isGamer;
  const LoginForm({super.key, required this.activeColor, required this.isGamer});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isRemember = false;
  bool _isLoading = false;
  String? _errorMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentContext != null) {
        final renderBox = _formKey.currentContext!.findRenderObject() as RenderBox;
        // Cập nhật chiều cao thực tế lên Provider
        ref.read(authFormHeightProvider.notifier).state = renderBox.size.height;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateHeight(); // Đo lần đầu
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Vui lòng nhập tài khoản và mật khẩu.');
      _updateHeight();
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authApi = ref.read(authApiProvider);
      final response = await authApi.login(
        username: username,
        password: password,
        isGamer: widget.isGamer,
      );

      // Lưu token + role vào secure storage
      await StorageHelper.saveAuthData(token: response.token, role: response.role);

      // Cập nhật lại authChecker để chuyển hướng nếu cần (nếu bạn dùng nó để điều hướng)
      ref.invalidate(authCheckerProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công')),
      );

      // Đóng màn hình xác thực sau khi đăng nhập thành công
      Navigator.of(context).pop();
    } on AuthException catch (e) {
      setState(() => _errorMessage = e.message);
      _updateHeight();
    } catch (_) {
      setState(() => _errorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.');
      _updateHeight();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //_buildRoleToggle( widget.activeColor), // Nhận activeColor từ AuthScreen
            //const SizedBox(height: 20),

            // Ô Tài khoản
            CagTextField(
              controller: _usernameController,
              label: "TÀI KHOẢN",
              hint: "Nhập SĐT/Username...",
              activeColor: widget.activeColor, // Nhận từ AuthScreen (Cyan hoặc Gold)
              borderRadius: 8,
              verticalPadding: 15,
            ),
            const SizedBox(height: 15),

            // Ô Mật khẩu
            CagTextField(
              controller: _passwordController,
              label: "MẬT KHẨU",
              hint: "••••••••",
              activeColor: widget.activeColor,
              isPassword: true,
              borderRadius: 8,
              verticalPadding: 15,
            ),
            const SizedBox(height: 20),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),

            // Hàng Ghi nhớ & Quên mật khẩu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isRemember = !isRemember),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: isRemember ? widget.activeColor : Colors.transparent,
                          border: Border.all(color: isRemember ? widget.activeColor : Colors.white24),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: isRemember 
                            ? const Icon(Icons.check, size: 14, color: AppTheme.textBlack) 
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Ghi nhớ đăng nhập",
                        style: TextStyle(
                          color: isRemember ? Colors.white : Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text("Quên mật khẩu?", style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),

            const SizedBox(height: 10),

            // Nút Đăng nhập
            GestureDetector(
              onTap: _isLoading ? null : _login,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: widget.activeColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Center(
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.textBlack,
                          ),
                        )
                      : const Text(
                          "ĐĂNG NHẬP NGAY",
                          style: TextStyle(color: AppTheme.textBlack, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildRoleToggle để chọn giữa GAMER và CHỦ PHÒNG
  // Widget _buildRoleToggle(Color activeColor) {
  //   return Container(
  //     padding: const EdgeInsets.all(4),
  //     decoration: BoxDecoration(
  //       color: Colors.black26,
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(child: _roleOption("GAMER", widget.isGamer, AppTheme.cyanNeon)),
  //         Expanded(child: _roleOption("CHỦ PHÒNG", !widget.isGamer, AppTheme.gold)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _roleOption để tạo từng lựa chọn vai trò
//   Widget _roleOption(String title, bool isSelected, Color color) {
//     return GestureDetector(
//       onTap: () {
//         ref.read(isGamerProvider.notifier).state = (title == "GAMER");
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? color : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: isSelected ? Colors.black : Colors.white24,
//             fontWeight: FontWeight.w900,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }
}