// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotto_sheets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LottoSheetsAdapter extends TypeAdapter<LottoSheets> {
  @override
  final int typeId = 1;

  @override
  LottoSheets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LottoSheets(
      gameRound: fields[0] as String,
      lottoSheets: (fields[1] as List).cast<LottoSheet>(),
    );
  }

  @override
  void write(BinaryWriter writer, LottoSheets obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.gameRound)
      ..writeByte(1)
      ..write(obj.lottoSheets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LottoSheetsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
