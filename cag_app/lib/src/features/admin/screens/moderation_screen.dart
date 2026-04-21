import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/admin/widgets/offices_tab_view.dart';
import 'package:CAG_App/src/features/admin/widgets/posts_tab_view.dart';
import 'package:CAG_App/src/features/admin/widgets/users_tab_view.dart';
import 'package:flutter/material.dart';

class ModerationScreen extends StatefulWidget {
  const ModerationScreen({super.key});

  @override
  State<ModerationScreen> createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2); // Mặc định mở tab User giống hình 1
    // Thêm listener để trigger setState khi người dùng tự chạm vuốt lướt qua lại giữa các tab (nếu swipe)
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {}); // Reset TabBar custom UI
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                color: Colors.redAccent,
              ),
              const SizedBox(width: 10),
              const Text(
                "CAG GUARDIAN (ADMIN)",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),

        // Custom TabBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabItem(0, "Kiểm Duyệt Bài Viết (2)"),
                  const SizedBox(width: 10),
                  _buildTabItem(1, "Duyệt Quán Net (2)"),
                  const SizedBox(width: 10),
                  _buildTabItem(2, "Quản Lý User"),
                ],
              ),
            ),
          ),
        ),

        // Tab Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TabBarView(
              controller: _tabController,
              children: const [
                PostsTabView(),
                OfficesTabView(),
                UsersTabView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = _tabController.index == index;
    return InkWell(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.withOpacity(0.8) : const Color(0xFF1E2430),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
