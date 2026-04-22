import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showChromeAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (ctx) => AlertDialog(
        alignment: Alignment.topCenter,
        insetPadding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        backgroundColor: const Color(0xFF202124),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titlePadding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 16),
        contentPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
        title: Text("${Uri.base.authority} says",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 14)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "QUẢN LÝ THÔNG BÁO",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 1),
              ),
              SizedBox(height: 12),
              Text(
                "Gửi thông báo toàn hệ thống và cấu hình tự động.",
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabItem(0, "Gửi Thông Báo Mới"),
                  const SizedBox(width: 16),
                  _buildTabItem(1, "Lịch Sử Gửi"),
                  const SizedBox(width: 16),
                  _buildTabItem(2, "Cấu Hình Sinh Nhật"),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                SendNotificationTab(onAlert: (msg) => _showChromeAlert(context, msg)),
                const HistoryTab(),
                BirthdayConfigTab(onAlert: (msg) => _showChromeAlert(context, msg)),
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
      onTap: () => setState(() => _tabController.animateTo(index)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(bottom: BorderSide(color: Colors.tealAccent, width: 2))
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.tealAccent : Colors.white54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TAB 1: GỬI THÔNG BÁO MỚI
// ==========================================
class SendNotificationTab extends StatefulWidget {
  final Function(String) onAlert;
  const SendNotificationTab({super.key, required this.onAlert});

  @override
  State<SendNotificationTab> createState() => _SendNotificationTabState();
}

class _SendNotificationTabState extends State<SendNotificationTab> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedType = 'Thông tin chung';
  String _selectedAudience = 'Tất cả mọi người';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 400,
                child: _buildInputField(
                  label: "Tiêu đề thông báo",
                  child: TextFormField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration("VD: Khuyến mãi x2..."),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: _buildInputField(
                  label: "Loại thông báo",
                  child: DropdownButtonFormField<String>(
                    value: _selectedType,
                    dropdownColor: const Color(0xFF1E2430),
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration(""),
                    items: ['Thông tin chung', 'Khuyến mãi / Ưu đãi', 'Cảnh báo / Bảo trì']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedType = val!),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: "Đối tượng nhận",
            child: DropdownButtonFormField<String>(
              value: _selectedAudience,
              dropdownColor: const Color(0xFF1E2430),
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(""),
              items: ['Tất cả mọi người', 'Chỉ Gamer', 'Chỉ Chủ Phòng Máy (Owner)']
                  .map((aud) => DropdownMenuItem(value: aud, child: Text(aud)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedAudience = val!),
            ),
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: "Nội dung chi tiết",
            child: TextFormField(
              controller: _contentController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Nhập nội dung thông báo..."),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
                  widget.onAlert("Vui lòng nhập đầy đủ tiêu đề và nội dung.");
                } else {
                  widget.onAlert("Đã gửi thông báo thành công!");
                }
              },
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text("Gửi Thông Báo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required Widget child}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      const SizedBox(height: 8),
      child,
    ]);
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24),
      filled: true,
      fillColor: const Color(0xFF0D1117),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white10)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.tealAccent)),
    );
  }
}

// ==========================================
// TAB 2: LỊCH SỬ GỬI
// ==========================================
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildHistoryCard(
          tag: "PROMO",
          title: "KHUYẾN MÃI 50% GIỜ CHƠI!",
          content: "Nhân dịp khai trương phòng máy, giảm 50% giờ chơi cho tất cả hội viên tại CAG Cyber Cầu Giấy.",
          time: "Gửi bởi: Lê Lợi - 14:20 18/04/2026",
          tagColor: Colors.pinkAccent,
        ),
        const SizedBox(height: 16),
        _buildHistoryCard(
          tag: "WARNING",
          title: "BẢO TRÌ HỆ THỐNG",
          content: "Hệ thống nạp tiền sẽ bảo trì từ 2h-4h sáng mai. Mong quý khách thông cảm.",
          time: "Gửi bởi: Hệ thống - 10:00 17/04/2026",
          tagColor: Colors.orangeAccent,
        ),
      ],
    );
  }

  Widget _buildHistoryCard(
      {required String tag, required String title, required String content, required String time, required Color tagColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: tagColor.withOpacity(0.5)),
            ),
            child: Text(tag, style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(content, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Text(time, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Xem chi tiết", style: TextStyle(color: Colors.tealAccent)),
          )
        ],
      ),
    );
  }
}

// ==========================================
// TAB 3: CẤU HÌNH SINH NHẬT
// ==========================================
class BirthdayConfigTab extends StatefulWidget {
  final Function(String) onAlert;
  const BirthdayConfigTab({super.key, required this.onAlert});

  @override
  State<BirthdayConfigTab> createState() => _BirthdayConfigTabState();
}

class _BirthdayConfigTabState extends State<BirthdayConfigTab> {
  bool _isActive = true;
  bool _applyGamer = true; // Biến trạng thái cho Gamer
  bool _applyOwner = true; // Biến trạng thái cho Owner

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("KÍCH HOẠT CHÚC MỪNG SINH NHẬT TỰ ĐỘNG",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(height: 6),
                      Text("Hệ thống tự động gửi thông báo và quà tặng vào ngày sinh nhật của user.",
                          style: TextStyle(color: Colors.white54, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Switch(value: _isActive, activeColor: Colors.tealAccent, onChanged: (v) => setState(() => _isActive = v)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Opacity(
            opacity: _isActive ? 1 : 0.3,
            child: IgnorePointer(
              ignoring: !_isActive,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Mẫu tin nhắn chúc mừng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  TextFormField(
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    initialValue:
                        "Chúc mừng sinh nhật {name}! CAG tặng bạn 50,000 VNĐ vào tài khoản để chiến game thả ga. Chúc bạn một ngày sinh nhật vui vẻ!",
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0D1117),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.tealAccent)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Sử dụng {name} để thay thế bằng tên người dùng.",
                      style: TextStyle(color: Colors.white24, fontSize: 12)),
                  const SizedBox(height: 24),
                  const Text("Đối tượng áp dụng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 30,
                    children: [
                      _buildCheckItem("Gamer", _applyGamer, (val) => setState(() => _applyGamer = val!)),
                      _buildCheckItem("Chủ Phòng Máy (Owner)", _applyOwner, (val) => setState(() => _applyOwner = val!)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => widget.onAlert("Đã lưu cấu hình chúc mừng sinh nhật tự động!"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: const Text("Lưu Cấu Hình", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label, bool value, Function(bool?) onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.teal,
                checkColor: Colors.black,
                side: const BorderSide(color: Colors.white30, width: 1.5), // Viền nút tick chuẩn Web
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Bo góc nút tick
              ),
            ),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}