import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/providers/game_round_provider.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';

class LottoRoundWidget extends StatefulWidget {

  const LottoRoundWidget({Key? key}) : super(key: key);

  @override
  State<LottoRoundWidget> createState() => _LottoRoundWidgetState();
}

class _LottoRoundWidgetState extends State<LottoRoundWidget> {
  late List<String> gameRoundList = [];

  @override
  Widget build(BuildContext context) {
    Box<LottoSheetModel> lottoSheetBox = Hive.box<LottoSheetModel>('lottoSheet');
    // 회차 리스트 추출
    for (LottoSheetModel lottoSheet in lottoSheetBox.values) {
      {
          if (!gameRoundList.contains(lottoSheet.gameRound)) {gameRoundList.add(lottoSheet.gameRound);}
        }
    }


    return Consumer<GameRoundProvider>(
      builder: (_, gameRound, child) {
        return Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('로또 6/45 제 '),
                  DropdownButton<String>(
                    value: gameRound.gameRound,
                    items: gameRoundList
                        .map((gameRound) => DropdownMenuItem<String>(child: Text(gameRound), value: gameRound))
                        .toList(),
                    onChanged: (String? selectedGameRound) {
                      gameRound.updateGameRound(selectedGameRound!);
                    },
                  ),
                  const Text(' 회차'),
                ],
              ),
              //TODO: 미추첨 복권일 경우 추첨시간 표시
              const Text('2021-10-23 20:45 추첨')
            ],
          ),
        );
      },
    );
  }
}
