import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/biometrics_model.dart';
import '../models/journal_model.dart';

class DataService {
  final Random _random = Random();

  /// Simulate latency (700–1200ms) and ~10% random failure
  Future<T> _simulateNetwork<T>(Future<T> Function() action) async {
    final delay = Duration(milliseconds: 700 + _random.nextInt(500));
    await Future.delayed(delay);

    if (_random.nextInt(100) < 10) {
      throw Exception("Simulated network failure");
    }

    return await action();
  }

  /// Load biometrics data from assets
  Future<List<BiometricsModel>> loadBiometrics() async {
    return _simulateNetwork(() async {
      final data = await rootBundle.loadString('assets/data/biometrics_90d.json');
      final List<dynamic> jsonList = jsonDecode(data);

      return jsonList
          .map((e) => BiometricsModel.fromJson(e))
          .where((b) =>
      b.hrv != null && b.rhr != null && b.steps != null)
          .toList();
    });
  }

  /// Load journal data from assets
  Future<List<JournalModel>> loadJournals() async {
    return _simulateNetwork(() async {
      final data = await rootBundle.loadString('assets/data/journals.json');
      final List<dynamic> jsonList = jsonDecode(data);

      return jsonList.map((e) => JournalModel.fromJson(e)).toList();
    });
  }
}
