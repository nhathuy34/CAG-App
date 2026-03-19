class GamerStats {
  final String trustScore;
  final String hoursPlayed;
  final String winRate;
  final String balance;
  final String accessId;
  final List<MembershipCard> linkedCards;
  final List<LootBoxItem> lootBoxes;

  GamerStats({
    required this.trustScore,
    required this.hoursPlayed,
    required this.winRate,
    required this.balance,
    required this.accessId,
    required this.linkedCards,
    required this.lootBoxes,
  });

  GamerStats copyWith({
    String? balance,
    List<MembershipCard>? linkedCards,
    List<LootBoxItem>? lootBoxes,
  }) {
    return GamerStats(
      trustScore: trustScore,
      hoursPlayed: hoursPlayed,
      winRate: winRate,
      balance: balance ?? this.balance,
      accessId: accessId,
      linkedCards: linkedCards ?? this.linkedCards,
      lootBoxes: lootBoxes ?? this.lootBoxes,
    );
  }
}

class MembershipCard {
  final String title;
  final String number;
  final String price;
  final String memberType;
  final String imagePath;
  final bool isOnline;

  MembershipCard({
    required this.title,
    required this.number,
    required this.price,
    required this.memberType,
    required this.imagePath,
    required this.isOnline,
  });

  factory MembershipCard.fromJson(Map<String, dynamic> json) => MembershipCard(
    title: json['title'] ?? '',
    number: json['number'] ?? '',
    price: json['price'] ?? '0',
    memberType: json['memberType'] ?? '',
    imagePath: json['imagePath'] ?? '',
    isOnline: json['isOnline'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'number': number,
    'price': price,
    'memberType': memberType,
    'imagePath': imagePath,
    'isOnline': isOnline,
  };
}

class LootBoxItem {
  final String id;
  final String tag;
  final String title;
  final String price;
  final String imagePath;

  LootBoxItem({
    required this.id,
    required this.tag,
    required this.title,
    required this.price,
    required this.imagePath,
  });

  factory LootBoxItem.fromJson(Map<String, dynamic> json) => LootBoxItem(
    id: json['ud'] ?? '',
    tag: json['tag'] ?? '',
    title: json['title'] ?? '',
    price: json['price'] ?? '0',
    imagePath: json['imagePath'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': title,
    'tag': tag,
    'title': title,
    'price': price,
    'imagePath': imagePath,
  };
}
