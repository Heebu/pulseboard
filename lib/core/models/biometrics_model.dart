import 'package:json_annotation/json_annotation.dart';

part 'biometrics_model.g.dart';

@JsonSerializable()
class BiometricsModel {
  final DateTime date;
  final double? hrv;
  final int? rhr;
  final int? steps;
  final int? sleepScore;

  BiometricsModel({
    required this.date,
    this.hrv,
    this.rhr,
    this.steps,
    this.sleepScore,
  });

  factory BiometricsModel.fromJson(Map<String, dynamic> json) =>
      _$BiometricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BiometricsModelToJson(this);
}
