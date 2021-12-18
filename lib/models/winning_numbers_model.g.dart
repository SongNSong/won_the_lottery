// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'winning_numbers_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WinningNumbersModelAdapter extends TypeAdapter<WinningNumbersModel> {
  @override
  final int typeId = 3;

  @override
  WinningNumbersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WinningNumbersModel(
      numbers: (fields[0] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, WinningNumbersModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.numbers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WinningNumbersModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
