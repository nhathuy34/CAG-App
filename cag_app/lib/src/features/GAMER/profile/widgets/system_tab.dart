import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/profile/providers/profile_provider.dart';
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart';
import 'package:CAG_App/src/features/authentication/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'dart:ui';
import 'package:CAG_App/src/repositories/auth_repository.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
                        if (userData == null || userData.id == 0) {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthScreen(isLogin: true)),
                          );
                          return; // Dừng lại éo cho chạy tiếp code mở Dialog bên dưới
                        }
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: '',
                          barrierColor: Colors.black54, // Màu tối phủ lên
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, anim1, anim2) => UpdateOperatorDialog(
                            initialName: userData.username ,
                            initialPhone: userData.phoneNumber ,
                            initialAvatar: (userData.avatarUrl != null && userData.avatarUrl!.isNotEmpty)
                              ? userData.avatarUrl!
                              : 'https://picsum.photos/200',
                            onSave: (name, phone, localPath) async { // Thêm async ở đây
                              await ref.read(userProfileProvider.notifier).updateProfile(
                                name: name,
                                phone: phone,
                                localAvatarPath: localPath, // ĐÃ SỬA CHỖ NÀY
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
                    onTap: () async {
                      // 1. Chờ kết quả từ popup xác nhận (trả về true/false)
                      final confirm = await showGeneralDialog<bool>(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black87,
                        transitionDuration: const Duration(milliseconds: 250),
                        pageBuilder: (context, anim1, anim2) => LogoutConfirmDialog(
                          onConfirm: () {
                            // Chỉ cần pop và ném ra giá trị true
                            Navigator.pop(context, true); 
                          },
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 8 * anim1.value, 
                              sigmaY: 8 * anim1.value
                            ),
                            child: FadeTransition(
                              opacity: anim1,
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.9, end: 1.0).animate(anim1),
                                child: child,
                              ),
                            ),
                          );
                        },
                      );

                      if (confirm != true) return;

                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(color: AppTheme.statsRed),
                        ),
                      );

                      try {
                        final authRepo = AuthRepository();
                        await authRepo.logout(); 
                      } catch (e) {
                        debugPrint("Lỗi đăng xuất: $e");
                      }

                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
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
  bool _isPickingImage = false;
  
  // Khởi tạo bộ chọn ảnh
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _currentAvatar = widget.initialAvatar;
  }

  // Hàm mở thư viện ảnh thật trên máy
  Future<void> _changeAvatar() async {
    if (_isPickingImage) return;
    setState(() {
      _isPickingImage = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Nén chất lượng ảnh xuống 50% để tránh file quá nặng
        maxWidth: 800,    // Giới hạn chiều ngang
        maxHeight: 800,   // Giới hạn chiều dọc
      );
      
      if (image != null) {
        setState(() {
          _currentAvatar = image.path; 
        });
      }
    } catch (e) {
      debugPrint("Lỗi khi chọn ảnh: $e");
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
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
              
              Center(
                child: GestureDetector(
                  onTap: _changeAvatar, // Nhấn để mở thư viện
                  child: Container(
                    width: 90, height: 90,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffc0c0c0), width: 2.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      // QUAN TRỌNG: Xử lý hiển thị ảnh mạng vs ảnh máy
                      child: _currentAvatar.startsWith('http')
                          ? Image.network(
                              _currentAvatar,
                              fit: BoxFit.cover,
                              key: ValueKey(_currentAvatar),
                              errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.person, color: Colors.white54)),
                            )
                          : Image.file(
                              File(_currentAvatar), // Load ảnh từ ổ cứng
                              fit: BoxFit.cover,
                              key: ValueKey(_currentAvatar),
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
                  // Gửi cục data (bao gồm đường dẫn thật) về cho Notifier
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

class LogoutConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutConfirmDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 380),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: AppTheme.cardBg.withOpacity(0.95), // Nền card tối
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.statsRed.withOpacity(0.8), width: 1.5), // Viền đỏ
            boxShadow: [
              BoxShadow(
                color: AppTheme.statsRed.withOpacity(0.25), 
                blurRadius: 25, 
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon cảnh báo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.statsRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded, color: AppTheme.statsRed, size: 40),
              ),
              const SizedBox(height: 20),
              
              // Tiêu đề
              Text(
                'SYSTEM WARNING',
                style: GoogleFonts.rajdhani(
                  color: AppTheme.statsRed,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              // Nội dung
              Text(
                'Are you sure you want to disconnect your session? You will need to re-authenticate to access the CAG network.',
                style: GoogleFonts.rajdhani(
                  color: AppTheme.textDim,
                  fontSize: 15,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Hai nút ABORT và CONFIRM
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false), // Tắt dialog
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.textDim.withOpacity(0.5)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'ABORT',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirm(); 
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.statsRed.withOpacity(0.15),
                        side: const BorderSide(color: AppTheme.statsRed, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Text(
                        'CONFIRM',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.statsRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
