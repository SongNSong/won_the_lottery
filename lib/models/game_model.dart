import 'package:hive/hive.dart';

part 'game_model.g.dart';

@HiveType(typeId: 2)
class GameModel extends HiveObject {
  @HiveField(0)
  final String code;

  @HiveField(1)
  final List<int> numbers;

  GameModel({required this.code, required this.numbers});
}
