import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GameRound extends ChangeNotifier {
  String? _gameRound = '0986';

  String? get gameRound {
    return _gameRound;
  }

  void updateGameRound(String gameRound) {
    _gameRound = gameRound;
    notifyListeners();
  }

  List<int> winningNumbers() {
    return getWinningNumbers() as List<int>;
  }
  Future getWinningNumbers() async {
    http.Response response =
    await http.get(Uri.parse("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$_gameRound"));

    List<int> winningNumbers = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['returnValue'].toString() == 'success') {
        winningNumbers.add(data['drwtNo1']);
        winningNumbers.add(data['drwtNo2']);
        winningNumbers.add(data['drwtNo3']);
        winningNumbers.add(data['drwtNo4']);
        winningNumbers.add(data['drwtNo5']);
        winningNumbers.add(data['drwtNo6']);

        print(winningNumbers.toString());
      }
    } else {
      print(response.statusCode);
    }
    return winningNumbers;
  }
}