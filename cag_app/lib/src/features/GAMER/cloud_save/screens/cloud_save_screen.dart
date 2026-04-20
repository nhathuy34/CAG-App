import 'dart:async';
import 'package:CAG_App/src/features/GAMER/cloud_save/widgets/common/animation.dart';
import 'package:CAG_App/src/features/GAMER/cloud_save/widgets/main_screen/game_filter_button.dart';
import 'package:CAG_App/src/features/GAMER/cloud_save/widgets/main_screen/searchGame.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/gamer_models.dart';
import '../../../../repositories/cloud_save_repository.dart';
import '../widgets/common/game_card.dart';
import 'cloud_save_detail_screen.dart';

import '../widgets/main_screen/main_screen_components.dart';

import 'fake_game_detail_screen.dart';

class CloudSaveScreen extends ConsumerStatefulWidget {
  const CloudSaveScreen({super.key});

  @override
  ConsumerState<CloudSaveScreen> createState() => _CloudSaveScreenState();
}

class _CloudSaveScreenState extends ConsumerState<CloudSaveScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  String _currentTime = "";
  final CloudSaveRepository _repository = CloudSaveRepository();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fireworksController;
  List<GameModel> _allGames = [];
  List<GameModel> _filteredGames = [];
  String _activeTab = "TẤT CẢ (IDC)";
  bool _isLoading = true;
  bool _showDiamondCard = false;
  bool _isFilteringNew = false;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentTime = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _fireworksController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fetchInitialData();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(
          () => _currentTime = DateFormat(
            'HH:mm dd/MM/yyyy',
          ).format(DateTime.now()),
        );
      }
    });
  }

  Future<void> _fetchInitialData() async {
    try {
      final games = await _repository.fetchGamesFromApi();
      if (mounted) {
        setState(() {
          _allGames = games;
          _updateFilteredGames();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _updateFilteredGames() {
    // Bước 1: Lọc theo tab
    List<GameModel> tabFiltered;
    if (_activeTab == "TẤT CẢ (IDC)") {
      tabFiltered = _allGames;
    } else if (_activeTab == "ONLINE") {
      tabFiltered = _allGames.where((g) => g.rank == "ONLINE").toList();
    } else if (_activeTab == "OFFLINE") {
      tabFiltered = _allGames.where((g) => g.rank == "OFFLINE").toList();
    } else if (_activeTab == "TOOLS") {
      tabFiltered = _allGames.where((g) => g.rank == "TOOLS").toList();
    } else if (_activeTab == "GAME CỦA TÔI") {
      tabFiltered = []; // Không áp dụng filter cho tab này
    } else {
      tabFiltered = [];
    }

    // Bước 2: Lọc theo new filter nếu bật (chỉ cho các tab API)
    if (_isFilteringNew && _activeTab != "GAME CỦA TÔI") {
      DateTime now = DateTime.now();
      tabFiltered = tabFiltered.where((game) {
        DateTime updateTime =
            DateTime.tryParse(game.progressValue) ?? DateTime.now();
        return now.difference(updateTime).inDays <= 3;
      }).toList();
    }

    // Bước 3: Lọc theo search
    if (_searchQuery.isNotEmpty) {
      _filteredGames = tabFiltered
          .where(
            (game) =>
                game.title.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    } else {
      _filteredGames = tabFiltered;
    }
  }

  void _onTabChanged(String tabLabel) {
    setState(() {
      _activeTab = tabLabel;
      _updateFilteredGames();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _updateFilteredGames();
    });
  }

  void _triggerCongratulation() {
    _fireworksController.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _showDiamondCard = true);
        _animationController.forward(from: 0.0);
      }
    });
  }

  void _closeDiamondCard() {
    _animationController.reverse().then(
      (_) => setState(() => _showDiamondCard = false),
    );
  }

  void _toggleFilterNew() {
    setState(() {
      _isFilteringNew = !_isFilteringNew;
      _updateFilteredGames();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _fireworksController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // --- HÀM ĐIỀU HƯỚNG ---
  void _navigateToDetail(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    int totalCount = _allGames.length;
    int onlineCount = _allGames.where((g) => g.rank == "ONLINE").length;
    int offlineCount = _allGames.where((g) => g.rank == "OFFLINE").length;
    int toolsCount = _allGames.where((g) => g.rank == "TOOLS").length;
    int searchCount = _searchQuery.isEmpty
        ? (_activeTab == "GAME CỦA TÔI" ? 4 : _filteredGames.length)
        : _filteredGames.length;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              MainHeader(
                currentTime: _currentTime,
                onPlayTap: () {
                  ref.read(navIndexProvider.notifier).setIndex(3);
                },  
                onCloudSaveTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CloudSaveDetailScreen(),
                  ),
                ),
                onCardTap: _triggerCongratulation,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.widthPercent(context, 5)),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ProCloudSaveCard(onTrigger: _triggerCongratulation),
                    SizedBox(height: Responsive.heightPercent(context, 4)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "THƯ VIỆN ",
                            style: TextStyle(
                              color: Color(0xFF00FF75),
                              fontSize: Responsive.fontSize(context, 24),
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: "GAME",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.fontSize(context, 24),
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.heightPercent(context, 2)),
                    MainTabFilter(
                      activeTab: _activeTab,
                      totalCount: totalCount,
                      onlineCount: onlineCount,
                      offlineCount: offlineCount,
                      toolsCount: toolsCount,
                      onTabChanged: _onTabChanged,
                    ),
                    const SizedBox(height: 20),
                    GameSearchBar(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      gameCount: searchCount,
                    ),
                    const SizedBox(height: 15),
                    GameFilterButton(
                      isFiltering: _isFilteringNew,
                      onTap: _toggleFilterNew,
                    ),
                    SizedBox(height: Responsive.heightPercent(context, 2.5)),
                    const MainInfoBanner(),
                    SizedBox(height: Responsive.heightPercent(context, 2.5)),
                  ]),
                ),
              ),

              _isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF00FF75),
                        ),
                      ),
                    )
                  : (_activeTab == "GAME CỦA TÔI"
                        ? SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: Responsive.widthPercent(context, 5)),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                // LOL
                                GestureDetector(
                                  onTap: () => _navigateToDetail(
                                    context,
                                    const FakeGameDetailScreen(
                                      bgUrl:
                                          "https://picsum.photos/seed/lol_game_detail/600/400",
                                      title: "LEAGUE OF LEGENDS",
                                      playtime: "1200H ĐÃ CHƠI",
                                      location: "FLASH GAMING ...",
                                      isEmptySave: true,
                                    ),
                                  ),
                                  child: const FakeMyGameCard(
                                    title: "LEAGUE OF LEGENDS",
                                    type: "ONLINE",
                                    time: "18:44 03/04/2026",
                                    location: "Flash Gaming Center",
                                    progress: 0.85,
                                    progressText: "%",
                                    imageUrl:
                                        "https://picsum.photos/seed/lol_game/200/300",
                                  ),
                                ),
                                // ELDEN RING
                                GestureDetector(
                                  onTap: () => _navigateToDetail(
                                    context,
                                    const FakeGameDetailScreen(
                                      bgUrl:
                                          "https://picsum.photos/seed/elden_detail/600/400",
                                      title: "ELDEN RING",
                                      playtime: "500H ĐÃ CHƠI",
                                      location: "SPEED GAMING 2",
                                      hasAIBtn: true,
                                      saveTitle: "MALENIA_DEFEATED",
                                      saveTime: "23:44 29/03/2026",
                                      saveLocation: "SPEED GAMING 2",
                                      saveSize: "24MB",
                                      isLocked: true,
                                    ),
                                  ),
                                  child: const FakeMyGameCard(
                                    title: "ELDEN RING",
                                    type: "OFFLINE",
                                    time: "23:44 02/04/2026",
                                    location: "Speed Gaming 2",
                                    progress: 1.0,
                                    progressText: "100%",
                                    imageUrl:
                                        "https://picsum.photos/seed/elden/200/300",
                                  ),
                                ),
                                // GTA V
                                GestureDetector(
                                  onTap: () => _navigateToDetail(
                                    context,
                                    const FakeGameDetailScreen(
                                      bgUrl:
                                          "https://picsum.photos/seed/gta_detail/600/400",
                                      title: "GRAND THEFT AUTO V",
                                      playtime: "124H ĐÃ CHƠI",
                                      location: "FLASH GAMING ...",
                                      hasAIBtn: false,
                                      saveTitle: "STORY_100%",
                                      saveTime: "23:44 31/03/2026",
                                      saveLocation: "FLASH GAMING CENTER",
                                      saveSize: "15MB",
                                      isLocked: false,
                                    ),
                                  ),
                                  child: const FakeMyGameCard(
                                    title: "GRAND THEFT AUTO V",
                                    type: "LICENSE",
                                    time: "23:44 31/03/2026",
                                    location: "Flash Gaming Center",
                                    progress: 0.85,
                                    progressText: "%",
                                    imageUrl:
                                        "https://picsum.photos/seed/gta/200/300",
                                  ),
                                ),
                                // VALORANT
                                GestureDetector(
                                  onTap: () => _navigateToDetail(
                                    context,
                                    const FakeGameDetailScreen(
                                      bgUrl:
                                          "https://picsum.photos/seed/valo_detail/600/400",
                                      title: "VALORANT",
                                      playtime: "350H ĐÃ CHƠI",
                                      location: "MÁY NHÀ",
                                      hasAIBtn: false,
                                      saveTitle: "CONFIG_SETTINGS",
                                      saveTime: "23:44 27/03/2026",
                                      saveLocation: "GAMING HOUSE PRO",
                                      saveSize: "1KB",
                                      isLocked: false,
                                    ),
                                  ),
                                  child: const FakeMyGameCard(
                                    title: "VALORANT",
                                    type: "ONLINE",
                                    time: "23:44 27/03/2026",
                                    location: "Máy Nhà",
                                    progress: 0.85,
                                    progressText: "%",
                                    imageUrl:
                                        "https://picsum.photos/seed/valorant/200/300",
                                  ),
                                ),
                              ]),
                            ),
                          )
                        : (_filteredGames.isEmpty
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    height: Responsive.heightPercent(context, 25),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Không tìm thấy game phù hợp.",
                                      style: TextStyle(
                                        color: Colors.white24,
                                        fontSize: Responsive.fontSize(context, 14),
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                )
                              : SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) => GameCard(
                                        game: _filteredGames[index],
                                        isMyGameTab: false,
                                      ),
                                      childCount: _filteredGames.length,
                                    ),
                                  ),
                                ))),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
          IgnorePointer(
            child: NativeFireworks(animation: _fireworksController),
          ),
          if (_showDiamondCard)
            DiamondCardOverlay(
              scaleAnimation: _scaleAnimation,
              onClose: _closeDiamondCard,
            ),
        ],
      ),
    );
  }
}
