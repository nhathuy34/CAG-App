import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notification_providers.dart';
import 'notification_item.dart';

class NotificationHistoryWidget extends ConsumerWidget {
  const NotificationHistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(notificationProvider).history;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0B121E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      /// 🔥 FIX overflow + scroll
      child: history.isEmpty
          ? const Center(
              child: Text(
                "Chưa có thông báo nào",
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return NotificationItem(item: item);
              },
            ),
    );
  }
}