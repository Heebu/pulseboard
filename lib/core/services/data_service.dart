import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/biometrics_model.dart';
import '../models/journal_model.dart';
import 'cache_service.dart';
import 'dart:math';

class DataService {
  final _cache = CacheService();

  Future<List<BiometricsModel>> fetchBiometrics() async {
    const key = 'biometrics_data';

    if (_cache.containsKey(key)) {
      final cached = _cache.getData(key);
      return (json.decode(cached) as List)
          .map((e) => BiometricsModel.fromJson(e))
          .toList();
    }

    // Simulate latency + random failure
    await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(500)));
    if (Random().nextDouble() < 0.1) throw Exception('Network error simulated.');

    final response = await rootBundle.loadString('assets/data/biometrics_90d.json');
    _cache.saveData(key, response);

    final data = json.decode(response) as List;
    return data.map((e) => BiometricsModel.fromJson(e)).toList();
  }

  Future<List<JournalEntry>> fetchJournals() async {
    const key = 'journal_data';

    if (_cache.containsKey(key)) {
      final cached = _cache.getData(key);
      return (json.decode(cached) as List)
          .map((e) => JournalEntry.fromJson(e))
          .toList();
    }

    await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(500)));
    if (Random().nextDouble() < 0.1) throw Exception('Network error simulated.');

    final response = await rootBundle.loadString('assets/data/journals.json');
    _cache.saveData(key, response);

    final data = json.decode(response) as List;
    return data.map((e) => JournalEntry.fromJson(e)).toList();
  }
}
