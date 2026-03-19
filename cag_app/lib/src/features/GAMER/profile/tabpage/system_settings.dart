import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SystemSection extends StatelessWidget {
  final String userName;
  final String userPhone;
  final String userAvatar;
  final Function(String, String, String) onUpdateProfile;

  const SystemSection({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userAvatar,
    required this.onUpdateProfile,
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
              showDialog(
                context: context,
                builder: (context) => UpdateOperatorDialog(
                  initialName: userName,
                  initialPhone: userPhone,
                  initialAvatar: userAvatar,
                  onSave: onUpdateProfile,
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
  late TextEditingController _companyController;
  late TextEditingController _phoneController;
  late String _currentAvatar;

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _currentAvatar = widget.initialAvatar;
  }

  @override
  void dispose() {
    _companyController.dispose();
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
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1426),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      color: const Color(0xFF00C4FF),
                    ),
                    const SizedBox(width: 8),
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
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: _handleChangeAvatar,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _currentAvatar,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 64,
                          height: 64,
                          color: Colors.white12,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white38,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00C4FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildEditableInputField('COMPANY', _companyController),
            const SizedBox(height: 16),
            _buildEditableInputField(
              'COMM. (PHONE)',
              _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                widget.onSave(
                  _companyController.text,
                  _phoneController.text,
                  _currentAvatar,
                );
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C4FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'SAVE CHANGES',
                    style: GoogleFonts.rajdhani(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
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
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF050A15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
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