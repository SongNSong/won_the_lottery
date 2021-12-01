import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/admob_unit_id.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/providers/game_round_provider.dart';
import 'package:won_the_lottery/widgets/lotto_round_widget.dart';
import 'package:won_the_lottery/widgets/lotto_card_list.dart';
import 'package:won_the_lottery/widgets/winning_numbers_card.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': bannerIos,
        'android': bannerAndroid,
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

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

    // provider에 값 초기화를 위해 사용
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (lottoSheetBox.isNotEmpty) {
        Provider.of<GameRoundProvider>(context, listen: false).updateGameRound(lottoSheetBox.values.last.gameRound);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final BannerAd myBanner = BannerAd(
      adUnitId: UNIT_ID[Platform.isIOS ? 'ios' : 'android']!,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );

    myBanner.load();

    final AdWidget adWidget = AdWidget(ad: myBanner);

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
                      Container(
                        alignment: Alignment.center,
                        child: adWidget,
                        width: myBanner.size.width.toDouble(),
                        height: myBanner.size.height.toDouble(),
                      ),
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
