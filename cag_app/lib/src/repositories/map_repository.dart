import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import '../models/map_location.dart';

class MapRepository {
  final Dio _dio = Dio();
  final String _serpApiKey = dotenv.env['SERP_API_KEY'] ?? "";

  // 1. Task: Lấy vị trí hiện tại GPS
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // 2. Task: Gọi SerpApi để lấy danh sách Cyber Cafe quanh vị trí User
  Future<List<MapLocation>> getNearbyCyberCafes(double lat, double lng) async {
    try {
      // Endpoint của SerpApi tìm kiếm Google Local
      const String url = "https://serpapi.com/search.json";
      
      final response = await _dio.get(url, queryParameters: {
        "engine": "google_local",
        "q": "Cyber gaming, Quán Net", // Từ khóa tìm kiếm
        "ll": "@$lat,$lng,14z",        // Tọa độ GPS của user
        "hl": "vi",
        "api_key": _serpApiKey,
      });

      if (response.statusCode == 200 && response.data['local_results'] != null) {
        final List results = response.data['local_results'];
        return results.map((json) => MapLocation.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Lỗi gọi SerpAPI: $e");
      // MOCK DATA: Nếu API lỗi hoặc chưa có Key, trả về data giả để làm UI
      return [
        MapLocation(id: '1', name: 'Doragon Cyber Q.10', lat: lat + 0.002, lng: lng + 0.002, address: 'Q10', imageUrl: 'https://picsum.photos/100'),
        MapLocation(id: '2', name: 'Flash Gaming', lat: lat - 0.003, lng: lng + 0.001, address: 'Q10', imageUrl: 'https://picsum.photos/101'),
      ];
    }
  }
} 