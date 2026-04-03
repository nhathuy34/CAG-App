import 'package:flutter/material.dart';
import '../widgets/detail_screen/detail_screen_components.dart';

class CloudSaveDetailScreen extends StatefulWidget {
  const CloudSaveDetailScreen({super.key});

  @override
  State<CloudSaveDetailScreen> createState() => _CloudSaveDetailScreenState();
}

class _CloudSaveDetailScreenState extends State<CloudSaveDetailScreen> {
  bool _isCloudSaveTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailTopHeader(),
                    DetailTabs(
                      isCloudSaveTab: _isCloudSaveTab,
                      onTabChanged: (value) =>
                          setState(() => _isCloudSaveTab = value),
                    ),
                    _isCloudSaveTab
                        ? const CloudSaveTabContent()
                        : const CommunityTabContent(),
                  ],
                ),
              ),
            ),
            const DetailFixedBottomMenu(),
          ],
        ),
      ),
    );
  }
}
