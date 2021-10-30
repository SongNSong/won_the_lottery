import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:won_the_lottery/models/lotto_sheet.dart';
import 'package:won_the_lottery/models/lotto_sheets_model.dart';
import 'package:won_the_lottery/screens/main_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  static const routeName = 'qrScannerScreen';

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Barcode? lottoURL;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final List<String> _keyList = ['A', 'B', 'C', 'D', 'E'];


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  LottoSheet getLottoSheet(String lottoURL) {
      List<String> lottoSets = lottoURL.split("v=")[1].split("q");
      Map<String, List<int>> lottoGames = {};
      for (int i = 1; i < lottoSets.length; i++) {
        List<int> selectedNumbers = [];
        for (int j = 0; j < 6; j++) {
          int startIndex = j * 2;
          selectedNumbers.add(int.parse(lottoSets[i].substring(startIndex, startIndex + 2)));
        }
        lottoGames.addAll({_keyList[i - 1]: selectedNumbers});
      }
      return LottoSheet(gameRound: lottoSets[0], sellerCode: lottoSets[lottoSets.length - 1].substring(12), lottoSets: lottoGames);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
          },
        ),
        title: const Text('QR Scan'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (lottoURL != null && lottoURL!.code.contains('http://m.dhlottery.co.kr/?')) //로또QR외 QR 력불가 로직 추가
                  ? Column(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              var box = Hive.box<LottoSheetsModel>('lottoSheets');

                              LottoSheet lottoSheet1 = getLottoSheet(lottoURL!.code);
                              await box.add(LottoSheetsModel(gameRound: lottoSheet1.gameRound, sellerCode: lottoSheet1.sellerCode, lottoSheetList: [lottoSheet1.lottoSets]));
                              Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                            },
                            child: const Text('등록하기')),
                      ],
                    )
                  : Text('로또 QR을 스캔해주세요.'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        lottoURL = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class LotteryURL {
  final String url;

  LotteryURL(this.url);
}
