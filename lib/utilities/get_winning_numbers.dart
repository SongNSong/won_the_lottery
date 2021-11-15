import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/winning_numbers_model.dart';
import 'package:http/http.dart' as http;

Future<List<int>> getWinningNumbers(String gameRound) async {
  Box<WinningNumbersModel> winningNumbersBox = Hive.box<WinningNumbersModel>("winningNumbers");

  if (winningNumbersBox.keys.contains(gameRound) && winningNumbersBox.get(gameRound)!.numbers == []) {
    List<int> winningNumbers = winningNumbersBox.get(gameRound)!.numbers;

    return winningNumbers;
  } else {
    List<int> numbers = [];

    http.Response response =
        await http.get(Uri.parse("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$gameRound"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['returnValue'].toString() == 'success') {
        numbers.add(data['drwtNo1']);
        numbers.add(data['drwtNo2']);
        numbers.add(data['drwtNo3']);
        numbers.add(data['drwtNo4']);
        numbers.add(data['drwtNo5']);
        numbers.add(data['drwtNo6']);
        numbers.add(data['bnusNo']);
      }
    } else {
      print(response.statusCode);
    }

    winningNumbersBox.put(gameRound, WinningNumbersModel(numbers: numbers));
    return numbers;
  }
}
