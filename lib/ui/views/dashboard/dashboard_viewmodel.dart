import 'package:stacked/stacked.dart';
import '../../../core/models/biometrics_model.dart';
import '../../../core/models/journal_model.dart';
import '../../../core/services/data_service.dart';

enum DataState { loading, success, error, empty }

class DashboardViewModel extends BaseViewModel {
  final _dataService = DataService();

  DataState _state = DataState.loading;
  DataState get state => _state;

  List<BiometricsModel> _biometrics = [];
  List<JournalModel> _journals = [];

  List<BiometricsModel> get biometrics => _filteredBiometrics;
  List<JournalModel> get journals => _journals;

  String _selectedRange = '7d';
  String get selectedRange => _selectedRange;

  List<BiometricsModel> _filteredBiometrics = [];

  Future<void> init() async {
    _setState(DataState.loading);
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final bio = await _dataService.loadBiometrics();
      final journ = await _dataService.loadJournals();

      if (bio.isEmpty) {
        _setState(DataState.empty);
        return;
      }

      _biometrics = bio;
      _journals = journ;

      _applyRange(_selectedRange);
      _setState(DataState.success);
    } catch (e) {
      _setState(DataState.error);
    }
  }

  void retry() => init();

  void changeRange(String range) {
    _selectedRange = range;
    _applyRange(range);
    notifyListeners();
  }

  void _applyRange(String range) {
    if (_biometrics.isEmpty) return;

    final now = _biometrics.last.date;
    Duration diff;

    switch (range) {
      case '7d':
        diff = const Duration(days: 7);
        break;
      case '30d':
        diff = const Duration(days: 30);
        break;
      case '90d':
      default:
        diff = const Duration(days: 90);
        break;
    }

    _filteredBiometrics = _biometrics
        .where((e) => e.date.isAfter(now.subtract(diff)))
        .toList();
  }

  void _setState(DataState newState) {
    _state = newState;
    notifyListeners();
  }
}
