import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/features/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final Color activeColor;
  final bool isGamer;
  const RegisterForm({
    super.key,
    required this.activeColor,
    required this.isGamer,
  });

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  bool isAgree = false;
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
          Text(
            "TẠO TÀI KHOẢN",
            style: TextStyle(
              color: AppTheme.cyanNeon,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          _buildRoleToggle(widget.activeColor),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: CagTextField(
                  label: "HỌ TÊN *",
                  hint: "Nguyễn Văn A",
                  activeColor: AppTheme.cyanNeon,
                  borderRadius: 8,
                  verticalPadding: 10,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CagTextField(
                  label: "SỐ ĐIỆN THOẠI *",
                  hint: "0123456789",
                  activeColor: AppTheme.cyanNeon,
                  borderRadius: 8,
                  verticalPadding: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          CagTextField(
            label: "GMAIL (NHẬN OTP) *",
            hint: "nguyena@gmail.com",
            activeColor: AppTheme.cyanNeon,
            borderRadius: 8,
            verticalPadding: 10,
          ),
          const SizedBox(height: 15),

          CagTextField(
            label: "TÀI KHOẢN (USERNAME) *",
            hint: "nguyena",
            activeColor: AppTheme.cyanNeon,
            borderRadius: 8,
            verticalPadding: 10,
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: CagTextField(
                  label: "MẬT KHẨU *",
                  hint: "••••••••",
                  activeColor: AppTheme.cyanNeon,
                  isPassword: true,
                  borderRadius: 8,
                  verticalPadding: 10,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CagTextField(
                  label: "XÁC NHẬN MK *",
                  hint: "••••••••",
                  activeColor: AppTheme.cyanNeon,
                  isPassword: true,
                  borderRadius: 8,
                  verticalPadding: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLocationField(ref, true),
              const SizedBox(width: 10),
              _buildLocationField(ref, false),
            ],
          ),
          const SizedBox(height: 8),

          CagTextField(
            label: null,
            hint: "Địa chỉ chi tiết",
            activeColor: AppTheme.cyanNeon,
            borderRadius: 8,
            verticalPadding: 10,
          ),

          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => setState(() => isAgree = !isAgree),
                child: Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: isAgree ? widget.activeColor : Colors.transparent,
                    border: Border.all(
                      color: isAgree ? widget.activeColor : Colors.white24,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isAgree
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: AppTheme.textBlack,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                    children: [
                      const TextSpan(text: "Tôi đã đọc và đồng ý tất cả các "),
                      TextSpan(
                        text: "Điều Khoản Sử Dụng",
                        style: TextStyle(
                          color: AppTheme.gold,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          CagPrimaryButton(
            text: "ĐĂNG KÝ",
            backgroundColor: widget.activeColor,
            height: 45,
            borderRadius: 12,
            onPressed: () {
              // Xử lý register
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildRoleToggle để chọn giữa GAMER và CHỦ PHÒNG
  Widget _buildRoleToggle(Color activeColor) {
    return Row(
      children: [
        Expanded(
          child: _roleOption(
            "TÔI LÀ GAME THỦ",
            widget.isGamer,
            AppTheme.cyanNeon,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: _roleOption("TÔI LÀ CHỦ QUÁN", !widget.isGamer, AppTheme.gold),
        ),
      ],
    );
  }

  // Widget _roleOption để tạo từng lựa chọn vai trò
  Widget _roleOption(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () {
        ref.read(isGamerProvider.notifier).state = (title == "TÔI LÀ GAME THỦ");
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? widget.activeColor : Colors.white10,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? widget.activeColor.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? widget.activeColor : Colors.white24,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // Hàm tạo ô chọn địa chỉ ngắn gọn
  String? _activeFieldId;
  Widget _buildLocationField(WidgetRef ref, bool isProvince) {
    final fieldId = isProvince ? 'province' : 'district';
    final value = ref.watch(
      isProvince ? selectedProvinceProvider : selectedDistrictProvider,
    );
    final items = ref.watch(
      isProvince ? provinceListProvider : districtListProvider,
    );

    return Expanded(
      child: InkWell(
        onTap: () async {
          setState(() => _activeFieldId = fieldId);
          await _showPicker(ref, isProvince, items, value);
          setState(() => _activeFieldId = null);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _activeFieldId == fieldId
                  ? AppTheme.cyanNeon
                  : AppTheme.borderWhite,
              width: _activeFieldId == fieldId ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white24,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm hiện Dialog chọn chuẩn 100% hình mẫu
  Future<void> _showPicker(
    WidgetRef ref,
    bool isProvince,
    List<String> items,
    String current,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items
              .map(
                (item) => RadioListTile<String>(
                  title: Text(
                    item,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  value: item,
                  groupValue: current,
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: const Color.fromARGB(255, 24, 171, 44),
                  onChanged: (val) {
                    ref
                            .read(
                              isProvince
                                  ? selectedProvinceProvider.notifier
                                  : selectedDistrictProvider.notifier,
                            )
                            .state =
                        val!;
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
