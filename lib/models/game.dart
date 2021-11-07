import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 2)
class Game extends HiveObject{
  @HiveField(0)
  final String code;

  @HiveField(1)
  final List<int> numbers;

  Game({required this.code, required this.numbers});
}
