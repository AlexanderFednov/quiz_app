// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Category.generalQuestions;
      case 1:
        return Category.moviesOfUSSSR;
      case 2:
        return Category.space;
      case 3:
        return Category.sector13;
      default:
        return Category.generalQuestions;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
      case Category.generalQuestions:
        writer.writeByte(0);
        break;
      case Category.moviesOfUSSSR:
        writer.writeByte(1);
        break;
      case Category.space:
        writer.writeByte(2);
        break;
      case Category.sector13:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      userName: fields[0] as String?,
      userResult: fields[1] as int?,
      isCurrentUser: fields[2] as bool?,
      registerDate: fields[3] as DateTime?,
      userResults: (fields[4] as List?)?.cast<UserResult>(),
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
      ..write(obj.isCurrentUser)
      ..writeByte(3)
      ..write(obj.registerDate)
      ..writeByte(4)
      ..write(obj.userResults);
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

class UserResultAdapter extends TypeAdapter<UserResult> {
  @override
  final int typeId = 1;

  @override
  UserResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResult(
      score: fields[0] as int?,
      questionsLenght: fields[1] as int?,
      resultDate: fields[2] as DateTime?,
      category: fields[3] as Category?,
    );
  }

  @override
  void write(BinaryWriter writer, UserResult obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.questionsLenght)
      ..writeByte(2)
      ..write(obj.resultDate)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
