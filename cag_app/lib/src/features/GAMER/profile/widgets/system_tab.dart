import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SystemTab extends ConsumerWidget {
  const SystemTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return statsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppTheme.cyanNeon),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (stats) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppTheme.cardBlue,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderWhite),
                ),
                child: Column(
                  children: [
                    _buildSystemRow(
                      'EDIT PROFILE DATA',
                      actionWidget: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.textDim,
                        size: 14,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => UpdateOperatorDialog(
                            initialName:
                                "Lương Quang Vinh", // Có thể lấy từ UserProvider riêng nếu có
                            initialPhone: "0987654321",
                            initialAvatar: 'https://picsum.photos/200',
                            onSave: (name, phone, avatar) {
                              // Xử lý lưu dữ liệu vào Storage thông qua Provider
                              // ref.read(userStatsProvider.notifier).updateUserData(name, phone, avatar);
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow(
                      'SECURITY PROTOCOL',
                      actionWidget: Text(
                        'ENCRYPTED',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.statsGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow(
                      'LINKED ACCOUNT',
                      actionWidget: Text(
                        'GOOGLE, FB',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.textDim,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow(
                      'TERMINATE SESSION',
                      textColor: AppTheme.statsRed,
                      onTap: () {
                        // Logic Logout và xóa Storage
                        // ref.read(userStatsProvider.notifier).clearStorage();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSystemRow(
    String title, {
    Widget? actionWidget,
    Color textColor = AppTheme.textWhite,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: AppTheme.cyanNeon.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.rajdhani(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderWhite),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPDATE OPERATOR DATA',
              style: GoogleFonts.rajdhani(
                color: AppTheme.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInputField('FULL NAME', _nameController),
            const SizedBox(height: 16),
            _buildInputField('PHONE NUMBER', _phoneController),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  _nameController.text,
                  _phoneController.text,
                  _currentAvatar,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.cyanNeon,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'SAVE CHANGES',
                style: GoogleFonts.rajdhani(
                  color: AppTheme.textBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(color: AppTheme.textDim, fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: AppTheme.textWhite, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.inputBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
