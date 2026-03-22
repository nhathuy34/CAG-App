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
  });

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      name: json['name'] as String,
      match: json['match'] as String,
      pc: json['pc'] as String,
      ram: json['ram'] as String,
      image: json['image'] as String,
      year: json['year'] as String?,
      showRank: json['showRank'] as bool? ?? false,
      rankNumber: json['rankNumber'] as int?,
      showPromo: json['showPromo'] as bool? ?? false,
      promoText: json['promoText'] as String?,
    );
  }
}