import 'package:json_annotation/json_annotation.dart';

part 'happiness.g.dart';

@JsonSerializable()
class Happiness {
  final int id;

  @JsonKey(fromJson: _boolFromString)
  final String note;

  final double happiness;
  final bool allowed_read;
  final DateTime create_date;

  Happiness(
    this.id,
    this.note,
    this.happiness,
    this.allowed_read,
    this.create_date,
  );

  static String _boolFromString(dynamic val) => val == false ? "" : val;

  factory Happiness.fromJson(Map<String, dynamic> json) =>
      _$HappinessFromJson(json);

  Map<String, dynamic> toJson() => _$HappinessToJson(this);
}
