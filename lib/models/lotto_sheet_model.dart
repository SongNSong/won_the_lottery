import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/game.dart';

part 'lotto_sheet_model.g.dart';

@HiveType(typeId: 1)
class LottoSheetModel extends HiveObject {
  @HiveField(0)
  final String gameRound;

  @HiveField(1)
  final String sellerCode;

  @HiveField(2)
  final List<Game> gameSet;

  @HiveField(3)
  List<int>? winningNumbers;

  @HiveField(4)
  final String url;

  LottoSheetModel({required this.gameRound, required this.sellerCode, required this.gameSet, this.winningNumbers, required this.url});
}