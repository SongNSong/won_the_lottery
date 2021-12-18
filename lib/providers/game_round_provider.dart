import 'package:flutter/material.dart';

class GameRoundProvider extends ChangeNotifier {
  String? _gameRound;

  String? get gameRound {
    return _gameRound;
  }

  void updateGameRound(String? gameRound) {
    _gameRound = gameRound;
    notifyListeners();
  }
}
