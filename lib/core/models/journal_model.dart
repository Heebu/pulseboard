import 'package:json_annotation/json_annotation.dart';

part 'journal_model.g.dart';

@JsonSerializable()
class JournalModel {
  final DateTime date;
  final int mood;
  final String? note;

  JournalModel({
    required this.date,
    required this.mood,
    this.note,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) =>
      _$JournalModelFromJson(json);

  Map<String, dynamic> toJson() => _$JournalModelToJson(this);
}
