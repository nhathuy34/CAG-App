import '../models/gamer_models.dart';

class CafeRepository {
  Future<List<Cafe>> getTopTrendingCafes() async {
    // Mock data
    return [
      const Cafe(
        name: 'Gaming House Pro',
        match: '4.8',
        pc: '100',
        ram: '32',
        image: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400',
        showRank: false,
      ),
      const Cafe(
        name: 'Speed Gaming 2',
        match: '4.5',
        pc: '80',
        ram: '24',
        image: 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400',
      ),
      const Cafe(
        name: 'Flash Gaming Center',
        match: '5.0',
        pc: '120',
        ram: '32', 
        image: 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
        showRank: true,
        rankNumber: 10,
        showPromo: true,
        promoText: 'NẠP TẶNG 50%',
      ),
    ];
  }

  Future<List<Cafe>> getRtx40Cafes() async {
    return [
      const Cafe(
        name: 'RTX Arena',
        match: '4.9',
        pc: '60',
        ram: '32',
        image: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400',
        showPromo: true,
        promoText: 'GIẢM 20% GIỜ CHƠI',
      ),
    ];
  }

  Future<List<Cafe>> getCoupleZoneCafes() async {
    return [
      const Cafe(
        name: 'Love & Game',
        match: '4.7',
        pc: '24',
        ram: '16',
        image: 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=400',
      ),
    ];
  }

  Future<List<Cafe>> getDiamondCafes() async {
    return [
      const Cafe(
        name: 'Diamond Cyber',
        match: '5.0',
        pc: '200',
        ram: '64',
        image: 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
        showRank: true,
        rankNumber: 1,
      ),
    ];
  }
}
