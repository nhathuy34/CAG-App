import 'zone_model.dart'; // Để dùng PCSpecs nếu cần

class Cafe {
  final String name;
  final String match;
  final String pc;
  final String ram;
  final String image;
  final String? year;
  final bool showRank;
  final int? rankNumber;
  final bool showPromo;
  final String? promoText;

  // Thêm từ TS Office
  final int? id;
  final String? address;
  final String? netKey;
  final double hourlyRate;
  final List<String> images;
  final double cagStars;
  final bool isCagProInstalled;

  const Cafe({
    required this.name,
    required this.match,
    required this.pc,
    required this.ram,
    required this.image,
    this.year,
    this.showRank = false,
    this.rankNumber,
    this.showPromo = false,
    this.promoText,
    this.id,
    this.address,
    this.netKey,
    this.hourlyRate = 0.0,
    this.images = const [],
    this.cagStars = 0.0,
    this.isCagProInstalled = false,
  });

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      name: json['name'] as String? ?? json['title'] ?? '',
      match: json['match'] as String? ?? '',
      pc: json['pc'] as String? ?? '',
      ram: json['ram'] as String? ?? '',
      image: json['image'] as String? ?? json['thumbnail'] ?? '',
      year: json['year'] as String?,
      showRank: json['showRank'] as bool? ?? false,
      rankNumber: json['rankNumber'] as int?,
      showPromo: json['showPromo'] as bool? ?? false,
      promoText: json['promoText'] as String?,
      // Từ TS
      id: json['id'] as int?,
      address: json['address'] as String?,
      netKey: json['netKey'] as String?,
      hourlyRate: (json['hourlyRate'] as num? ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      cagStars: (json['cagStars'] as num? ?? 0).toDouble(),
      isCagProInstalled: json['isCagProInstalled'] as bool? ?? false,
    );
  }
}