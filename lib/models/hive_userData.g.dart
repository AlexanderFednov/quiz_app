// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_userData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 0;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      userName: fields[0] as String,
      userResult: fields[1] as int,
      userId: fields[2] as int,
      isCurrentUser: fields[3] as bool,
      registerDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.userResult)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.isCurrentUser)
      ..writeByte(4)
      ..write(obj.registerDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
