import 'dart:ffi';

import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isRemember = false;
  final GlobalKey _formKey = GlobalKey();

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        key: _formKey,
        children: [
          // Ô Tài khoản
          CagTextField(
            label: "TÀI KHOẢN",
            hint: "Nhập SĐT/Username...",
            activeColor: AppTheme.cyanNeon, // Nhận từ AuthScreen (Cyan hoặc Gold)
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
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white24),
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
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: AppTheme.cyanNeon,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: AppTheme.cyanNeon.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: const Center(
              child: Text(
                "ĐĂNG NHẬP NGAY",
                style: TextStyle(color: AppTheme.textBlack, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}