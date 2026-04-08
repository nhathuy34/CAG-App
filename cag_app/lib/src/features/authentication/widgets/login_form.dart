import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/widgets/forgot_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/GAMER/home/screens/homepage_screen.dart';

class LoginForm extends ConsumerStatefulWidget {
  final Color activeColor;
  final bool isGamer;
  const LoginForm({
    super.key,
    required this.activeColor,
    required this.isGamer,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isRemember = false;
  final GlobalKey _formKey = GlobalKey();
  bool _isHoverForgot = false;
  bool showBannerError = false;

  String? inlineErrorText;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscurePassword = true;


  final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentContext != null) {
        final renderBox =
            _formKey.currentContext!.findRenderObject() as RenderBox;
        ref.read(authFormHeightProvider.notifier).state = renderBox.size.height;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateHeight();

    // Lắng nghe từng chữ người dùng gõ vào để báo lỗi ngay dưới ô nhập
    _phoneController.addListener(() {
      final text = _phoneController.text;

      setState(() {
        if (text.isEmpty) {
          inlineErrorText = null;
        } else if (!text.startsWith('0') ||
            text.length < 10 ||
            !phoneRegex.hasMatch(text)) {
          // Báo lỗi nhỏ dưới ô nếu nhập bậy hoặc đang gõ chưa đủ 10 số
          inlineErrorText = "Số điện thoại không hợp lệ";
        } else {
          inlineErrorText = null;
        }
        showBannerError = false;
      });
      _updateHeight();
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (isLoading) return;

    final phoneText = _phoneController.text.trim();
    final passwordText = _passwordController.text.trim();

    bool isMatch = phoneRegex.hasMatch(phoneText);

    // Validate Input
    if (phoneText.isEmpty || !isMatch) {
      setState(() => showBannerError = true);
      _updateHeight();
      return;
    }

    if (passwordText.isEmpty) {
      setState(() {
        inlineErrorText = "Vui lòng nhập mật khẩu";
      });
      return;
    }

    // Bắt đầu gọi API
    setState(() {
      showBannerError = false;
      inlineErrorText = null;
      isLoading = true;
    });

    final authRepo = ref.read(authRepositoryProvider);
    final response = await authRepo.loginRepo(
      phoneText,
      passwordText,
      isRemember,
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    // Xử lý kết quả trả về
    if (response.success) {
      ref.read(authStateProvider.notifier).state = 'GAMER';
      ref.invalidate(userProfileProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Đăng nhập thành công!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      // 2. Chuyển hướng sang HomePageScreen (Và xóa màn hình login khỏi lịch sử để không back lại được)
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePageScreen()),
        (route) => false,
      );
    } else {
      // Hiển thị lỗi từ server
      setState(() {
        inlineErrorText = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        key: _formKey, // Đảm bảo key này bọc TẤT CẢ nội dung bên dưới
        children: [
          // 1. BANNER LỖI
          if (showBannerError)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1619),
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Số điện thoại không hợp lệ!",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white54,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() => showBannerError = false);
                      _updateHeight();
                    },
                  ),
                ],
              ),
            ),

          // 2. Ô NHẬP SĐT
          CagTextField(
            controller: _phoneController,
            label: "SỐ ĐIỆN THOẠI ĐĂNG NHẬP *",
            hint: "0xxxxxxxxx",
            activeColor: inlineErrorText != null
                ? Colors.redAccent
                : AppTheme.cyanNeon,
            borderRadius: 8,
          ),
          if (inlineErrorText != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 4),
                child: Text(
                  inlineErrorText!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ),
            ),

          const SizedBox(height: 15),

          // 3. Ô NHẬP MẬT KHẨU
          CagTextField(
            controller: _passwordController,
            label: "MẬT KHẨU *",
            hint: "••••••••",
            activeColor: AppTheme.cyanNeon,
            isPassword: _obscurePassword,
            borderRadius: 8,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          // 4. HÀNG GHI NHỚ & QUÊN MK
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => isRemember = !isRemember),
                child: Row(
                  children: [
                    Checkbox(
                      value: isRemember,
                      onChanged: (v) => setState(() => isRemember = v!),
                      activeColor: AppTheme.cyanNeon,
                      visualDensity: VisualDensity.compact,
                    ),
                    const Text(
                      "Ghi nhớ tài khoản",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // NÚT QUÊN MẬT KHẨU (GỌI DIALOG)
              MouseRegion(
                onEnter: (_) => setState(() => _isHoverForgot = true),
                onExit: (_) => setState(() => _isHoverForgot = false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const ForgotPasswordDialog(),
                  ),
                  child: Text(
                    "Quên mật khẩu?",
                    style: TextStyle(
                      color: _isHoverForgot ? AppTheme.gold : Colors.white54,
                      fontSize: 12,
                      decoration: _isHoverForgot
                          ? TextDecoration.underline
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 5. NÚT ĐĂNG NHẬP (PHẢI NẰM TRONG COLUMN NÀY)
          CagPrimaryButton(
            text: isLoading ? "ĐANG XỬ LÝ..." : "ĐĂNG NHẬP NGAY",
            backgroundColor: widget.activeColor,
            height: 50,
            borderRadius: 12,
            onPressed: _handleLogin,
          ),

          const SizedBox(height: 20),
          //const Text("Nhấn phím quay lại để thoát", style: TextStyle(color: Colors.white24, fontSize: 11)),
        ],
      ),
    );
  }
}
