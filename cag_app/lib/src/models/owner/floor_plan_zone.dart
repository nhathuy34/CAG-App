class FloorPlanZone {
  final String name;
  final int totalCount;
  final int count;
  final String price;
  final String? specs;
  final String color;
  final int grid;
  final String w;
  final String h;
  final String? left;
  final String? top;
  final String? right;
  final String? bottom;

  const FloorPlanZone({
    required this.name,
    required this.totalCount,
    required this.count,
    required this.price,
    this.specs,
    required this.color,
    required this.grid,
    required this.w,
    required this.h,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });
}
