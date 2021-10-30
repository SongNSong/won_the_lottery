import 'package:flutter/material.dart';
import 'package:won_the_lottery/models/lotto_sheets_model.dart';
import 'package:won_the_lottery/screens/main_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:won_the_lottery/screens/qr_scanner_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LottoSheetsModelAdapter());
  await Hive.openBox<LottoSheetsModel>('lottoSheets');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          QRScannerScreen.routeName: (context) => const QRScannerScreen(),
        });
  }
}
