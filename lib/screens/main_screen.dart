import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/widgets/lottery_round_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String? gameURL = Hive.box('test').get('games');
  late Map<String, dynamic> lottoSets;

  @override
  Widget build(BuildContext context) {

    // 무식하게 로또 URL 맵에 파싱.
    if(gameURL != null && gameURL!.contains('http://m.dhlottery.co.kr/?v=')){
      var numberTrim = gameURL!.split('=');
      var gameSet = numberTrim.removeAt(1).split('q');
      lottoSets = {
        'gameRound' : gameSet[0],
        'A' : [gameSet[1].substring(0,2), gameSet[1].substring(2,4), gameSet[1].substring(4,6), gameSet[1].substring(6,8), gameSet[1].substring(8,10), gameSet[1].substring(10,12)],
        'B' : [gameSet[2].substring(0,2), gameSet[2].substring(2,4), gameSet[2].substring(4,6), gameSet[2].substring(6,8), gameSet[2].substring(8,10), gameSet[2].substring(10,12)],
        'C' : [gameSet[3].substring(0,2), gameSet[3].substring(2,4), gameSet[3].substring(4,6), gameSet[3].substring(6,8), gameSet[3].substring(8,10), gameSet[3].substring(10,12)],
        'D' : [gameSet[4].substring(0,2), gameSet[4].substring(2,4), gameSet[4].substring(4,6), gameSet[4].substring(6,8), gameSet[4].substring(8,10), gameSet[4].substring(10,12)],
        'E' : [gameSet[5].substring(0,2), gameSet[5].substring(2,4), gameSet[5].substring(4,6), gameSet[5].substring(6,8), gameSet[5].substring(8,10), gameSet[5].substring(10,12)],
        '판매처코드' : gameSet[5].substring(12),
      };
    }


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
          Text(gameURL != null ? lottoSets.toString() : '로또번호를 등록해주세요.'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await Permission.storage.request().isGranted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, QRScannerScreen.routeName, (route) => false);
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
