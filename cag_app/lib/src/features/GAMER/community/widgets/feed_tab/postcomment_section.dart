import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/common_widgets/cag_text_field.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart'; // Thêm import này
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart'; // Thêm import này

class PostCommentSection extends ConsumerWidget {
  final bool isOpen;

  const PostCommentSection({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isOpen) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF020617),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                'Chưa có bình luận nào. Hãy là người đầu tiên!',
                style: TextStyle(
                  color: AppTheme.textDim,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Ô nhập bình luận
          Row(
            children: [
              const Expanded(
                child: CagTextField(
                  hint: 'Viết bình luận của bạn...',
                  borderRadius: 30,
                  verticalPadding: 8,
                  showBorder: true,
                  activeColor: Colors.cyan,
                ),
              ),
              const SizedBox(width: 8),
              // Nút gửi (Cyan Button)
              GestureDetector(
                onTap: () {
                  // KIỂM TRA ĐĂNG NHẬP
                  final authState = ref.read(authStateProvider);
                  if (authState == null) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        barrierColor: Colors.black26,
                        pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
                        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
                      ),
                    );
                    return;
                  }

                  // NẾU ĐÃ ĐĂNG NHẬP
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tính năng bình luận đang phát triển')),
                  );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
