import 'package:flutter/material.dart';

class ZoneModel {
  final String title;
  final String priceGuest;
  final String priceMember;
  final String cpu;
  final String vga;
  final String monitor;
  final String gear;
  
  // Field bổ sung để đồng bộ TS
  final List<String> perks;

  ZoneModel({
    required this.title, 
    required this.priceGuest, 
    required this.priceMember,
    required this.cpu, 
    required this.vga, 
    required this.monitor, 
    required this.gear,
    this.perks = const [],
  });
}

class UtilityModel {
  final IconData icon;
  final String title;
  final String subtitle;

  UtilityModel({required this.icon, required this.title, required this.subtitle});
}