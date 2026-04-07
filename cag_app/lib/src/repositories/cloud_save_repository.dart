import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class CloudSaveRepository {
  final String _apiUrl = 'https://games.cagboot.com/checktimegame.php';

  Future<List<GameModel>> fetchGamesFromApi() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        // Giải mã JSON với tiếng Việt (utf8.decode) để tránh lỗi font tên game
        final Map<String, dynamic> jsonData = jsonDecode(
          utf8.decode(response.bodyBytes),
        );

        // Truy cập đúng vào key "data" như trong JSON bạn gửi
        final List<dynamic> gamesList = jsonData['data'] ?? [];

        return gamesList.map((item) => GameModel.fromJson(item)).toList();
      } else {
        throw Exception('Server trả về lỗi: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Lỗi Repository: $e");
      return []; // Trả về mảng rỗng thay vì crash app
    }
  }
}
