import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'auth/login_tab.dart';
import 'auth/register_tab.dart';

class AuthScreen extends StatefulWidget {
  final int initialIndex;
  const AuthScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialIndex);
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
                        tabs: const [Tab(text: 'ĐĂNG NHẬP'), Tab(text: 'ĐĂNG KÝ')],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 520,
                      child: TabBarView(
                        controller: _tabController,
                        children: const [LoginTab(), RegisterTab()],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0, right: 0,
                  child: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textGray, size: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}