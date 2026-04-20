import 'dart:async';
import '../models/gamer_models.dart';

class CommunityRepository {
  Stream<List<PostModel>> getFeedStream() {
    return Stream.value([
      PostModel(
        id: 'featured_01',
        author: Usermodel(
          id: 999, // Thêm ID vào đây
          fullName: 'CAG Guide',
          username: 'cag_guide',
          avatarUrl: 'https://picsum.photos/50/50?random=999',
          userType: 2,
          email: '',
          password: '',
          province: '',
          commune: '',
          district: '',
          phoneNumber: '',
        ),
        timestamp: 'Ghim',
        content: 'CAG Guide - Pro Gaming Ecosystem: Nền tảng kết nối Gamer và Cyber Game hàng đầu Việt Nam. Tìm quán ngon, đặt máy xịn, nhận quà khủng!',
        hashtags: ['CAGGuide', 'ProGaming', 'Ecosystem'],
        likes: 999,
        commentsCount: 0,
        location: 'Việt Nam',
        isPinned: true,
        isFeatured: true,
        badges: ['CAG Creator', 'VIP'],
      ),
      PostModel(
        id: 'post_4',
        author: Usermodel(
          id: 111, // Thêm ID vào đây
          userType: 1,
          fullName: 'Faker VN',
          phoneNumber: '0000000000',
          email: 'faker@example.com',
          username: 'faker_vn',
          password: 'secret',
          province: 'HCMC',
          commune: 'Ward',
          district: 'District 10',
          avatarUrl: 'https://picsum.photos/50/50?random=111',
          isVip: true,
          badge: 'CAG Creator',
        ),
        timestamp: '2 giờ trước',
        content: 'Mới test khu thi đấu ở Doragon Cyber Q.10. Màn Zowie 360Hz bắn CS2 dính đầu ầm ầm. Phím Wooting gõ sướng tay. 10 điểm không có nhưng! 🔥',
        hashtags: ['#ReviewQuan', '#CS2', '#Esport'],
        likes: 452,
        commentsCount: 38,
        imageUrl: 'https://picsum.photos/500/300?random=112',
        location: 'Doragon Cyber Q.10',
        isPinned: false,
        isFeatured: true,
        badges: ['CAG Creator', 'VIP'],
      ),
      PostModel(
        id: 'post_3',
        author: Usermodel(
          id: 103, // Thêm ID vào đây
          userType: 1,
          fullName: 'Gaming House Pro',
          phoneNumber: '0000000001',
          email: 'ghpro@example.com',
          username: 'gaming_house_pro',
          password: 'secret',
          province: 'HCMC',
          commune: 'Ward',
          district: 'Gò Vấp',
          avatarUrl: 'https://picsum.photos/50/50?random=103',
          isVip: false,
          badge: 'CAG Creator',
        ),
        timestamp: '3 giờ trước',
        content: '🔥 KHUYẾN MÃI GIỜ VÀNG 🔥 X2 tài khoản nạp từ 13h-16h hôm nay. Đến chơi ngay!',
        hashtags: ['#KhuyenMai', '#HotDeal'],
        likes: 156,
        commentsCount: 42,
        imageUrl: null,
        location: 'Gaming House Pro Gò Vấp',
        isPinned: false,
        isFeatured: false,
        badges: ['CAG Creator'],
      ),
    ]);
  }
  
  Future<List<QuestModel>> fetchQuests() async {
    return [
      QuestModel(
        id: 'q1',
        title: 'REVIEW TRẢI NGHIỆM PHÒNG VIP MỚI (RTX 4060)',
        shopName: 'StarGaming Q10',
        reward: '50.000đ + 1 String',
        deadline: 'Còn 2 ngày',
        imageUrl: 'https://picsum.photos/200',
        isHot: true,
      ),
      QuestModel(
        id: 'q2',
        title: 'CHECK-IN NHẬN CODE GIỜ CHƠI MIỄN PHÍ',
        shopName: 'Cyber All Game Q7',
        reward: '2 giờ chơi Free',
        deadline: 'Hết hạn hôm nay',
        imageUrl: 'https://picsum.photos/201',
      ),
    ];
  }
}
