import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../models/owner_models.dart';
import '../../../../../repositories/owner_repository.dart';

// Providers for Booking
final bookingTabProvider = StateProvider<String>((ref) => 'choduyet');

final bookingsProvider = FutureProvider<List<BookingModel>>((ref) {
  final tab = ref.watch(bookingTabProvider);
  final repo = ref.watch(ownerRepositoryProvider);
  return repo.getBookings(tab);
});
