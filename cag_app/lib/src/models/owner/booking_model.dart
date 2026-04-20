class BookingModel {
  final int id;
  final String name;
  final String room;
  final String roomType;
  final String member;
  final String time;
  final String note;
  final int avatar;
  final String? status;

  const BookingModel({
    required this.id,
    required this.name,
    required this.room,
    required this.roomType,
    required this.member,
    required this.time,
    required this.note,
    required this.avatar,
    this.status,
  });
}
