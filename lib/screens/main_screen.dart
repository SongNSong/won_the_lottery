import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:won_the_lottery/models/lotto_sheet.dart';
import 'package:won_the_lottery/models/lotto_sheets_model.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/widgets/lottery_round_widget.dart';
import 'package:won_the_lottery/widgets/lotto_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Won the Lottery'),
      ),
      body: Column(
        children: [
          LotteryRoundWidget(),
          Card(
              child: Column(
            children: [
              Text('미추첨 복권입니다.'),
              Text('20시 45분 추첨예정'),
            ],
          )),
          Card(
              child: Table(
            children: [
              TableRow(children: [
                Container(
                  child: Text('A'),
                ),
                Container(
                  child: Text('당첨'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                  child: Text('A'),
                ),
                Container(
                  child: Text('당첨'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                  child: Text('A'),
                ),
                Container(
                  child: Text('당첨'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                  child: Text('A'),
                ),
                Container(
                  child: Text('당첨'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                Container(
                  child: Text('A'),
                ),
                Container(
                  child: Text('당첨'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                      Container(child: Text('00')),
                    ],
                  ),
                )
              ]),
            ],
          )),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<LottoSheetsModel>('lottoSheets').listenable(),
              builder: (context, Box<LottoSheetsModel> lottoBox, child) {
                return ListView.separated(itemBuilder: (_, index) {
                  final item = lottoBox.getAt(index);

                  if(item != null) {
                    return LottoCard(
                      gameRound: item.gameRound,
                      sellerCode: item.sellerCode,
                      lottoSets: item.lottoSheetList,
                    );
                  } else {
                    return const Text('QR을 등록해주세요.');
                  }
                }, separatorBuilder: (_, index) {
                  return const SizedBox(height: 5,);
                }, itemCount: lottoBox.length);
              },
            ),
          )
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
