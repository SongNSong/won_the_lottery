import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:won_the_lottery/models/lotto_sheet.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/widgets/lottery_round_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _keyList = ['A', 'B', 'C', 'D', 'E'];
  final String? _gameURL = Hive.box('test').get('games');

  LottoSheet getLottoSheet() {
    List<String> gameSet = _gameURL!.split("v=")[1].split("q");
    Map<String, List<int>> lottoSets = {};
    for (int i = 1; i < gameSet.length; i++) {
      List<int> tempArr = [];
      for (int j = 0; j < 6; j++) {
        int startIndex = j * 2;
        tempArr.add(int.parse(gameSet[i].substring(startIndex, startIndex + 2)));
      }
      lottoSets.addAll({_keyList[i - 1]: tempArr});
    }
    return LottoSheet(gameRound: gameSet[0], sellerCode: gameSet[gameSet.length - 1].substring(12), lottoSets: lottoSets);
  }

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
          _gameURL != null ? Text(getLottoSheet().toString()) : Text('로또번호를 등록해주세요.'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await Permission.camera.request().isGranted) {
              Navigator.pushNamedAndRemoveUntil(context, QRScannerScreen.routeName, (route) => false);
              // Either the permission was already granted before or the user just granted it.
            } else {
              AppSettings.openAppSettings();
            }
            // 1. 카메라기능 오픈
            // 2. QR 스캔 - URL 받아오기
            // 3. 번호 저장
          },
          child: const Icon(Icons.camera_alt_outlined)),
    );
  }
}
