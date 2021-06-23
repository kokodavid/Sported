// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VenueAdapter extends TypeAdapter<Venue> {
  @override
  final int typeId = 0;

  @override
  Venue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Venue(
      venueName: fields[0] as String,
      timeOpen: fields[1] as String,
      timeClosed: fields[2] as String,
      totalDaysOpen: fields[3] as int,
      description: fields[4] as String,
      rules: (fields[5] as List)?.cast<String>(),
      images: (fields[6] as List)?.cast<String>(),
      sportsOfferedList: (fields[7] as List)?.cast<String>(),
      sportsOffered: (fields[8] as List)?.cast<SportsOffered>(),
    );
  }

  @override
  void write(BinaryWriter writer, Venue obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.venueName)
      ..writeByte(1)
      ..write(obj.timeOpen)
      ..writeByte(2)
      ..write(obj.timeClosed)
      ..writeByte(3)
      ..write(obj.totalDaysOpen)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.rules)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.sportsOfferedList)
      ..writeByte(8)
      ..write(obj.sportsOffered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VenueAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class SportsOfferedAdapter extends TypeAdapter<SportsOffered> {
  @override
  final int typeId = 1;

  @override
  SportsOffered read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SportsOffered(
      sportName: fields[0] as String,
      ratesPerHr: fields[1] as int,
      memberRatesPerHr: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SportsOffered obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sportName)
      ..writeByte(1)
      ..write(obj.ratesPerHr)
      ..writeByte(2)
      ..write(obj.memberRatesPerHr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SportsOfferedAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
