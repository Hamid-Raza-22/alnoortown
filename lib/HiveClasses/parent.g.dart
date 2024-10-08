// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'parent.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class ParentAdapter extends TypeAdapter<Parent> {
//   @override
//   final int typeId = 0;
//
//   @override
//   Parent read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Parent(
//       name: fields[0] as String,
//       children: (fields[1] as List).cast<Child>(),
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Parent obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.children);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ParentAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
