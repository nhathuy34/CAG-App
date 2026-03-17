import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  bool _isGamer = true;
  bool _rememberMe = false;

  Widget _buildTextField(String hint, {bool isPassword = false, String? label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: const TextStyle(color: AppColors.cyanPrimary, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 48,
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.textGray.withOpacity(0.5), fontSize: 14),
              filled: true,
              fillColor: AppColors.inputBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                _buildRoleButton('GAMER', _isGamer, () => setState(() => _isGamer = true)),
                _buildRoleButton('CHỦ PHÒNG MÁY', !_isGamer, () => setState(() => _isGamer = false)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField('Nhập tên đăng nhập......', label: 'TÀI KHOẢN(SĐT/USERNAME)'),
          const SizedBox(height: 20),
          _buildTextField('••••••••••••', label: 'MẬT KHẨU', isPassword: true),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildCustomCheckbox(_rememberMe, (v) => setState(() => _rememberMe = v)),
                  const SizedBox(width: 8),
                  const Text('Ghi nhớ đăng nhập', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
                ],
              ),
              const Text('Quên mật khẩu?', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: const Text('ĐĂNG NHẬP NGAY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Nhấn nút back để thoát', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildRoleButton(String title, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: isActive ? AppColors.cyanPrimary : Colors.transparent, borderRadius: BorderRadius.circular(4)),
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(color: isActive ? Colors.black : AppColors.textGray, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox(bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: value ? AppColors.cyanPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: value ? AppColors.cyanPrimary : AppColors.textGray, width: 1.5),
        ),
        child: value ? const Icon(Icons.check, size: 12, color: Colors.black) : null,
      ),
    );
  }
}