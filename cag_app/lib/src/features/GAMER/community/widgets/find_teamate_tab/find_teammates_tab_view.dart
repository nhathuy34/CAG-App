import 'package:flutter/material.dart';
import 'find_teammates_tab_widget.dart';

class FindTeammatesTabView extends StatelessWidget {
  const FindTeammatesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CreateRoomBannerWidget(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TeamCardWidget(
                  gameName: 'CS:GO 2',
                  title: 'CẦN TÌM 2 BẠN BẮN CS:GO RANK GOLD',
                  hostName: 'Tuấn Đạt',
                  location: 'Khu vực Gò Vấp',
                  time: '20:00 Tối nay',
                  slots: '3/5',
                  progress: 0.6,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TeamCardWidget(
                  gameName: 'VALORANT',
                  title: 'TÌM TEAM FULL NỮ BẮN CHILL',
                  hostName: 'Lan Anh',
                  location: 'Online / Q.1',
                  time: 'Ngay bây giờ',
                  slots: '1/5',
                  progress: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
