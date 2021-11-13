import 'package:hive/hive.dart';

part 'winning_numbers_model.g.dart';

@HiveType(typeId: 3)
class WinningNumbersModel extends HiveObject {
  @HiveField(0)
  List<int> numbers;

  WinningNumbersModel({required this.numbers});
}
