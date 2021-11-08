import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/game.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';

class LottoCard extends StatelessWidget {
  final LottoSheetModel lottoSheet;
  final int index;

  const LottoCard({Key? key, required this.index, required this.lottoSheet}) : super(key: key);

  List<TableRow> generateGameRow(List<Game> gameSet) {
    return gameSet
        .map(
          (game) => TableRow(children: [
            Text(game.code),
            Row(
              children: game.numbers.map((int num) => Text('${num.toString()} ')).toList(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(index.toString()),
            Text(lottoSheet.gameRound),
            Text(lottoSheet.sellerCode),
            IconButton(
                onPressed: () {
                  Hive.box<LottoSheetModel>('lottoSheet').deleteAt(index);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        Table(
          children: generateGameRow(lottoSheet.gameSet),
        )
      ],
    ));
  }
}
