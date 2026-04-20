import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/utils/responsive.dart';

class CagTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int? maxLines; // null = auto dãn, 1 = cố định 1 dòng
  final double borderRadius;
  final Color activeColor;
  final Widget? suffixIcon;
  final double verticalPadding;
  final bool showBorder; // Thêm biến này để tùy chỉnh có hiện viền hay không

  const CagTextField({
    super.key,
    this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.borderRadius = 12,
    this.activeColor = AppTheme.primary,
    this.suffixIcon,
    this.verticalPadding = 14,
    this.showBorder = true, // Mặc định là có viền cho Login/Register
  });

  @override
  State<CagTextField> createState() => _CagTextFieldState();
}

class _CagTextFieldState extends State<CagTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Responsive.fontSize(context, 14)),
          ),
          SizedBox(height: Responsive.heightPercent(context, 2)),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            // Màu nền tối slate-900 như bản web
            color: const Color(0xFF020617).withOpacity(0.5), 
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isFocused 
                  ? widget.activeColor 
                  : (widget.showBorder ? AppTheme.borderWhite : Colors.transparent),
              width: 1,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword,
            maxLines: widget.maxLines,
            // Nếu maxLines là null thì dùng keyboard multiline
            keyboardType: widget.maxLines == null ? TextInputType.multiline : widget.keyboardType,
            style: TextStyle(color: Colors.white, fontSize: Responsive.fontSize(context, 14)),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: AppTheme.textDim, fontSize: Responsive.fontSize(context, 14)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16, 
                vertical: widget.verticalPadding * (Responsive.isSmall(context) ? 0.9 : (Responsive.isLarge(context) ? 1.06 : 1.0)),
              ),
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none, // Tắt border mặc định của TextField vì đã có Container bọc
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
