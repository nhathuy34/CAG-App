import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Đảm bảo import đúng đường dẫn màn hình chính của bạn:
import 'package:CAG_App/src/features/GAMER/home/screens/homepage_screen.dart'; 
// Import Dialog khôi phục mật khẩu:
import 'package:CAG_App/src/features/authentication/widgets/forgot_password_dialog.dart';

class LoginForm extends ConsumerStatefulWidget {
  final Color activeColor;
  final bool isGamer;
  const LoginForm({super.key, required this.activeColor, required this.isGamer});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isRemember = false;
  bool _isHoveringForgotPass = false;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentContext != null) {
        final renderBox = _formKey.currentContext!.findRenderObject() as RenderBox;
        final screenHeight = MediaQuery.of(context).size.height;
        double finalHeight = renderBox.size.height;
        
        if (finalHeight > screenHeight * 0.75) {
          finalHeight = screenHeight * 0.75;
        }

        ref.read(authFormHeightProvider.notifier).state = finalHeight;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateHeight(); 
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), 
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CagTextField(
              controller: _accountController,
              label: "TÀI KHOẢN",
              hint: "Nhập SĐT/Username...",
              activeColor: AppTheme.cyanNeon,
              borderRadius: 8,
              verticalPadding: 15,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Vui lòng nhập tài khoản';
                return null;
              },
            ),
            const SizedBox(height: 15),

            CagTextField(
              controller: _passwordController,
              label: "MẬT KHẨU",
              hint: "••••••••",
              activeColor: AppTheme.cyanNeon,
              isPassword: true,
              borderRadius: 8,
              verticalPadding: 15,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu';
                if (value.length < 6) return 'Mật khẩu phải từ 6 ký tự';
                return null;
              },
            ),
            const SizedBox(height: 20),
            
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
                        child: isRemember ? const Icon(Icons.check, size: 14, color: AppTheme.textBlack) : null,
                      ),
                      const SizedBox(width: 8),
                      Text("Ghi nhớ đăng nhập", style: TextStyle(color: isRemember ? Colors.white : Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringForgotPass = true),
                  onExit: (_) => setState(() => _isHoveringForgotPass = false),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      // 1. MỞ BẢNG VÀ CHỜ KẾT QUẢ TRẢ VỀ TỪ DIALOG
                      final result = await showDialog(
                        context: context,
                        builder: (context) => const ForgotPasswordDialog(),
                      );
                      
                      // 2. NẾU NHẬN ĐƯỢC TÍN HIỆU 'register', CHUYỂN SANG TAB ĐĂNG KÝ
                      if (result == 'register') {
                        DefaultTabController.of(context)?.animateTo(1);
                      }
                    },
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: _isHoveringForgotPass ? AppTheme.cyanNeon : Colors.white54, 
                        fontSize: 12,
                        decoration: _isHoveringForgotPass ? TextDecoration.underline : TextDecoration.none, 
                        decorationColor: AppTheme.cyanNeon,
                        fontWeight: _isHoveringForgotPass ? FontWeight.bold : FontWeight.normal,
                      ),
                      child: const Text("Quên mật khẩu?"),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            
            GestureDetector(
              onTap: () {
                bool isValid = _formKey.currentState!.validate();
                _updateHeight(); 

                if (isValid) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePageScreen()), 
                  );
                }
              },
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
                child: const Center(
                  child: Text(
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
}