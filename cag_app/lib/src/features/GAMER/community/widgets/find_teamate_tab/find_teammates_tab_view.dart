import 'package:flutter/material.dart';
import 'find_teammates_tab_widget.dart';

class FindTeammatesTabView extends StatelessWidget {
  const FindTeammatesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    const cards = [
      (
        gameName: 'CS:GO 2',
        title: 'CẦN TÌM 2 BẠN BẮN CS:GO RANK GOLD',
        hostName: 'Tuấn Đạt',
        location: 'Khu vực Gò Vấp',
        time: '20:00 Tối nay',
        slots: '3/5',
        progress: 0.6,
      ),
      (
        gameName: 'VALORANT',
        title: 'TÌM TEAM FULL NỮ BẮN CHILL',
        hostName: 'Lan Anh',
        location: 'Online / Q.1',
        time: 'Ngay bây giờ',
        slots: '1/5',
        progress: 0.2,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CreateRoomBannerWidget(),
          const SizedBox(height: 14),
          for (var index = 0; index < cards.length; index++) ...[
            TeamCardWidget(
              gameName: cards[index].gameName,
              title: cards[index].title,
              hostName: cards[index].hostName,
              location: cards[index].location,
              time: cards[index].time,
              slots: cards[index].slots,
              progress: cards[index].progress,
            ),
            if (index != cards.length - 1) const SizedBox(height: 16),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
