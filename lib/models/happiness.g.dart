// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'happiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Happiness _$HappinessFromJson(Map<String, dynamic> json) {
  return Happiness(
    json['id'] as int,
    Happiness._boolFromString(json['note']),
    (json['happiness'] as num).toDouble(),
    json['allowed_read'] as bool,
    DateTime.parse(json['create_date'] as String),
  );
}

Map<String, dynamic> _$HappinessToJson(Happiness instance) => <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'happiness': instance.happiness,
      'allowed_read': instance.allowed_read,
      'create_date': instance.create_date.toIso8601String(),
    };
