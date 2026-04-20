import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import file model của ní vào đây

final zonesProvider = FutureProvider<List<ZoneModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600)); // Cảm giác loading API
  return [
    ZoneModel(
      title: "PUBLIC ZONE",
      priceGuest: "8,000đ",
      priceMember: "7,000đ",
      cpu: "i3 10100F",
      vga: "GTX 1660s",
      monitor: "144Hz",
      gear: "Full Cơ",
    ),
    ZoneModel(
      title: "VIP ZONE",
      priceGuest: "12,000đ",
      priceMember: "10,000đ",
      cpu: "i5 12400F",
      vga: "RTX 3060",
      monitor: "165Hz",
      gear: "Cao cấp",
    ),
  ];
});

final utilitiesProvider = FutureProvider<List<UtilityModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  return [
    UtilityModel(icon: Icons.local_parking, title: "BÃI XE RỘNG", subtitle: "Có bảo vệ trông, Free giữ xe"),
    UtilityModel(icon: Icons.directions_car, title: "BÃI Ô TÔ", subtitle: "Đậu xe thoải mái, an ninh 24/7"),
    UtilityModel(icon: Icons.shower, title: "PHÒNG TẮM", subtitle: "Nước nóng lạnh - Dành cho dân cày đêm"),
    UtilityModel(icon: Icons.wc, title: "WC RIÊNG", subtitle: "Nam/Nữ tách biệt, sạch sẽ thơm tho"),
    UtilityModel(icon: Icons.ramen_dining, title: "BẾP 5 SAO", subtitle: "Menu cơm văn phòng, pha chế ngon"),
    UtilityModel(icon: Icons.smoking_rooms, title: "KHU HÚT THUỐC", subtitle: "Tách biệt, thoáng khí, view đẹp"),
  ];
});
