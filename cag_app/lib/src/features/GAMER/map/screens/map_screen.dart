import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // Để mở app bản đồ
import 'package:CAG_App/src/utils/responsive.dart';
import '../providers/map_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  // Style Dark Mode Cyberpunk cho Map
  final String _darkMapStyle = '''
  [
    {"elementType": "geometry","stylers": [{"color": "#1d2c4d"}]},
    {"elementType": "labels.text.fill","stylers": [{"color": "#8ec3b9"}]},
    {"elementType": "labels.text.stroke","stylers": [{"color": "#1a3646"}]},
    {"featureType": "road","elementType": "geometry","stylers": [{"color": "#304a7d"}]},
    {"featureType": "water","elementType": "geometry","stylers": [{"color": "#0e1626"}]}
  ]
  ''';

  // Hàm mở ứng dụng bản đồ bên ngoài để chỉ đường thật
  Future<void> _launchNavigation(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    final Uri appleMapsUrl = Uri.parse("http://maps.apple.com/?daddr=$lat,$lng");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không thể mở ứng dụng bản đồ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(userLocationProvider);
    final cafesState = ref.watch(nearbyCafesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1321),
      body: locationState.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.cyanAccent),
              SizedBox(height: 16),
              Text('Đang định vị GPS...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        error: (err, _) => Center(
          child: Text('Lỗi GPS: $err', style: const TextStyle(color: Colors.red)),
        ),
        data: (position) {
          final userLatLng = LatLng(position.latitude, position.longitude);
          Set<Marker> markers = {};

          // Marker User
          markers.add(
            Marker(
              markerId: const MarkerId('user_location'),
              position: userLatLng,
              infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            ),
          );

          // Markers Quán Net từ API
          if (cafesState is AsyncData) {
            for (var cafe in cafesState.value!) {
              markers.add(
                Marker(
                  markerId: MarkerId(cafe.id),
                  position: LatLng(cafe.lat, cafe.lng),
                  infoWindow: InfoWindow(
                    title: cafe.name,
                    snippet: 'Bấm để chỉ đường: ${cafe.address}',
                    onTap: () => _launchNavigation(cafe.lat, cafe.lng),
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                ),
              );
            }
          }

          return Stack(
            children: [
              // 1. Google Map
              GoogleMap(
                initialCameraPosition: CameraPosition(target: userLatLng, zoom: 15),
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false, // Tắt nút mặc định để không bị đè
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.setMapStyle(_darkMapStyle);
                },
              ),

              // 2. Nút ĐÓNG MAP (Góc trên phải)
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.widthPercent(context, 4)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.extended(
                      heroTag: 'close_map',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      icon: Icon(Icons.close, size: Responsive.fontSize(context, 18)),
                      label: Text('ĐÓNG MAP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Responsive.fontSize(context, 14))),
                    ),
                  ),
                ),
              ),

              // 3. CỤM NÚT ĐIỀU KHIỂN (Góc dưới phải - Không bị đè)
              Positioned(
                bottom: Responsive.heightPercent(context, 3),
                right: Responsive.widthPercent(context, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Nút Reset về vị trí User
                    FloatingActionButton(
                      heroTag: 'my_loc',
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        final GoogleMapController controller = await _controller.future;
                        controller.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 16));
                      },
                      child: const Icon(Icons.my_location, color: Color(0xFF0D1321)),
                    ),
                    const SizedBox(height: 12),
                    // Nút CHỈ ĐƯỜNG (Màu Neon)
                    FloatingActionButton.extended(
                      heroTag: 'nav_btn',
                      backgroundColor: const Color(0xFF00F2EA),
                      onPressed: () {
                        if (cafesState.value != null && cafesState.value!.isNotEmpty) {
                          // Chỉ đường tới quán đầu tiên trong danh sách
                          final firstCafe = cafesState.value!.first;
                          _launchNavigation(firstCafe.lat, firstCafe.lng);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Không có dữ liệu quán gần đây")),
                          );
                        }
                      },
                      icon: const Icon(Icons.directions, color: Colors.black),
                      label: const Text(
                        'CHỈ ĐƯỜNG',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
