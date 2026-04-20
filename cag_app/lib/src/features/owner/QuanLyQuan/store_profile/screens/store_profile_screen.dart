import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/providers/owner_home_providers.dart';
import '../providers/store_profile_providers.dart';
import '../../../../../constants/app_theme.dart';
import '../../../../../common_widgets/cag_text_field.dart';
import '../../../../../common_widgets/cag_primary_button.dart';

class StoreProfileScreen extends ConsumerStatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  ConsumerState<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends ConsumerState<StoreProfileScreen> {
  String _activeFloor = 'ground';

  @override
  Widget build(BuildContext context) {
    // final selectedBranch = ref.watch(selectedBranchProvider); // Not used currently
    final profileAsync = ref.watch(storeProfileProvider);

    return Container(
      color: Colors.black,
      child: profileAsync.when(
        data: (profile) => _buildProfileContent(profile),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _buildNoBranchSelectedContent(),
      ),
    );
  }

  Widget _buildNoBranchSelectedContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.storefront, color: Colors.grey, size: 40),
            ),
            const SizedBox(height: 20),
            const Text('VUI LÒNG CHỌN MỘT CHI NHÁNH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 8),
            const Text(
              'Bạn đang xem tổng quan toàn bộ hệ thống. Để chỉnh sửa hồ sơ, cấu hình máy, hoặc sơ đồ mặt bằng, vui lòng chọn một chi nhánh cụ thể.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(dynamic profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(profile),
          const SizedBox(height: 20),
          _buildStatusAlert(profile),
          const SizedBox(height: 24),
          _buildBasicInfo(profile),
          const SizedBox(height: 24),
          _buildZoneConfig(profile),
          const SizedBox(height: 24),
          _buildAmenitiesAndMenu(profile),
          const SizedBox(height: 24),
          _buildFloorPlan(profile),
          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildHeader(dynamic profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('HỒ SƠ PHÒNG MÁY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2)),
            Text('Cập nhật thông tin chi tiết.', style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
        Row(
          children: [
             CagPrimaryButton(
               text: 'ĐẨY LÊN APP',
               onPressed: () {},
               height: 36,
               fontSize: 9,
               borderRadius: 10,
               backgroundColor: const Color(0xFF10B981), // Emerald 500
               prefixIcon: Icons.rocket_launch,
             ),
          ],
        )
      ],
    );
  }

  Widget _buildStatusAlert(dynamic profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF00E676).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00E676).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF00E676)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(profile.statusText, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(dynamic profile) {
    return _buildCard(
      title: 'Thông Tin Cơ Bản',
      accentColor: const Color(0xFF2979FF),
      child: Column(
        children: [
          CagTextField(hint: 'Tên Quán', controller: TextEditingController(text: profile.name)),
          const SizedBox(height: 16),
          CagTextField(hint: 'Địa Chỉ', controller: TextEditingController(text: profile.address)),
          const SizedBox(height: 16),
          CagTextField(hint: 'Mô tả ngắn', maxLines: 3, controller: TextEditingController(text: profile.description)),
        ],
      ),
    );
  }

  Widget _buildZoneConfig(dynamic profile) {
    return _buildCard(
      title: 'Cấu Hình & Giá',
      accentColor: const Color(0xFF00E676),
      trailing: TextButton(onPressed: (){}, child: const Text('+ Thêm Zone', style: TextStyle(color: Color(0xFF00E676), fontSize: 11))),
      child: Column(
        children: (profile.zones as List).map<Widget>((zone) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(zone.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildMiniBadge('VGA', zone.vga, Colors.cyan),
                          const SizedBox(width: 8),
                          _buildMiniBadge('CPU', zone.cpu, Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${zone.price}₫', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                    Text('${zone.member}₫', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 11)),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAmenitiesAndMenu(dynamic profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildCard(
            title: 'Tiện Ích',
            accentColor: Colors.amber,
            child: Column(
              children: (profile.amenities as List).map<Widget>((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                       Text(item.icon, style: const TextStyle(fontSize: 16)),
                       const SizedBox(width: 12),
                       Text(item.label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                       const Spacer(),
                       SizedBox(
                         height: 24,
                         width: 24,
                         child: Checkbox(value: item.checked, onChanged: (v){}, activeColor: const Color(0xFF2979FF))
                       ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCard(
            title: 'Menu',
            accentColor: Colors.pink,
            child: Column(
              children: (profile.featuredMenu as List).map<Widget>((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(item.name, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                       Text('${item.price}₫', style: const TextStyle(color: Color(0xFF00E676), fontSize: 10, fontWeight: FontWeight.w900)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloorPlan(dynamic profile) {
     return _buildCard(
       title: 'Sơ Đồ Mặt Bằng',
       accentColor: Colors.pink,
       child: Column(
         children: [
            Row(
              children: [
                _buildFloorTab('ground', 'Tầng Trệt'),
                const SizedBox(width: 8),
                _buildFloorTab('upper', 'Tầng Lầu'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: const Center(child: Text('Interactive Floor Plan View', style: TextStyle(color: Colors.grey, fontSize: 12))),
            )
         ],
       ),
     );
  }

  Widget _buildFloorTab(String key, String label) {
    final isSelected = _activeFloor == key;
    return GestureDetector(
      onTap: () => setState(() => _activeFloor = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: isSelected ? const Color(0xFF2979FF) : Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildMiniBadge(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 8)),
          Text(val, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Color accentColor, required Widget child, Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
                 children: [
                   Container(width: 4, height: 16, decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(2))),
                   const SizedBox(width: 8),
                   Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                 ],
               ),
               if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
