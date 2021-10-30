// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotto_sheets_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LottoSheetsModelAdapter extends TypeAdapter<LottoSheetsModel> {
  @override
  final int typeId = 1;

  @override
  LottoSheetsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LottoSheetsModel(
      gameRound: fields[0] as String,
      sellerCode: fields[1] as String,
      lottoSheetList: (fields[2] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, LottoSheetsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gameRound)
      ..writeByte(1)
      ..write(obj.sellerCode)
      ..writeByte(2)
      ..write(obj.lottoSheetList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LottoSheetsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
