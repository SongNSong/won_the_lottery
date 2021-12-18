import 'package:won_the_lottery/models/game_model.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';

final List<String> _keyList = ['A', 'B', 'C', 'D', 'E'];

LottoSheetModel getLottoSheet(String lottoURL) {
  List<String> lottoSets = lottoURL.split('v=')[1].split('q');
  List<GameModel> gameSet = [];
  for (int i = 1; i < lottoSets.length; i++) {
    List<int> selectedNumbers = [];
    for (int j = 0; j < 6; j++) {
      int startIndex = j * 2;
      selectedNumbers.add(int.parse(lottoSets[i].substring(startIndex, startIndex + 2)));
    }
    gameSet.add(GameModel(code: _keyList[i - 1], numbers: selectedNumbers));
  }

  return LottoSheetModel(
      gameRound: lottoSets[0], sellerCode: lottoSets[lottoSets.length - 1].substring(12), gameSet: gameSet);
}
