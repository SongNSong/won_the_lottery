import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/models/winning_numbers_model.dart';
import 'package:won_the_lottery/utilities/game_round_provider.dart';
import 'package:won_the_lottery/utilities/get_winning_numbers.dart';

class WinningNumbersCard extends StatefulWidget {
  const WinningNumbersCard({Key? key}) : super(key: key);

  @override
  _WinningNumbersCardState createState() => _WinningNumbersCardState();
}

class _WinningNumbersCardState extends State<WinningNumbersCard> {
  Box<WinningNumbersModel> winningNumbersBox = Hive.box<WinningNumbersModel>('winningNumbers');

  @override
  Widget build(BuildContext context) {
    return Consumer<GameRoundProvider>(builder: (_, gameRound, child) {
      return FutureBuilder(
        future: getWinningNumbers(gameRound.gameRound!),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Card(
                child: Column(
                    children: winningNumbersBox.get(gameRound.gameRound)!.numbers.isNotEmpty
                        ? [
                            const Text('당첨 번호'),
                            Text(winningNumbersBox.get(gameRound.gameRound)!.numbers.toString()),
                          ]
                        : [
                          const Text("미추첨 번호입니다."),
                    ]));
          }
        },
      );
    });
  }
}
