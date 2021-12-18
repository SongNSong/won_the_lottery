import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:won_the_lottery/models/winning_numbers_model.dart';

Future<List<int>> getWinningNumbers(String? gameRound) async {
  Box<WinningNumbersModel> winningNumbersBox = Hive.box<WinningNumbersModel>('winningNumbers');
  WinningNumbersModel? winningNumbers = winningNumbersBox.get(gameRound);
  List<int> numbers = [];

  if (winningNumbers != null) {
    bool existWinningNumbers = winningNumbers.numbers.isNotEmpty;
    if (existWinningNumbers) {
      numbers = winningNumbersBox.get(gameRound)!.numbers;
    }
  } else {
    http.Response response =
        await http.get(Uri.parse('https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$gameRound'));

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

    await winningNumbersBox.put(gameRound, WinningNumbersModel(numbers: numbers));
  }

  return numbers;
}
