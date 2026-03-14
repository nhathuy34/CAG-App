import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AuthScreen extends StatefulWidget {
  final int initialIndex;
  const AuthScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGamer = true;
  bool _rememberMe = false;
  bool _agreeTerms = false;

  String? _selectedCity;
  String? _selectedDistrict;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String hint, {bool isPassword = false, String? label, bool isLabelCyan = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: TextStyle(color: isLabelCyan ? AppColors.cyanPrimary : AppColors.textGray, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 48,
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.textGray, fontSize: 14),
              filled: true,
              fillColor: AppColors.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: AppColors.cardDark,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textWhite, size: 20),
          hint: Text(hint, style: const TextStyle(color: AppColors.textWhite, fontSize: 14), overflow: TextOverflow.ellipsis),
          value: selectedValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: AppColors.textWhite, fontSize: 14), overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
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
          border: Border.all(
            color: value ? AppColors.cyanPrimary : AppColors.textGray,
            width: 1.5,
          ),
        ),
        child: value
            ? const Icon(Icons.check, size: 12, color: Colors.black)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: AppColors.cyanPrimary,
                        labelColor: AppColors.cyanPrimary,
                        unselectedLabelColor: AppColors.textGray,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        tabs: const [
                          Tab(text: 'ĐĂNG NHẬP'),
                          Tab(text: 'ĐĂNG KÝ'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 520,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(() => _isGamer = true),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _isGamer ? AppColors.cyanPrimary : Colors.transparent,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('GAMER', style: TextStyle(color: _isGamer ? Colors.black : AppColors.textGray, fontSize: 12, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(() => _isGamer = false),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: !_isGamer ? AppColors.cyanPrimary : Colors.transparent,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('CHỦ PHÒNG MÁY', style: TextStyle(color: !_isGamer ? Colors.black : AppColors.textGray, fontSize: 12, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                _buildTextField('Nhập tên đăng nhập......', label: 'TÀI KHOẢN(SĐT/USERNAME)', isLabelCyan: true),
                                const SizedBox(height: 20),
                                _buildTextField('••••••••••••', label: 'MẬT KHẨU', isPassword: true, isLabelCyan: true),
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.cyanPrimary,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {},
                                    child: const Text('ĐĂNG NHẬP NGAY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text('Nhấn nút back để thoát', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
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
                                    Expanded(
                                      child: _buildDropdown(
                                          'Thành phố HCM',
                                          ['Thành phố HCM', 'Hà Nội', 'Đà Nẵng'],
                                          _selectedCity,
                                              (val) => setState(() => _selectedCity = val)
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdown(
                                          'Phường Bình Thạnh',
                                          ['Phường Bình Thạnh', 'Quận 1', 'Hải Châu'],
                                          _selectedDistrict,
                                              (val) => setState(() => _selectedDistrict = val)
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildTextField('Địa chỉ chi tiết'),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    _buildCustomCheckbox(_agreeTerms, (v) => setState(() => _agreeTerms = v)),
                                    const SizedBox(width: 8),
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.cyanPrimary,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {},
                                    child: const Text('ĐĂNG KÝ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text('Nhấn nút back để thoát', style: TextStyle(color: AppColors.textGray, fontSize: 10)),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppColors.textGray, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}