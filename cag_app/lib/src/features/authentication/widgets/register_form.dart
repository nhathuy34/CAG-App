import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/repositories/auth_repository.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final Color activeColor;
  final bool isGamer;
  const RegisterForm({
    super.key,
    required this.activeColor,
    required this.isGamer,
  });

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  bool isAgree = false;
  final GlobalKey _formKey = GlobalKey();

  // Các biến quản lý lỗi & loading
  String? inlineErrorText;
  bool showBannerError = false;
  String bannerErrorMessage = "";
  bool isLoading = false;

  // 1 NHÚM CONTROLLER CHO CÁC Ô NHẬP LIỆU
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
  final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ); // Regex check định dạng email

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

    // Check lỗi live cho ô SĐT
    _phoneController.addListener(() {
      final text = _phoneController.text;
      setState(() {
        if (text.isEmpty) {
          inlineErrorText = null;
        } else if (!text.startsWith('0') ||
            text.length < 10 ||
            !phoneRegex.hasMatch(text)) {
          inlineErrorText = "Số điện thoại không hợp lệ";
        } else {
          inlineErrorText = null;
        }
        showBannerError = false; // Đang gõ lại thì tắt banner to đi
      });
      _updateHeight();
    });
  }

  @override
  void dispose() {
    // Nhớ dọn rác bộ nhớ
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (isLoading) return;

    final nameText = _nameController.text.trim();
    final phoneText = _phoneController.text.trim();
    final emailText = _emailController.text.trim();
    final passwordText = _passwordController.text.trim();
    final confirmText = _confirmPasswordController.text.trim();

    // 1. Kiểm tra Checkbox Điều Khoản
    if (!isAgree) {
      setState(() {
        bannerErrorMessage = "Vui lòng đồng ý với Điều Khoản Sử Dụng!";
        showBannerError = true;
      });
      _updateHeight();
      return;
    }

    if (nameText.isEmpty ||
        phoneText.isEmpty ||
        emailText.isEmpty ||
        passwordText.isEmpty) {
      setState(() {
        bannerErrorMessage = "Vui lòng điền đầy đủ các trường bắt buộc (*)";
        showBannerError = true;
      });
      _updateHeight();
      return;
    }

    if (!phoneRegex.hasMatch(phoneText)) {
      setState(() {
        bannerErrorMessage = "Số điện thoại không hợp lệ!";
        showBannerError = true;
      });
      _updateHeight();
      return;
    }

    if (!emailRegex.hasMatch(emailText)) {
      setState(() {
        bannerErrorMessage = "Định dạng Email không hợp lệ!";
        showBannerError = true;
      });
      _updateHeight();
      return;
    }

    if (passwordText != confirmText) {
      setState(() {
        bannerErrorMessage = "Mật khẩu nhập lại không khớp!";
        showBannerError = true;
      });
      _updateHeight();
      return;
    }

    setState(() {
      showBannerError = false;
      isLoading = true;
    });

    // Xem đang chọn tab Game thủ hay Chủ quán (Giả sử: Game thủ = 4, Chủ quán = 5)
    final isGamerActive = ref.read(isGamerProvider);
    final userType = isGamerActive ? 4 : 5;

    final authRepo = AuthRepository();
    final response = await authRepo.registerRepo(
      userType: userType,
      fullName: nameText,
      phoneNumber: phoneText,
      email: emailText,
      username: phoneText,
      password: passwordText,
      confirmPassword: confirmText,
      province: "01",
      commune: "001",
      addressDetail: "Đang cập nhật",
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Đăng ký thành công! Vui lòng đăng nhập.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );

      // 2. Xóa trắng form
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() => isAgree = false);

      DefaultTabController.of(context).animateTo(0);
    } else {
      setState(() {
        bannerErrorMessage = response.message;
        showBannerError = true;
      });
      _updateHeight();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGamerActive = ref.watch(isGamerProvider);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        key: _formKey,
        children: [
          // TIÊU ĐỀ
          Text(
            "TẠO TÀI KHOẢN MỚI",
            style: TextStyle(
              color: AppTheme.cyanNeon,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          // TAB CHỌN ROLE
          _buildRoleToggle(widget.activeColor, isGamerActive),
          const SizedBox(height: 20),

          if (showBannerError)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1619),
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bannerErrorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => showBannerError = false);
                      _updateHeight();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

          // Ô HỌ TÊN
          CagTextField(
            controller: _nameController, // <-- Gắn Controller
            label: "HỌ VÀ TÊN *",
            hint: "Nguyễn Văn A",
            activeColor: widget.activeColor,
            borderRadius: 8,
            verticalPadding: 12,
          ),
          const SizedBox(height: 15),

          // Ô SỐ ĐIỆN THOẠI
          CagTextField(
            controller: _phoneController, // <-- Gắn Controller
            label: "SỐ ĐIỆN THOẠI (TÊN ĐĂNG NHẬP) *",
            hint: "0912345678",
            activeColor: inlineErrorText != null
                ? Colors.redAccent
                : AppTheme.cyanNeon,
            borderRadius: 8,
            verticalPadding: 12,
          ),
          if (inlineErrorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                inlineErrorText!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
          const SizedBox(height: 15),

          // Ô GMAIL & NÚT GỬI OTP
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CagTextField(
                  controller: _emailController, // <-- Gắn Controller
                  label: "GMAIL *",
                  hint: "nguyena@gmail.com",
                  activeColor: widget.activeColor,
                  borderRadius: 8,
                  verticalPadding: 12,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2330),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "GỬI OTP",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // HÀNG 2 Ô: MẬT KHẨU & NHẬP LẠI MK
          Row(
            children: [
              Expanded(
                child: CagTextField(
                  controller: _passwordController, // <-- Gắn Controller
                  label: "MẬT KHẨU *",
                  hint: "••••••",
                  activeColor: widget.activeColor,
                  isPassword: _obscurePassword,
                  borderRadius: 8,
                  verticalPadding: 12,

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CagTextField(
                  controller: _confirmPasswordController, // <-- Gắn Controller
                  label: "NHẬP LẠI MẬT KHẨU *",
                  hint: "••••••",
                  activeColor: widget.activeColor,
                  isPassword: _obscurePassword,
                  borderRadius: 8,
                  verticalPadding: 12,

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // CHECKBOX ĐIỀU KHOẢN
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => setState(() => isAgree = !isAgree),
                child: Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: isAgree ? Colors.white : Colors.transparent,
                    border: Border.all(
                      color: isAgree ? Colors.white : Colors.white24,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isAgree
                      ? const Icon(Icons.check, size: 14, color: Colors.black)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                    children: [
                      const TextSpan(text: "Tôi đã đọc và đồng ý tất cả các "),
                      TextSpan(
                        text: "Điều Khoản Sử Dụng",
                        style: TextStyle(
                          color: AppTheme.cyanNeon,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // NÚT ĐĂNG KÝ TÀI KHOẢN
          CagPrimaryButton(
            text: isLoading
                ? "ĐANG XỬ LÝ..."
                : "ĐĂNG KÝ TÀI KHOẢN", // Hiện trạng thái loading
            backgroundColor: widget.activeColor,
            height: 55,
            borderRadius: 12,
            onPressed: () {
              _handleRegister(); // Gọi hàm đăng ký!
            },
          ),

          // const SizedBox(height: 30),

          // // TEXT THOÁT
          // const Text(
          //   "Nhấn phím ESC để thoát",
          //   style: TextStyle(color: Colors.white24, fontSize: 12),
          // ),
        ],
      ),
    );
  }

  // =========================================================================
  // WIDGET TOGGLE ROLE (CHỌN GAME THỦ HAY CHỦ QUÁN)
  // =========================================================================
  Widget _buildRoleToggle(Color activeColor, bool isGamerActive) {
    return Row(
      children: [
        Expanded(
          child: _roleOption(
            "TÔI LÀ GAME THỦ",
            isGamerActive,
            AppTheme.cyanNeon,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _roleOption("TÔI LÀ CHỦ QUÁN", !isGamerActive, AppTheme.gold),
        ),
      ],
    );
  }

  Widget _roleOption(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        ref.read(isGamerProvider.notifier).state = (title == "TÔI LÀ GAME THỦ");
        _updateHeight();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.white10,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? color.withOpacity(0.05) : Colors.transparent,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? color : Colors.white24,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
