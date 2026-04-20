class MapLocation {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String address;
  final String imageUrl;

  MapLocation({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
    required this.imageUrl,
  });

  // Convert từ API (SerpApi) sang Model
  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      id: json['place_id'] ?? '',
      name: json['title'] ?? 'Unknown Cyber',
      lat: json['gps_coordinates']?['latitude'] ?? 0.0,
      lng: json['gps_coordinates']?['longitude'] ?? 0.0,
      address: json['address'] ?? '',
      imageUrl: json['thumbnail'] ?? 'https://picsum.photos/200', // Ảnh fallback
    );
  }
}
