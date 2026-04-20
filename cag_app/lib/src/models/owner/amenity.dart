class Amenity {
  final String icon;
  final String label;
  final bool checked;

  const Amenity({
    required this.icon,
    required this.label,
    this.checked = false,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    icon: json['icon'],
    label: json['label'],
    checked: json['checked'] ?? false,
  );
}
