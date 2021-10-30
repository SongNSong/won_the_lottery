import 'package:hive/hive.dart';

part 'lotto_sheets_model.g.dart';

@HiveType(typeId: 1)
class LottoSheetsModel {
  @HiveField(0)
  final String gameRound;

  @HiveField(1)
  final String sellerCode;

  @HiveField(2)
  final List<dynamic> lottoSheetList;

  LottoSheetsModel({required this.gameRound, required this.sellerCode, required this.lottoSheetList});
}