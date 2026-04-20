import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/constants/app_theme.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  // 0: Nhập SĐT (Mặc định mới), 1: Nhập Email, 2: Reset Password
  int _currentMode = 0;
  bool _isPhoneFound = false;
  bool _isLoading = false;
  String? _inlinePhoneError;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _tempPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');

  @override
  void initState() {
    super.initState();

    // LẮNG NGHE SĐT GIỐNG BÊN LOGIN
    _phoneController.addListener(() {
      final text = _phoneController.text.trim();
      setState(() {
        if (text.isEmpty) {
          _inlinePhoneError = null;
        } else if (!text.startsWith('0') ||
            text.length < 10 ||
            !phoneRegex.hasMatch(text)) {
          _inlinePhoneError = "Số điện thoại không hợp lệ";
        } else {
          _inlinePhoneError = null;
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _tempPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 850;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: isSmall ? size.width * 0.95 : 900,
          height: 440, // Tăng nhẹ chiều cao để chứa lỗi inline
          decoration: BoxDecoration(
            color: AppTheme.cardBg.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.cyanNeon.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanNeon.withOpacity(0.1),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Row(
              children: [
                if (!isSmall) Expanded(flex: 4, child: _buildLeftHeroPanel()),
                Expanded(flex: 5, child: _buildRightActionPanel()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- PANEL TRÁI (GIỮ NGUYÊN STYLE CYBER) ---
  Widget _buildLeftHeroPanel() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBlue.withOpacity(0.5),
        image: const DecorationImage(
          image: NetworkImage(
            'https://img.freepik.com/free-photo/neon-background-with-abstract-shapes_23-2148332152.jpg',
          ),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _badge('SECURITY PROTOCOL'),
                const SizedBox(height: 16),
                Text(
                  "RESTORE\nACCESS",
                  style: GoogleFonts.rajdhani(
                    color: AppTheme.textWhite,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Xác minh danh tính qua Cơ sở dữ liệu hệ thống.",
                  style: TextStyle(color: AppTheme.textDim, fontSize: 14),
                ),
                const SizedBox(height: 40),
                _featureItem(Icons.verified_user, "Bảo mật chuẩn OTP"),
                _featureItem(Icons.history_toggle_off, "Xử lý tức thì"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- PANEL PHẢI ---
  Widget _buildRightActionPanel() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: AppTheme.textDim),
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SingleChildScrollView(child: _buildCurrentForm()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentForm() {
    if (_currentMode == 0) return _formPhone(); // Hiện Phone đầu tiên
    if (_currentMode == 1) return _formEmail();
    return _formReset();
  }

  // 1. FORM NHẬP SĐT (HIỆN TRƯỚC)
  Widget _formPhone() {
    return Column(
      key: const ValueKey(0),
      children: [
        _sectionTitle("TRUY VẤN SỐ ĐIỆN THOẠI", AppTheme.gold),
        const SizedBox(height: 32),
        CagTextField(
          controller: _phoneController,
          label: "SỐ ĐIỆN THOẠI ĐÃ ĐĂNG KÝ",
          hint: "09xxxxxxxx",
          activeColor: _inlinePhoneError != null
              ? AppTheme.statsRed
              : AppTheme.gold,
        ),
        if (_inlinePhoneError != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                _inlinePhoneError!,
                style: const TextStyle(color: AppTheme.statsRed, fontSize: 12),
              ),
            ),
          ),
        const SizedBox(height: 30),
        if (!_isPhoneFound)
          CagPrimaryButton(
            text: _isLoading ? "SEARCHING..." : "TÌM KIẾM TÀI KHOẢN",
            backgroundColor: AppTheme.gold,
            onPressed:
                _inlinePhoneError != null || _phoneController.text.isEmpty
                ? () {} // Disabled nếu lỗi hoặc rỗng
                : () => _runTask(() => setState(() => _isPhoneFound = true)),
          )
        else
          _resultFoundBox(),
        const SizedBox(height: 24),
        _linkBtn(
          "Dùng trực tiếp Email",
          AppTheme.cyanNeon,
          () => setState(() => _currentMode = 1),
        ),
        _linkBtn(
          "Quay lại đăng nhập",
          AppTheme.textDim,
          () => Navigator.pop(context),
        ),
      ],
    );
  }

  // 2. FORM NHẬP EMAIL
  Widget _formEmail() {
    return Column(
      key: const ValueKey(1),
      children: [
        _sectionTitle("KHÔI PHỤC QUA EMAIL", AppTheme.cyanNeon),
        const SizedBox(height: 32),
        CagTextField(
          controller: _emailController,
          label: "EMAIL CỦA BẠN",
          hint: "example@gmail.com",
          activeColor: AppTheme.cyanNeon,
        ),
        const SizedBox(height: 30),
        CagPrimaryButton(
          text: _isLoading ? "EXECUTING..." : "GỬI MẬT KHẨU TẠM THỜI",
          isGradient: true,
          onPressed: () => _runTask(() => setState(() => _currentMode = 2)),
        ),
        const SizedBox(height: 24),
        _linkBtn(
          "← Quay lại tìm bằng SĐT",
          AppTheme.gold,
          () => setState(() => _currentMode = 0),
        ),
      ],
    );
  }

  // 3. FORM THIẾT LẬP MẬT KHẨU MỚI
  Widget _formReset() {
    return Column(
      key: const ValueKey(2),
      children: [
        _sectionTitle("THIẾT LẬP MẬT KHẨU", AppTheme.cyanNeon),
        const SizedBox(height: 24),
        CagTextField(
          controller: _tempPasswordController,
          hint: "Mã xác thực từ Email",
          activeColor: AppTheme.cyanNeon,
        ),
        const SizedBox(height: 12),
        CagTextField(
          controller: _newPasswordController,
          hint: "Mật khẩu mới",
          isPassword: true,
          activeColor: AppTheme.cyanNeon,
        ),
        const SizedBox(height: 30),
        CagPrimaryButton(
          text: "CẬP NHẬT HỆ THỐNG",
          isGradient: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  // --- CÁC COMPONENT PHỤ (Dùng chung AppTheme) ---
  Widget _sectionTitle(String t, Color c) {
    return Column(
      children: [
        Text(
          t,
          style: GoogleFonts.rajdhani(
            color: c,
            fontSize: 21,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: MediaQuery.of(context).size.width * 0.3, // kéo dài hết chiều ngang
          height: 6,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(10), // bo tròn nhẹ
          ),
        ),
      ],
    );
  }

  Widget _badge(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.cyanNeon.withOpacity(0.1),
        border: Border.all(color: AppTheme.cyanNeon.withOpacity(0.5)),
      ),
      child: Text(
        t,
        style: GoogleFonts.rajdhani(
          color: AppTheme.cyanNeon,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _featureItem(IconData i, String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(i, color: AppTheme.cyanNeon, size: 20),
          const SizedBox(width: 12),
          Text(
            t,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _linkBtn(String t, Color c, VoidCallback o) {
    return TextButton(
      onPressed: o,
      child: Text(
        t,
        style: TextStyle(color: c, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _resultFoundBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            "Tài khoản liên kết tìm thấy:",
            style: TextStyle(color: AppTheme.textDim, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            "us***@gmail.com",
            style: GoogleFonts.rajdhani(
              color: AppTheme.gold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CagPrimaryButton(
            text: "SỬ DỤNG EMAIL NÀY",
            height: 45,
            fontSize: 12,
            onPressed: () => setState(() {
              _currentMode = 1;
              _isPhoneFound = false;
            }),
          ),
        ],
      ),
    );
  }

  void _runTask(VoidCallback action) async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      action();
    }
  }
}

// Painter vẽ lưới HUD
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppTheme.cyanNeon.withOpacity(0.05)
      ..strokeWidth = 0.5;
    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }
    for (var i = 0; i < size.height; i += 20) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
