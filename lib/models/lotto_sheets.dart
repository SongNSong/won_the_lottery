import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/lotto_sheet.dart';

part 'lotto_sheets.g.dart';


@HiveType(typeId: 1)
class LottoSheets {
  @HiveField(0)
  final String gameRound;

  @HiveField(1)
  final List<LottoSheet> lottoSheets;

  LottoSheets({required this.gameRound, required this.lottoSheets});
}