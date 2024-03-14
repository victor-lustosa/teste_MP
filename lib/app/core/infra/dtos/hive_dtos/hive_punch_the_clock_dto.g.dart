// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_punch_the_clock_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePunchTheClockDTOAdapter extends TypeAdapter<HivePunchTheClockDTO> {
  @override
  final int typeId = 1;

  @override
  HivePunchTheClockDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePunchTheClockDTO(
      user: fields[1] as HiveUserDTO,
      id: fields[0] as String,
      time: fields[2] as String,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HivePunchTheClockDTO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePunchTheClockDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
