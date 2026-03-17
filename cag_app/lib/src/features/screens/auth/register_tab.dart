import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({Key? key}) : super(key: key);

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  bool _agreeTerms = false;
  String? _selectedCity;
  String? _selectedDistrict;

  Widget _buildTextField(String hint, {bool isPassword = false, String? label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: const TextStyle(color: AppColors.textGray, fontSize: 10, fontWeight: FontWeight.bold)),
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
          const Text('TẠO TÀI KHOẢN', style: TextStyle(color: AppColors.cyanPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildTextField('', label: 'HỌ TÊN *')),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('', label: 'SỐ ĐIỆN THOẠI *')),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('nguyenvana@gmail.com', label: 'GMAIL (NHẬN OTP) *'),
          const SizedBox(height: 16),
          _buildTextField('nguyena', label: 'TÀI KHOẢN(USERNAME) *'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('••••••', label: 'MẬT KHẨU *', isPassword: true)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('••••••', label: 'NHẬP LẠI MẬT KHẨU *', isPassword: true)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDropdown('Thành phố HCM', ['Thành phố HCM', 'Hà Nội'], _selectedCity, (v) => setState(() => _selectedCity = v))),
              const SizedBox(width: 16),
              Expanded(child: _buildDropdown('Phường Bình Thạnh', ['Phường Bình Thạnh', 'Quận 1'], _selectedDistrict, (v) => setState(() => _selectedDistrict = v))),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Địa chỉ chi tiết'),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildCustomCheckbox(_agreeTerms, (v) => setState(() => _agreeTerms = v)),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: AppColors.textGray, fontSize: 10),
                    children: [
                      TextSpan(text: 'Tôi đã đọc và đồng ý tất cả các '),
                      TextSpan(text: 'Điều Khoản Sử Dụng', style: TextStyle(color: AppColors.yellowPrimary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: const Text('ĐĂNG KÝ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Nhấn nút back để thoát', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? val, Function(String?) onChanged) {
    return Container(
      height: 48, padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(4)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true, dropdownColor: AppColors.cardDark,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textWhite, size: 20),
          hint: Text(hint, style: const TextStyle(color: AppColors.textWhite, fontSize: 14)),
          value: val, items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: AppColors.textWhite, fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox(bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 16, height: 16,
        decoration: BoxDecoration(color: value ? AppColors.cyanPrimary : Colors.transparent, borderRadius: BorderRadius.circular(4), border: Border.all(color: value ? AppColors.cyanPrimary : AppColors.textGray, width: 1.5)),
        child: value ? const Icon(Icons.check, size: 12, color: Colors.black) : null,
      ),
    );
  }
}