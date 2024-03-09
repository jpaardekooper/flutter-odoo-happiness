// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    json['id'] as int,
    json['email'],
    json['coach_id'],
    json['coach'],
    json['comment'],
    json['conversation_date'],
    json['status'],
    DateTime.parse(json['create_date'] as String),
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'coach_id': instance.coach_id,
      'coach': instance.coach,
      'comment': instance.comment,
      'conversation_date': instance.conversation_date,
      'status': instance.status,
      'create_date': instance.create_date.toIso8601String(),
    };
