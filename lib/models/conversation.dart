import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  final int id;
  final dynamic email;
  final dynamic coach_id;
  final dynamic coach;
  final dynamic comment;
  final dynamic conversation_date;
  final dynamic status;
  final DateTime create_date;

  Conversation(
    this.id,
    this.email,
    this.coach_id,
    this.coach,
    this.comment,
    this.conversation_date,
    this.status,
    this.create_date,
  );

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
