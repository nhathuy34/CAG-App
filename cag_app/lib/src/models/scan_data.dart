class ScanData {
  final String code;
  final DateTime scannedAt;
  final String? type;

  ScanData({
    required this.code,
    required this.scannedAt,
    this.type,
  });

  factory ScanData.fromJson(Map<String, dynamic> json) {
    return ScanData(
      code: json['code'] as String,
      scannedAt: DateTime.parse(json['scannedAt'] as String),
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'scannedAt': scannedAt.toIso8601String(),
      'type': type,
    };
  }

  ScanData copyWith({
    String? code,
    DateTime? scannedAt,
    String? type,
  }) {
    return ScanData(
      code: code ?? this.code,
      scannedAt: scannedAt ?? this.scannedAt,
      type: type ?? this.type,
    );
  }
}
