import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/providers/game_round_provider.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/widgets/components/lotto_card.dart';

class LottoCardList extends StatelessWidget {
  const LottoCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<LottoSheetModel>('lottoSheet').listenable(),
        builder: (context, Box<LottoSheetModel> lottoBox, child) {
          // 회차 필터
          List<LottoSheetModel>? filteredLottoBox =
          lottoBox.values.where((lottoSheet) => lottoSheet.gameRound == Provider.of<GameRoundProvider>(context).gameRound).toList();

          return ListView.separated(
              itemBuilder: (_, index) {
                final LottoSheetModel? item = filteredLottoBox[index];

                if (item != null) {
                  return LottoCard(index: index, lottoSheet: item);
                } else {
                  return const Text('QR을 등록해주세요.');
                }
              },
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: filteredLottoBox.length);
        },
      ),
    );
  }
}
