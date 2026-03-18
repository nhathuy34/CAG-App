import 'dart:ui'; // Bắt buộc phải có thư viện này để làm mờ nền (blur)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SystemSection extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String userAvatar;
  final Function(String, String, String) onUpdateProfile;
  final VoidCallback onLogout; // Hàm đăng xuất

  const SystemSection({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userAvatar,
    required this.onUpdateProfile,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1426),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          _buildSystemRow(
            'EDIT PROFILE DATA',
            actionWidget: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 14,
            ),
            onTap: () {
              // HIỂN THỊ POP-UP VỚI NỀN MỜ
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.6), // Làm nền phía sau tối đi
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // Hiệu ứng làm mờ (Blur)
                  child: UpdateOperatorDialog(
                    initialName: userName,
                    initialPhone: userPhone,
                    initialAvatar: userAvatar,
                    onSave: onUpdateProfile,
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'SECURITY PROTOCOL',
            actionWidget: Text(
              'ENCRYPTED',
              style: GoogleFonts.rajdhani(
                color: const Color(0xFF00FF66),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'LINKED ACCOUNT',
            actionWidget: Text(
              'GOOGLE, FACEBOOK',
              style: GoogleFonts.rajdhani(color: Colors.white38, fontSize: 12),
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildSystemRow(
            'TERMINATE SESSION',
            textColor: const Color(0xFFFF4D4D),
            actionWidget: const Icon(
              Icons.logout,
              color: Color(0xFFFF4D4D),
              size: 18,
            ),
            onTap: onLogout, // Xử lý đăng xuất
          ),
        ],
      ),
    );
  }

  Widget _buildSystemRow(
    String title, {
    Widget? actionWidget,
    Color textColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.rajdhani(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            if (actionWidget != null) actionWidget,
          ],
        ),
      ),
    );
  }
}

class UpdateOperatorDialog extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialAvatar;
  final Function(String, String, String) onSave;

  const UpdateOperatorDialog({
    super.key,
    required this.initialName,
    required this.initialPhone,
    required this.initialAvatar,
    required this.onSave,
  });

  @override
  State<UpdateOperatorDialog> createState() => _UpdateOperatorDialogState();
}

class _UpdateOperatorDialogState extends State<UpdateOperatorDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late String _currentAvatar;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _currentAvatar = widget.initialAvatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleChangeAvatar() {
    setState(() {
      _currentAvatar =
          'https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        // THÊM VIỀN XANH VÀ NỀN TỐI CHO POP-UP
        decoration: BoxDecoration(
          color: const Color(0xFF0A101D), // Màu nền tối thẫm giống ảnh
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF005A88), // Viền xanh xám theo ảnh gốc
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF005A88).withOpacity(0.4), // Hiệu ứng phát sáng nhẹ
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        color: const Color(0xFF00C4FF), // Ô vuông cyan góc trái
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'UPDATE OPERATOR DATA',
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Avatar
            Center(
              child: GestureDetector(
                onTap: _handleChangeAvatar,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24, width: 1), // Viền mỏng quanh avatar
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      _currentAvatar,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 72,
                        height: 72,
                        color: Colors.white12,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white38,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Input Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildEditableInputField('CODENAME', _nameController),
                  const SizedBox(height: 16),
                  _buildEditableInputField(
                    'COMMS (PHONE)',
                    _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Save Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: GestureDetector(
                onTap: () {
                  widget.onSave(
                    _nameController.text,
                    _phoneController.text,
                    _currentAvatar,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF009EB8), // Nút màu Cyan
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      'SAVE CHANGES',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableInputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF050914), // Nút input tối đen
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white12), // Viền mờ cho input
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.ibmPlexMono( // Dùng font mono để giống code/tech
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            cursorColor: const Color(0xFF00C4FF),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}