class Zone {
  final String name;
  final String vga;
  final String cpu;
  final String price;
  final String member;
  final bool active;

  const Zone({
    required this.name,
    required this.vga,
    required this.cpu,
    required this.price,
    required this.member,
    this.active = true,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    name: json['name'],
    vga: json['vga'],
    cpu: json['cpu'],
    price: json['price'],
    member: json['member'],
    active: json['active'] ?? true,
  );
}
