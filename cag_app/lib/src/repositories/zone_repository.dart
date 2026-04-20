import 'package:flutter/material.dart';
import '../models/gamer_models.dart';

class ZoneRepository {
  Future<List<ZoneModel>> fetchZones() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Giả lập mạng
    return [
      ZoneModel(title: "ZONE STANDARD", priceGuest: "12,000đ", priceMember: "10,000đ", cpu: "i5 12400F", vga: "RTX 3060", monitor: "165Hz", gear: "Full Cơ"),
      ZoneModel(title: "ZONE VIP", priceGuest: "18,000đ", priceMember: "15,000đ", cpu: "i7 13700K", vga: "RTX 4070", monitor: "240Hz", gear: "Logitech G"),
      ZoneModel(title: "ZONE STREAM", priceGuest: "25,000đ", priceMember: "20,000đ", cpu: "i9 14900K", vga: "RTX 4090", monitor: "360Hz", gear: "Razer Pro"),
    ];
  }
  
  Future<List<UtilityModel>> fetchUtilities() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      UtilityModel(icon: Icons.local_parking, title: "BÃI XE RỘNG", subtitle: "Có bảo vệ trông, Free giữ xe"),
      UtilityModel(icon: Icons.directions_car, title: "BÃI Ô TÔ", subtitle: "Đậu xe thoải mái, an ninh 24/7"),
      UtilityModel(icon: Icons.bathtub, title: "PHÒNG TẮM", subtitle: "Nước nóng lạnh - Cho dân cày đêm"),
      UtilityModel(icon: Icons.wc, title: "WC RIÊNG", subtitle: "Nam/Nữ tách biệt, sạch sẽ"),
      UtilityModel(icon: Icons.restaurant, title: "BẾP 5 SAO", subtitle: "Menu phong phú, pha chế ngon"),
      UtilityModel(icon: Icons.videocam, title: "PHÒNG STREAM", subtitle: "Cách âm, PC 2 màn, Cam xịn"),
    ];
  }
}
