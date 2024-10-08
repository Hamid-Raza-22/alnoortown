// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'child.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class ChildAdapter extends TypeAdapter<Child> {
//   @override
//   final int typeId = 1;
//
//   @override
//   Child read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Child(
//       name: fields[0] as String,
//       age: fields[1] as int,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Child obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.age);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ChildAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
