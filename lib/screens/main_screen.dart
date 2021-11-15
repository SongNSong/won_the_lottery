import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/models/game_model.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/utilities/game_round_provider.dart';
import 'package:won_the_lottery/utilities/get_lotto_sheet.dart';
import 'package:won_the_lottery/utilities/get_winning_numbers.dart';
import 'package:won_the_lottery/widgets/lotto_round_widget.dart';
import 'package:won_the_lottery/widgets/lotto_card_list.dart';
import 'package:won_the_lottery/widgets/winning_numbers_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Box<LottoSheetModel> lottoSheetBox = Hive.box<LottoSheetModel>('lottoSheet');

  @override
  void initState() {
    super.initState();

    // getWinningNumbers('0990');
    // getWinningNumbers('0991');
    // getWinningNumbers('0992');
    // getWinningNumbers('0995');
    // getWinningNumbers('0997');

    // provider에 값 초기화를 위해 사용
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (lottoSheetBox.isNotEmpty) {
        // await lottoSheetBox.add(getLottoSheet('http://m.dhlottery.co.kr/?v=0991q101013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
        // await lottoSheetBox.add(getLottoSheet('http://m.dhlottery.co.kr/?v=0992q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
        // await lottoSheetBox.add(getLottoSheet('http://m.dhlottery.co.kr/?v=0995q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
        // await lottoSheetBox.add(getLottoSheet('http://m.dhlottery.co.kr/?v=0997q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
        Provider.of<GameRoundProvider>(context, listen: false).updateGameRound(lottoSheetBox.values.last.gameRound);
      }
    });
    // getWinningNumbers(lottoSheetBox.values.last.gameRound);
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Won the Lottery'),
      ),
      body: ValueListenableBuilder(
          valueListenable: lottoSheetBox.listenable(),
          builder: (_, Box<LottoSheetModel> lottoBox, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: lottoSheetBox.isEmpty
                  ? [
                      const Text(
                        'QR을 입력해주세요.',
                        textAlign: TextAlign.center,
                      )
                    ]
                  : [
                      const LottoRoundWidget(),
                      const WinningNumbersCard(),
                      const LottoCardList(),
                    ],
            );
          }),
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
