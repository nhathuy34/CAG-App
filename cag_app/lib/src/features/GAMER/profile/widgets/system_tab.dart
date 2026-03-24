import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'dart:ui';
import 'dart:math'; // Thêm để dùng Random cho avatar

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
                        final userData = ref.read(userProfileProvider).asData?.value;
                        
                        // SỬA Ở ĐÂY: Dùng showGeneralDialog để làm mờ TOÀN MÀN HÌNH
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: '',
                          barrierColor: Colors.black54, // Màu tối phủ lên
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, anim1, anim2) => UpdateOperatorDialog(
                            initialName: userData?.fullName ?? "Lương Quang Vinh",
                            initialPhone: userData?.phoneNumber ?? "0909888999",
                            initialAvatar: userData?.avatarUrl ?? 'https://picsum.photos/200',
                            onSave: (name, phone, avatar) {
                              ref.read(userProfileProvider.notifier).updateProfile(
                                name: name,
                                phone: phone,
                                avatar: avatar,
                              );
                            },
                          ),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10 * anim1.value, 
                                sigmaY: 10 * anim1.value
                              ),
                              child: FadeTransition(
                                opacity: anim1,
                                child: child,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow('SECURITY PROTOCOL', actionWidget: Text('ENCRYPTED', style: GoogleFonts.rajdhani(color: AppTheme.statsGreen, fontSize: 12, fontWeight: FontWeight.bold))),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow('LINKED ACCOUNT', actionWidget: Text('GOOGLE, FB', style: GoogleFonts.rajdhani(color: AppTheme.textDim, fontSize: 12))),
                    const Divider(height: 1, color: AppTheme.borderWhite),
                    _buildSystemRow(
                      'TERMINATE SESSION',
                      textColor: AppTheme.statsRed,
                      actionWidget: const Icon(Icons.logout, color: AppTheme.statsRed, size: 14),
                      onTap: () {},
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

  Widget _buildSystemRow(String title, {Widget? actionWidget, Color textColor = AppTheme.textWhite, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: AppTheme.cyanNeon.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Expanded(child: Text(title, style: GoogleFonts.rajdhani(color: textColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
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

  const UpdateOperatorDialog({super.key, required this.initialName, required this.initialPhone, required this.initialAvatar, required this.onSave});

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

  // Hàm random avatar mới khi nhấn vào ảnh
  void _changeAvatar() {
    setState(() {
      _currentAvatar = 'https://picsum.photos/200?random=${Random().nextInt(1000)}';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.rajdhani(color: AppTheme.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: AppTheme.textWhite, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.borderWhite)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.cyanNeon, width: 1.5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Để showGeneralDialog hoạt động tốt, nội dung nên bọc trong Center/Align
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.cardBg.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.cyanNeon.withOpacity(0.6), width: 1.5),
            boxShadow: [BoxShadow(color: AppTheme.cyanNeon.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UPDATE OPERATOR DATA', style: GoogleFonts.rajdhani(color: AppTheme.textWhite, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 24),
              
              // AVATAR AREA: Click vào là đổi ảnh ngẫu nhiên
              Center(
                child: GestureDetector(
                  onTap: _changeAvatar, // Nhấn là đổi!
                  child: Container(
                    width: 90, height: 90,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffc0c0c0), width: 2.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        _currentAvatar,
                        fit: BoxFit.cover,
                        key: ValueKey(_currentAvatar), // Quan trọng để Flutter biết ảnh đã đổi
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildInputField('CODENAME', _nameController),
              const SizedBox(height: 16),
              _buildInputField('COMMS (PHONE)', _phoneController),
              const SizedBox(height: 32),
              CagPrimaryButton(
                text: "SAVE CHANGES",
                onPressed: () {
                  widget.onSave(_nameController.text, _phoneController.text, _currentAvatar);
                  Navigator.pop(context);
                },
                backgroundColor: AppTheme.primary,
                textColor: AppTheme.textBlack,
                height: 50,
                borderRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}