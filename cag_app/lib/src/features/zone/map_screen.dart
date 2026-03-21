import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final String destinationName; 
  const MapScreen({super.key, required this.destinationName});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController; 
  Position? _currentPosition; 
  
  // Tọa độ chính xác từ link bạn gửi (An Phat Computer PT)
  // Link: https://maps.app.goo.gl/tgsngR2rnAcLG4n27
  final LatLng _destinationLocation = const LatLng(10.803913, 106.714045);
  
  final Set<Marker> _markers = {}; 
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  /// Khởi tạo: Lấy vị trí người dùng và cắm Marker cho An Phat Computer
  Future<void> _initMap() async {
    try {
      // 1. Lấy vị trí hiện tại
      await _getCurrentLocation();
      
      // 2. Thêm Marker điểm đến
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: _destinationLocation,
          infoWindow: InfoWindow(
            title: widget.destinationName,
            snippet: '157/28 Bùi Đình Túy, Phường 24, Bình Thạnh',
          ),
        ),
      );
    } catch (e) {
      debugPrint('Lỗi khởi tạo bản đồ: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    if (_currentPosition != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destinationName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D1321),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _destinationLocation, // Luôn tập trung vào An Phat Computer
                    zoom: 17,
                  ),
                  onMapCreated: (controller) => _mapController = controller,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: true,
                ),
                
                // Nút Dẫn đường thực tế
                Positioned(
                  bottom: 30, left: 20, right: 20,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      final url = 'https://www.google.com/maps/dir/?api=1&destination=${_destinationLocation.latitude},${_destinationLocation.longitude}&travelmode=driving';
                      final Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('BẮT ĐẦU DẪN ĐƯỜNG', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
    );
  }
}
