import 'package:pulseboard/core/models/journal_model.dart';
import 'package:pulseboard/ui/views/chart_detail/chart_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class JournalViewModel extends BaseViewModel {

  List<JournalEntry> journals = [];

  void addNewJournal() {
    // For now, mock adding a new journal entry
    journals.add(
      JournalEntry(
        title: "New Entry #${journals.length + 1}",
        date: DateTime.now(),
        content: "This is a mock journal entry",
        id: DateTime.now().toString(),
        mood: '',
      ),
    );
    notifyListeners();
  }

  void navigateToJournalDetail(JournalEntry journal, context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChartDetailView(chartType: 'journal'),));
  }
}
