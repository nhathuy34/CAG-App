import 'enums.dart';

class BookingModel {
  final String id;
  final int shopId;
  final String shopName;
  final String timeSlot;
  final String pcType;
  final String status;
  final String? seatLabel;

  BookingModel({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.timeSlot,
    required this.pcType,
    required this.status,
    this.seatLabel,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      shopId: json['shopId'] as int,
      shopName: json['shopName'] as String,
      timeSlot: json['timeSlot'] as String,
      pcType: json['pcType'] as String,
      status: json['status'] as String,
      seatLabel: json['seatLabel'] as String?,
    );
  }
}