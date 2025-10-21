import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../../../core/models/biometrics_model.dart';
import '../../../core/models/journal_model.dart';
import '../../../core/services/decimation_service.dart';

enum DataState { loading, success, error, empty }

class DashboardViewModel extends BaseViewModel {
  DataState _state = DataState.loading;
  DataState get state => _state;

  List<BiometricsModel> _allData = [];
  List<BiometricsModel> _filteredData = [];
  List<JournalModel> _journals = [];

  String _selectedRange = '90d';
  String get selectedRange => _selectedRange;

  bool _largeDatasetMode = false;
  bool get largeDatasetMode => _largeDatasetMode;

  List<BiometricsModel> get biometrics => _filteredData;
  List<JournalModel> get journals => _journals;

  final _random = Random();

  Future<void> init() async {
    _setState(DataState.loading);

    try {
      await Future.delayed(Duration(milliseconds: 700 + _random.nextInt(500)));

      // Simulate ~10% random failure
      if (_random.nextInt(10) == 0) throw Exception('Simulated network error');

      final bioString = await rootBundle.loadString('assets/data/biometrics_90d.json');
      final journalString = await rootBundle.loadString('assets/data/journals.json');

      final List<dynamic> bioJson = json.decode(bioString);
      final List<dynamic> journalJson = json.decode(journalString);

      _allData = bioJson.map((e) => BiometricsModel.fromJson(e)).toList();
      _journals = journalJson.map((e) => JournalModel.fromJson(e)).toList();

      if (_allData.isEmpty) {
        _setState(DataState.empty);
        return;
      }

      _applyRangeFilter();
      _setState(DataState.success);
    } catch (e) {
      _setState(DataState.error);
    }
  }

  void retry() => init();

  void changeRange(String range) {
    _selectedRange = range;
    _applyRangeFilter();
    notifyListeners();
  }

  void toggleLargeDatasetMode() {
    _largeDatasetMode = !_largeDatasetMode;
    _applyRangeFilter();
    notifyListeners();
  }

  void _applyRangeFilter() {
    int days;
    switch (_selectedRange) {
      case '7d':
        days = 7;
        break;
      case '30d':
        days = 30;
        break;
      case '90d':
      default:
        days = 90;
        break;
    }

    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    _filteredData = _allData.where((d) => d.date.isAfter(cutoffDate)).toList();

    // Simulate large dataset mode
    if (_largeDatasetMode) {
      _filteredData = List.generate(
        10000,
            (i) => _filteredData[i % _filteredData.length].copyWith(
          date: DateTime.now().subtract(Duration(days: i % 365)),
        ),
      );
    }

    // Apply downsampling for large datasets
    if (_filteredData.length > 500) {
      final decimator = DecimationService();
      _filteredData = decimator.decimate(_filteredData);
    }
  }

  void _setState(DataState newState) {
    _state = newState;
    notifyListeners();
  }
}
