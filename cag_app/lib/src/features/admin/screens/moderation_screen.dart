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
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.075, top: screenWidth * 0.075, bottom: screenWidth * 0.05),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.01,
                height: screenWidth * 0.05,
                color: Colors.redAccent,
              ),
              SizedBox(width: screenWidth * 0.025),
              Text(
                "CAG GUARDIAN (ADMIN)",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: screenWidth * 0.055,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),

        // Custom TabBar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabItem(screenWidth, 0, "Kiểm Duyệt Bài Viết (2)"),
                  SizedBox(width: screenWidth * 0.025),
                  _buildTabItem(screenWidth, 1, "Duyệt Quán Net (2)"),
                  SizedBox(width: screenWidth * 0.025),
                  _buildTabItem(screenWidth, 2, "Quản Lý User"),
                ],
              ),
            ),
          ),
        ),

        // Tab Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.035),
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

  Widget _buildTabItem(double screenWidth, int index, String title) {
    final isSelected = _tabController.index == index;
    return InkWell(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.withOpacity(0.8) : const Color(0xFF1E2430),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.02),
            topRight: Radius.circular(screenWidth * 0.02),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
