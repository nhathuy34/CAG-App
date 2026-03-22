import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentContext != null) {
        final renderBox =
            _formKey.currentContext!.findRenderObject() as RenderBox;
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        key: _formKey,
        children: [
          //_buildRoleToggle( widget.activeColor), // Nhận activeColor từ AuthScreen
          //const SizedBox(height: 20),

          // Ô Tài khoản
          CagTextField(
            label: "TÀI KHOẢN",
            hint: "Nhập SĐT/Username...",
            activeColor:
                AppTheme.cyanNeon, // Nhận từ AuthScreen (Cyan hoặc Gold)
            borderRadius: 8,
            verticalPadding: 15,
          ),
          const SizedBox(height: 15),

          // Ô Mật khẩu
          CagTextField(
            label: "MẬT KHẨU",
            hint: "••••••••",
            activeColor: AppTheme.cyanNeon,
            isPassword: true,
            borderRadius: 8,
            verticalPadding: 15,
          ),
          const SizedBox(height: 20),

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
                        color: isRemember
                            ? widget.activeColor
                            : Colors.transparent,
                        border: Border.all(
                          color: isRemember
                              ? widget.activeColor
                              : Colors.white24,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isRemember
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: AppTheme.textBlack,
                            )
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
              const Text(
                "Quên mật khẩu?",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Nút Đăng nhập
          CagPrimaryButton(
            text: "ĐĂNG NHẬP NGAY",
            backgroundColor: widget.activeColor,
            height: 55,
            borderRadius: 12,
            onPressed: () {
              // Xử lý login
            },
          ),
        ],
      ),
    );
  }
}
