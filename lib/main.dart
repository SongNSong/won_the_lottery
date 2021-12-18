import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:won_the_lottery/models/game_model.dart';
import 'package:won_the_lottery/models/winning_numbers_model.dart';
import 'package:won_the_lottery/providers/game_round_provider.dart';
import 'package:won_the_lottery/models/lotto_sheet_model.dart';
import 'package:won_the_lottery/screens/main_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';
import 'package:won_the_lottery/screens/settings_screen.dart';
import 'package:won_the_lottery/utilities/get_lotto_sheet.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  _initNotiSetting();

  await Hive.initFlutter();
  Hive.registerAdapter(GameModelAdapter());
  Hive.registerAdapter(LottoSheetModelAdapter());
  Hive.registerAdapter(WinningNumbersModelAdapter());
  await Hive.openBox<GameModel>('game');
  Box lottoSheetBox = await Hive.openBox<LottoSheetModel>('lottoSheet');
  await Hive.openBox<WinningNumbersModel>('winningNumbers');

  // Hive.box<LottoSheetModel>('lottoSheet').clear();

  await lottoSheetBox.clear();
  await lottoSheetBox.add(getLottoSheet(
      'http://m.dhlottery.co.kr/?v=0990q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
  await lottoSheetBox.add(getLottoSheet(
      'http://m.dhlottery.co.kr/?v=0980q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));
  await lottoSheetBox.add(getLottoSheet(
      'http://m.dhlottery.co.kr/?v=1000q091013293538q031216202242q151624404445q051719213234q0205142938391459131397'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GameRoundProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          QRScannerScreen.routeName: (context) => const QRScannerScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

void _initNotiSetting() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  final initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
}
