class FeaturedMenuItem {
  final String name;
  final String price;

  const FeaturedMenuItem({
    required this.name,
    required this.price,
  });

  factory FeaturedMenuItem.fromJson(Map<String, dynamic> json) => FeaturedMenuItem(
    name: json['name'],
    price: json['price'],
  );
}
