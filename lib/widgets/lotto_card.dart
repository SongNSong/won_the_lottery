import 'package:flutter/material.dart';
import 'package:won_the_lottery/models/lotto_sheet.dart';

class LottoCard extends StatelessWidget {
  String gameRound;
  String sellerCode;
  List<dynamic> lottoSets;
  // final LottoSheet lottoSheet;

  LottoCard({required this.gameRound, required this.sellerCode, required this.lottoSets});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(gameRound),
              Text(sellerCode),
            ],
          ),
          Text(lottoSets.toString()),
        ],
      )
    );
  }
}
