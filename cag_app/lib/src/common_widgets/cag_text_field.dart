import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class CagTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final double borderRadius;
  final Color activeColor;      // Màu border khi nhấn vào
  final IconData? prefixIcon;   // Icon đầu ô
  final Widget? suffixIcon;     // Icon cuối ô
  final int? maxLength;

  const CagTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.activeColor,
    this.isPassword = false,
    this.borderRadius = 10.0,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
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
        Text(widget.label, style: const TextStyle(color: AppTheme.textDim, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        TextField(
          focusNode: _focusNode,
          obscureText: widget.isPassword,
          maxLength: widget.maxLength,
          style: const TextStyle(color: AppTheme.textWhite),
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: "",
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: _isFocused ? widget.activeColor : Colors.white24, size: 20) : null,
            suffixIcon: widget.suffixIcon,

            // Cấu hình Border dựa trên tham số truyền vào
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppTheme.borderWhite),
            ),

            // Border khi TextField được focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.activeColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}