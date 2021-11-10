import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/game.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';

class LottoCard extends StatelessWidget {
  final LottoSheetModel lottoSheet;
  final int index;

  const LottoCard({Key? key, required this.index, required this.lottoSheet}) : super(key: key);

  String resultOfGame(List<int>? winningNumbers, List<int> gameNumbers) {
    int countOfMatchNumber = 0;
    if (winningNumbers == null) {
      return '미추첨';
    } else {
      for (int i = 0; i < winningNumbers.length - 1; i++) {
        if (gameNumbers.contains(winningNumbers[i])) {
          countOfMatchNumber++;
        }
      }
      switch (countOfMatchNumber) {
        case 6:
          return '1등';
        case 5:
          return gameNumbers.contains(winningNumbers.last) ? '2등' : '3등';
        case 4:
          return '4등';
        case 3:
          return '5등';
        default:
          return '낙첨';
      }
    }
  }

  List<TableRow> generateGameRow(List<Game> gameSet, List<int>? winningNumbers) {
    return gameSet
        .map(
          (game) => TableRow(children: [
            Center(child: Text(game.code)),
            Center(child: Text(resultOfGame(winningNumbers, game.numbers))),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: game.numbers.map((int num) {
                  if (winningNumbers != null) {
                    if (winningNumbers.contains(num)) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                        width: 30,
                        height: 30,
                        child: Text('$num'),
                      );
                    }
                  }
                  return Container(alignment: Alignment.center, width: 30, height: 30, child: Text('$num'));
                }).toList(),
              ),
            ),
          ]),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('회차: ${lottoSheet.gameRound}'),
            Text('판매처코드: ${lottoSheet.sellerCode}'),
            IconButton(
                onPressed: () {
                  Hive.box<LottoSheetModel>('lottoSheet').deleteAt(index);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(4),
          },
          children: generateGameRow(lottoSheet.gameSet, lottoSheet.winningNumbers),
        )
      ],
    ));
  }
}
