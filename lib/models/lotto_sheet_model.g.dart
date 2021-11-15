// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotto_sheet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LottoSheetModelAdapter extends TypeAdapter<LottoSheetModel> {
  @override
  final int typeId = 1;

  @override
  LottoSheetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LottoSheetModel(
      gameRound: fields[0] as String,
      sellerCode: fields[1] as String,
      gameSet: (fields[2] as List).cast<GameModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LottoSheetModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gameRound)
      ..writeByte(1)
      ..write(obj.sellerCode)
      ..writeByte(2)
      ..write(obj.gameSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LottoSheetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
