import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/owner_models.dart';

class OwnerRepository {
  Future<StoreProfileModel> getStoreProfile(String branchId) async {
    // Mocking API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (branchId == 'ALL') {
      throw Exception('Please select a specific branch');
    }

    return StoreProfileModel(
      name: branchId == "1" ? "Cyber All Game Q.Gò Vấp" : (branchId == "2" ? "Cyber All Game Q.10 Premium" : "Cyber All Game Q.7 VIP"),
      address: "123 Quang Trung, Phường 10, Gò Vấp, TP.HCM",
      description: "Cyber Game chuẩn thi đấu 5 sao tại Gò Vấp với cấu hình cực khủng và dịch vụ chuyên nghiệp.",
      status: "APPROVED",
      statusText: "Hồ sơ đã được duyệt",
      zones: [
        const Zone(name: "ZONE A - THI ĐẤU", vga: "RTX 4070 Ti", cpu: "i7 13700K", price: "15.000", member: "12.000"),
        const Zone(name: "ZONE B - STREAM", vga: "RTX 4060", cpu: "i5 13400F", price: "20.000", member: "18.000"),
      ],
      games: ["Liên Minh Huyền Thoại", "Valorant", "CS2", "Black Myth: Wukong"],
      amenities: [
        const Amenity(icon: "☕", label: "Pha chế tại chỗ", checked: true),
        const Amenity(icon: "🍳", label: "Bếp ăn 24/7", checked: true),
        const Amenity(icon: "🅿️", label: "Bãi xe trong nhà", checked: true),
      ],
      featuredMenu: [
        const FeaturedMenuItem(name: "Cơm Gà Xối Mỡ", price: "45.000"),
        const FeaturedMenuItem(name: "Bánh Mì Chảo VIP", price: "55.000"),
        const FeaturedMenuItem(name: "Sting Dâu Lắc Muối", price: "15.000"),
      ],
      floorPlanData: {
        "ground": [
          const FloorPlanZone(
            name: "Zone A: Standard",
            totalCount: 32,
            count: 32,
            price: "10k/h",
            color: "blue",
            grid: 8,
            w: "480px",
            h: "220px",
            left: "40px",
            top: "40px",
          ),
          const FloorPlanZone(
            name: "Zone B: VIP",
            totalCount: 10,
            count: 10,
            price: "15k/h",
            specs: "RTX 3060 | 144Hz",
            color: "yellow",
            grid: 5,
            w: "300px",
            h: "140px",
            right: "40px",
            top: "40px",
          ),
        ],
        "upper": [
          const FloorPlanZone(
            name: "Zone C: Premium",
            totalCount: 20,
            count: 20,
            price: "20k/h",
            specs: "RTX 4070 | 240Hz",
            color: "cyan",
            grid: 5,
            w: "400px",
            h: "250px",
            left: "50px",
            top: "50px",
          ),
        ],
      },
    );
  }

  Future<List<BookingModel>> getBookings(String type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    switch (type) {
      case 'choduyet':
        return [
          const BookingModel(id: 1, name: "Tuấn Đạt", room: "VIP-01", roomType: "VIP", member: "GOLD Member", time: "14:00 - 16:00", note: "Giữ máy lạnh giúp em nhé", avatar: 12),
          const BookingModel(id: 2, name: "Minh Hằng", room: "STD-15", roomType: "STANDARD", member: "SILVER Member", time: "18:00 - 22:00", note: "Em đến trễ 15p", avatar: 7),
        ];
      case 'sapden':
        return [
          const BookingModel(id: 3, name: "Hoàng Nam", room: "STR-02", roomType: "STREAM ROOM", member: "DIAMOND Member", time: "15:30 - 18:30", note: "Chuẩn bị sẵn mic giúp mình", avatar: 21),
          const BookingModel(id: 4, name: "Lê Thảo", room: "VIP-08", roomType: "VIP", member: "BRONZE Member", time: "19:00 - 23:00", note: "", avatar: 22),
        ];
      case 'lichsu':
        return [
          const BookingModel(id: 5, name: "Quốc Bảo", room: "STD-05", roomType: "STANDARD", member: "SILVER Member", time: "10:00 - 12:00", note: "", avatar: 31, status: "completed"),
          const BookingModel(id: 6, name: "Thanh Trúc", room: "VIP-12", roomType: "VIP", member: "GOLD Member", time: "08:00 - 10:00", note: "Bận việc đột xuất", avatar: 32, status: "cancelled"),
        ];
      default:
        return [];
    }
  }
}

final ownerRepositoryProvider = Provider<OwnerRepository>((ref) {
  return OwnerRepository();
});
