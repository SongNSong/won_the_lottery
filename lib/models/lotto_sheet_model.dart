import 'package:hive/hive.dart';
import 'package:won_the_lottery/models/game_model.dart';

part 'lotto_sheet_model.g.dart';

@HiveType(typeId: 1)
class LottoSheetModel extends HiveObject {
  @HiveField(0)
  final String gameRound;

  @HiveField(1)
  final String sellerCode;

  @HiveField(2)
  final List<GameModel> gameSet;


  LottoSheetModel({required this.gameRound, required this.sellerCode, required this.gameSet});
}
