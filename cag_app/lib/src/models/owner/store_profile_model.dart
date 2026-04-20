import 'zone.dart';
import 'amenity.dart';
import 'featured_menu_item.dart';
import 'floor_plan_zone.dart';

class StoreProfileModel {
  final String name;
  final String address;
  final String description;
  final String status;
  final String statusText;
  final String? statusNote;
  final String? statusSubNote;
  final List<Zone>? zones;
  final List<String>? games;
  final List<Amenity>? amenities;
  final List<FeaturedMenuItem>? featuredMenu;
  final Map<String, List<FloorPlanZone>>? floorPlanData;

  const StoreProfileModel({
    required this.name,
    required this.address,
    required this.description,
    required this.status,
    required this.statusText,
    this.statusNote,
    this.statusSubNote,
    this.zones,
    this.games,
    this.amenities,
    this.featuredMenu,
    this.floorPlanData,
  });
}
