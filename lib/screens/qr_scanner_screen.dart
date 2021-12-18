import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:won_the_lottery/admob_unit_id.dart';
import 'package:won_the_lottery/providers/game_round_provider.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/screens/main_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:won_the_lottery/utilities/get_lotto_sheet.dart';
import 'package:won_the_lottery/utilities/get_winning_numbers.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': interstitialAdIos,
        'android': interstitialAdAndroid,
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/4411468910',
        'android': 'ca-app-pub-3940256099942544/1033173712',
      };

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
  late FToast fToast;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _loadAdRequest();
  }

  _loadAdRequest() {
    InterstitialAd.load(
      adUnitId: UNIT_ID[Platform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  _showSuccessToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("로또 저장 성공"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Box<LottoSheetModel> lottoSheetBox = Hive.box<LottoSheetModel>('lottoSheet');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
            _interstitialAd!.show();
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
                              LottoSheetModel lottoSheet = getLottoSheet(lottoURL!.code);

                              GameRoundProvider thisGameRound = GameRoundProvider();
                              thisGameRound.updateGameRound(lottoSheet.gameRound);

                              lottoSheetBox.add(lottoSheet);
                              await getWinningNumbers(lottoSheet.gameRound);
                              _showSuccessToast();

                              setState(() {
                                lottoURL = null;
                              });
                              // Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                            },
                            child: const Text('등록하기')),
                      ],
                    )
                  : const Text('로또 QR을 스캔해주세요.'),
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
        const SnackBar(content: Text('no Permission')),
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
