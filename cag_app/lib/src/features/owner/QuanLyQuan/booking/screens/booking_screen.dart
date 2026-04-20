import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_providers.dart';
import '../widgets/booking_card.dart';
import '../../../../../constants/app_theme.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(bookingTabProvider);
    final bookingsAsync = ref.watch(bookingsProvider);

    final tabs = [
      {'key': 'choduyet', 'label': 'Chờ duyệt (2)'},
      {'key': 'sapden', 'label': 'Sắp đến (2)'},
      {'key': 'lichsu', 'label': 'Lịch sử (3)'},
    ];

    return Container(
      color: AppTheme.darkBg,
      child: Column(
        children: [
          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = activeTab == tab['key'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => ref.read(bookingTabProvider.notifier).state = tab['key']!,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF2979FF) : const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Text(
                          tab['label']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Cards Grid
          Expanded(
            child: bookingsAsync.when(
              data: (bookings) => LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 1200 ? 4 : (constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1));
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: bookings.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 220, // Increased height to prevent overflow
                    ),
                    itemBuilder: (context, index) {
                      return BookingCard(
                        booking: bookings[index],
                        activeTab: activeTab,
                      );
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
            ),
          ),
        ],
      ),
    );
  }
}
