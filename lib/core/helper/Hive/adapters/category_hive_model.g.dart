// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<CategoryHiveModel> {
  @override
  final int typeId = 0;

  @override
  CategoryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryHiveModel(
      id: fields[1] as int,
      title: fields[2] as String,
      description: fields[3] as String,
      image: fields[4] as String,
      status: fields[5] as int,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
