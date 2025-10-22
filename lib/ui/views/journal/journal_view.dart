import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'journal_viewmodel.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JournalViewModel>.reactive(
      viewModelBuilder: () => JournalViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Journal"),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: model.addNewJournal,
              ),
            ],
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.journals.isEmpty
              ? const Center(child: Text("No journal entries yet"))
              : ListView.builder(
            itemCount: model.journals.length,
            itemBuilder: (context, index) {
              final journal = model.journals[index];
              return ListTile(
                title: Text(journal.title),
                subtitle: Text(journal.date.toString()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => model.navigateToJournalDetail(journal, context),
              );
            },
          ),
        );
      },
    );
  }
}
