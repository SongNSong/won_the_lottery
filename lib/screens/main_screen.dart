import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/utilities/game_round.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/widgets/lotto_round_widget.dart';
import 'package:won_the_lottery/widgets/components/lotto_card.dart';
import 'package:won_the_lottery/widgets/lotto_card_list.dart';
import 'package:won_the_lottery/widgets/winning_numbers_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<LottoSheetModel>('lottoSheet');
    // box.add(LottoSheetModel(gameRound: '111', sellerCode: '12233', gameSet: []));
    // box.add(LottoSheetModel(gameRound: '113', sellerCode: '12233', gameSet: []));
    // box.add(LottoSheetModel(gameRound: '142', sellerCode: '12233', gameSet: []));
    // box.add(LottoSheetModel(gameRound: '155', sellerCode: '12233', gameSet: []))

    return Scaffold(
      appBar: AppBar(
        title: const Text('Won the Lottery'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: box.isEmpty
            ? [const Text('QR을 입력해주세요.', textAlign: TextAlign.center,)]
            : [
                LottoRoundWidget(),
                WinningNumbersCard(),
                LottoCardList(),
              ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamedAndRemoveUntil(context, QRScannerScreen.routeName, (route) => false);
            // }
            // 1. 카메라기능 오픈
            // 2. QR 스캔 - URL 받아오기
            // 3. 번호 저장
          },
          child: const Icon(Icons.camera_alt_outlined)),
    );
  }
}
