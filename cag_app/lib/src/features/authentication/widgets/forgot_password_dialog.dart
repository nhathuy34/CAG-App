import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  int _currentMode = 0; 
  bool _isPhoneFound = false;
  bool _isLoading = false;


  final Color _cyan = const Color(0xFF00E5FF);       
  final Color _gold = const Color(0xFFFFCC00);       
  final Color _darkTeal = const Color(0xFF005959);   
  final Color _darkGold = const Color(0xFF997A00);   
  final Color _dialogBg = const Color(0xFF0A0F16);   
  final Color _leftPanelBg = const Color(0xFF111520); 
  
  // Màu cho Banner thông báo thành công
  final Color _successBg = const Color(0xFF0A221C);  
  final Color _successBorder = const Color(0xFF0F5132); 
  final Color _successText = const Color(0xFF2ECA6A);   

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _tempPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _hoverPhoneLink = false;
  bool _hoverRegisterLink = false;
  bool _hoverBackLogin = false;
  bool _hoverBackEmail = false;
  bool _hoverBackToEmailFromReset = false;
  bool _hoverUseEmailBtn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _tempPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kích thước màn hình hiện tại
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 800;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: isSmallScreen ? screenWidth * 0.9 : 850,
          height: 560,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9, 
          ),
          decoration: BoxDecoration(
            color: _dialogBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _cyan.withOpacity(0.2), width: 1.0),
            boxShadow: [
              BoxShadow(color: _cyan.withOpacity(0.05), blurRadius: 40, spreadRadius: 5)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // TỰ ĐỘNG CHUYỂN BỐ CỤC (RESPONSIVE)
            child: isSmallScreen 
                ? _buildRightPanel(isSmallScreen) 
                : Row(
                    children: [
                      Expanded(flex: 4, child: _buildLeftPanel()), 
                      Expanded(flex: 5, child: _buildRightPanel(isSmallScreen)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ================= PANEL TRÁI (CHỨA ẢNH & THÔNG TIN) =================
  Widget _buildLeftPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _leftPanelBg,
        image: const DecorationImage(
          image: NetworkImage('https://img.freepik.com/free-photo/view-illuminated-neon-gaming-keyboard-setup_23-2149529350.jpg'),
          fit: BoxFit.cover,
          opacity: 0.2, 
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight, end: Alignment.centerLeft,
            colors: [_dialogBg.withOpacity(1.0), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dùng FittedBox để lỡ thu hẹp chút thì chữ tự nhỏ lại chứ không bể
            FittedBox(fit: BoxFit.scaleDown, child: Text("CAG GUIDE", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2))),
            FittedBox(fit: BoxFit.scaleDown, child: Text("PRO ECOSYSTEM", style: TextStyle(color: _cyan, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 3))),
            const SizedBox(height: 20),
            Container(height: 2, width: 50, color: Colors.white24),
            const SizedBox(height: 20),
            FittedBox(fit: BoxFit.scaleDown, child: Text("CHỌN QUÁN ĐÚNG GU\nCHIẾN GAME ĐÚNG CHỖ", style: TextStyle(color: _cyan, fontSize: 18, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic))),
            const SizedBox(height: 30),
            
            _buildFeatureItem(Icons.person_outline, "Cộng Đồng Gamer", "Kết bạn, tạo team, leo rank", iconColor: _cyan),
            const SizedBox(height: 15),
            _buildFeatureItem(Icons.emoji_events_outlined, "Hệ Thống Chủ Quán", "Quản lý doanh thu, Marketing 0đ", iconColor: _gold),
          ],
        ),
      ),
    );
  }

  // ================= PANEL PHẢI (CHỨA CÁC FORM) =================
  Widget _buildRightPanel(bool isSmallScreen) {
    return Stack(
      children: [
        // Nút đóng
        Positioned(
          top: 15, right: 15,
          child: IconButton(
            icon: Icon(Icons.close, color: _isLoading ? Colors.white24 : Colors.white54),
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          ),
        ),
        
        Padding(
          // Padding thụt vào tùy thuộc màn hình nhỏ hay to
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 25 : 50), 
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 50, bottom: 20), // Đẩy form xuống một chút tránh đè nút X
              child: _buildCurrentForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentForm() {
    switch (_currentMode) {
      case 1: return _buildPhoneModeForm();
      case 2: return _buildResetPasswordForm();
      case 0:
      default: return _buildEmailModeForm();
    }
  }

  // ----------------------------------------------------------------------
  // GIAO DIỆN 0: KHÔI PHỤC BẰNG EMAIL
  // ----------------------------------------------------------------------
  Widget _buildEmailModeForm() {
    return Form(
      key: _emailFormKey,
      child: Column(
        key: const ValueKey('EmailMode'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("KHÔI PHỤC MẬT KHẨU", style: TextStyle(color: _cyan, fontSize: 18, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
          const SizedBox(height: 15),
          const Text(
            "CAG GUIDE sẽ hỗ trợ bạn lấy lại quyền truy cập tài khoản một\ncách an toàn nhất.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 30),

          CagTextField(
            controller: _emailController,
            label: "EMAIL ĐĂNG KÝ",
            hint: "nguyenvana@gmail.com",
            activeColor: _cyan,
            borderRadius: 8,
            verticalPadding: 15,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Vui lòng nhập Email';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Email không đúng định dạng';
              return null;
            },
          ),
          const SizedBox(height: 20),

          MouseRegion(
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () async {
                if (_emailFormKey.currentState!.validate()) {
                  setState(() => _isLoading = true); 
                  await Future.delayed(const Duration(milliseconds: 500));
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                      _currentMode = 2; 
                    });
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity, height: 50,
                decoration: BoxDecoration(
                  color: _isLoading ? _darkTeal : _cyan, 
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isLoading ? [] : [BoxShadow(color: _cyan.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Center(
                  child: Text(
                    _isLoading ? "ĐANG GỬI..." : "GỬI MẬT KHẨU TẠM THỜI", 
                    style: TextStyle(
                      color: _isLoading ? Colors.white : Colors.black, 
                      fontWeight: FontWeight.w900, 
                      fontSize: 14,
                      letterSpacing: _isLoading ? 1.0 : 0
                    )
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          MouseRegion(
            onEnter: (_) => setState(() => _hoverPhoneLink = true),
            onExit: (_) => setState(() => _hoverPhoneLink = false),
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () => setState(() => _currentMode = 1), 
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isLoading ? Colors.white24 : _gold,
                  fontSize: 12, 
                  fontWeight: FontWeight.bold,
                  decoration: _hoverPhoneLink && !_isLoading ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: _gold,
                ),
                child: const Text("Quên Email? Dò tìm bằng Số điện thoại", textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: 15),

          MouseRegion(
            onEnter: (_) => setState(() => _hoverRegisterLink = true),
            onExit: (_) => setState(() => _hoverRegisterLink = false),
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () {
                Navigator.of(context).pop('register');
              },
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isLoading ? Colors.white24 : (_hoverRegisterLink ? Colors.white : Colors.white54), 
                  fontSize: 12,
                  decoration: _hoverRegisterLink && !_isLoading ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
                child: const Text("Quên tất cả? Tạo tài khoản mới hoàn toàn", textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          MouseRegion(
            onEnter: (_) => setState(() => _hoverBackLogin = true),
            onExit: (_) => setState(() => _hoverBackLogin = false),
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () => Navigator.of(context).pop(),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isLoading ? Colors.white24 : (_hoverBackLogin ? Colors.white : Colors.white38), 
                  fontSize: 12,
                  decoration: _hoverBackLogin && !_isLoading ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
                child: const Text("← Quay lại Đăng nhập", textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Nhấn phím ESC để thoát", style: TextStyle(color: Colors.white24, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // GIAO DIỆN 1: DÒ TÌM BẰNG SỐ ĐIỆN THOẠI
  // ----------------------------------------------------------------------
  Widget _buildPhoneModeForm() {
    return Form(
      key: _phoneFormKey,
      child: Column(
        key: const ValueKey('PhoneMode'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isPhoneFound)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _successBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _successBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: _successText, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text("Đã tìm thấy tài khoản liên kết!", style: TextStyle(color: _successText, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

          Text("KHÔI PHỤC MẬT KHẨU", style: TextStyle(color: _cyan, fontSize: 18, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
          const SizedBox(height: 15),
          const Text(
            "CAG GUIDE sẽ hỗ trợ bạn lấy lại quyền truy cập tài khoản một\ncách an toàn nhất.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 20),

          if (!_isPhoneFound)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
              ),
              child: const Text(
                "Nhập số điện thoại bạn đã dùng để đăng ký. Hệ thống sẽ gợi ý địa chỉ Email liên kết để bạn có thể nhớ ra.",
                style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 20),

          CagTextField(
            controller: _phoneController,
            label: "SỐ ĐIỆN THOẠI",
            hint: "0912345678",
            activeColor: _gold,
            borderRadius: 8,
            verticalPadding: 15,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Bắt buộc nhập';
              if (!RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$').hasMatch(value)) return 'SĐT không hợp lệ';
              return null;
            },
          ),
          const SizedBox(height: 20),

          if (!_isPhoneFound)
            MouseRegion(
              cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _isLoading ? null : () async {
                  if (_phoneFormKey.currentState!.validate()) {
                    setState(() => _isLoading = true);
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        _isPhoneFound = true;
                      });
                    }
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                    color: _isLoading ? _darkGold : _gold, 
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: _isLoading ? [] : [BoxShadow(color: _gold.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Center(
                    child: Text(
                      _isLoading ? "ĐANG TÌM KIẾM..." : "DÒ TÌM TÀI KHOẢN", 
                      style: TextStyle(
                        color: _isLoading ? Colors.white : Colors.black, 
                        fontWeight: FontWeight.w900, 
                        fontSize: 14,
                        letterSpacing: _isLoading ? 1.0 : 0
                      )
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _cyan.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _cyan.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Text("Email liên kết với SĐT này là:", style: TextStyle(color: Colors.white70, fontSize: 12), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "us**${_phoneController.text.length >= 3 ? _phoneController.text.substring(0,3) : "091"}***@gmail.com",
                      style: TextStyle(color: _gold, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  MouseRegion(
                    onEnter: (_) => setState(() => _hoverUseEmailBtn = true),
                    onExit: (_) => setState(() => _hoverUseEmailBtn = false),
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentMode = 0; 
                          _isPhoneFound = false; 
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity, height: 45,
                        decoration: BoxDecoration(
                          color: _hoverUseEmailBtn ? _cyan : _darkTeal,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _hoverUseEmailBtn ? [BoxShadow(color: _cyan.withOpacity(0.3), blurRadius: 10)] : [],
                        ),
                        child: Center(
                          child: Text(
                            "DÙNG EMAIL NÀY ĐỂ KHÔI PHỤC",
                            style: TextStyle(
                              color: _hoverUseEmailBtn ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              )
            ),

          const SizedBox(height: 35),
          
          MouseRegion(
            onEnter: (_) => setState(() => _hoverBackEmail = true),
            onExit: (_) => setState(() => _hoverBackEmail = false),
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () => setState(() {
                _currentMode = 0;
                _isPhoneFound = false;
              }), 
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isLoading ? Colors.white24 : (_hoverBackEmail ? Colors.white : Colors.white38), 
                  fontSize: 12,
                  decoration: _hoverBackEmail && !_isLoading ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
                child: const Text("← Quay lại Khôi phục bằng Email", textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Nhấn phím ESC để thoát", style: TextStyle(color: Colors.white24, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // GIAO DIỆN 2: XÁC NHẬN & ĐỔI MẬT KHẨU MỚI
  // ----------------------------------------------------------------------
  Widget _buildResetPasswordForm() {
    return Form(
      key: _resetFormKey,
      child: Column(
        key: const ValueKey('ResetMode'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _successBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _successBorder),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: _successText, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Mật khẩu tạm thời đã được gửi đến ${_emailController.text}",
                    style: TextStyle(color: _successText, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text("KHÔI PHỤC MẬT KHẨU", style: TextStyle(color: _cyan, fontSize: 18, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          const Text(
            "CAG GUIDE sẽ hỗ trợ bạn lấy lại quyền truy cập tài khoản một\ncách an toàn nhất.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.5),
          ),
          const SizedBox(height: 20),

          CagTextField(
            controller: _tempPasswordController,
            label: "MẬT KHẨU TẠM THỜI (TỪ EMAIL)",
            hint: "Nhập mật khẩu tạm thời",
            activeColor: _cyan,
            borderRadius: 8,
            verticalPadding: 12,
            validator: (val) => (val == null || val.isEmpty) ? "Bắt buộc nhập" : null,
          ),
          const SizedBox(height: 10),

          CagTextField(
            controller: _newPasswordController,
            label: "MẬT KHẨU MỚI",
            hint: "••••••••",
            isPassword: true,
            activeColor: _cyan,
            borderRadius: 8,
            verticalPadding: 12,
            validator: (val) => (val == null || val.length < 6) ? "Tối thiểu 6 ký tự" : null,
          ),
          const SizedBox(height: 10),

          CagTextField(
            controller: _confirmPasswordController,
            label: "NHẬP LẠI MẬT KHẨU MỚI",
            hint: "••••••••",
            isPassword: true,
            activeColor: _cyan,
            borderRadius: 8,
            verticalPadding: 12,
            validator: (val) => (val != _newPasswordController.text) ? "Mật khẩu không khớp" : null,
          ),
          const SizedBox(height: 20),

          MouseRegion(
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () async {
                if (_resetFormKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  await Future.delayed(const Duration(milliseconds: 500));
                  if (mounted) {
                    setState(() => _isLoading = false);
                    Navigator.of(context).pop(); 
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity, height: 45,
                decoration: BoxDecoration(
                  color: _isLoading ? _darkTeal : _cyan,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isLoading ? [] : [BoxShadow(color: _cyan.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Center(
                  child: Text(
                    _isLoading ? "ĐANG XỬ LÝ..." : "XÁC NHẬN ĐỔI MẬT KHẨU", 
                    style: TextStyle(
                      color: _isLoading ? Colors.white : Colors.black, 
                      fontWeight: FontWeight.w900, 
                      fontSize: 14,
                      letterSpacing: _isLoading ? 1.0 : 0
                    )
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          MouseRegion(
            onEnter: (_) => setState(() => _hoverBackToEmailFromReset = true),
            onExit: (_) => setState(() => _hoverBackToEmailFromReset = false),
            cursor: _isLoading ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _isLoading ? null : () => setState(() => _currentMode = 0), 
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isLoading ? Colors.white24 : (_hoverBackToEmailFromReset ? Colors.white : Colors.white38), 
                  fontSize: 12,
                  decoration: _hoverBackToEmailFromReset && !_isLoading ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
                child: const Text("← Quay lại", textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Nhấn phím ESC để thoát", style: TextStyle(color: Colors.white24, fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle, {required Color iconColor}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 15),
        // Sửa lỗi ở đây: Đưa Column vào trong Expanded để không bị tràn chữ ngang
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        )
      ],
    );
  }
}