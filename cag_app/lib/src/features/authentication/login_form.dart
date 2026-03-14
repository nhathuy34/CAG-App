import 'package:cag_app/src/constants/app_theme.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Color activeColor;
  const LoginForm({super.key, required this.activeColor});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField("TÀI KHOẢN (SĐT/USERNAME)", "Nhập tên đăng nhập..."),
        const SizedBox(height: 15),
        _buildTextField("MẬT KHẨU", "••••••••", isPassword: true),
        const SizedBox(height: 15),
        
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
                        ? const Icon(Icons.check, size: 14, color: Colors.black) 
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
        
        const SizedBox(height: 30),
        
        // Nút Đăng nhập
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: widget.activeColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: widget.activeColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: const Center(
            child: Text(
              "ĐĂNG NHẬP NGAY",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textDim, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderWhite),
          ),
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: AppTheme.textWhite),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppTheme.textHint, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}