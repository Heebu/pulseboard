import 'package:stacked/stacked.dart';
import '../../../app/setup.dart';
import '../../../core/models/journal_model.dart';
import '../../../core/services/data_service.dart';

class JournalViewModel extends BaseViewModel {
  final _dataService = locator<DataService>();

  List<JournalEntry> _entries = [];
  List<JournalEntry> get entries => _entries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadJournals() async {
    _isLoading = true;
    notifyListeners();

    _entries = await _dataService.fetchJournals();

    _isLoading = false;
    notifyListeners();
  }

  List<JournalEntry> getEntriesForDate(DateTime date) {
    return _entries
        .where((e) =>
    e.date.year == date.year &&
        e.date.month == date.month &&
        e.date.day == date.day)
        .toList();
  }
}
