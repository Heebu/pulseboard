import 'package:flutter/material.dart';
import 'package:pulseboard/ui/views/journal/widget/journal_card.dart';
import 'package:stacked/stacked.dart';
import '../../common/widgets/loading_view.dart';
import 'journal_viewmodel.dart';


class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JournalViewModel>.reactive(
      viewModelBuilder: () => JournalViewModel(),
      onViewModelReady: (vm) => vm.loadJournals(),
      builder: (context, vm, child) {
        if (vm.isLoading) return const LoadingSkeleton();

        return Scaffold(
          appBar: AppBar(title: const Text('Journal Entries')),
          body: vm.entries.isEmpty
              ? const Center(child: Text('No journal entries found.'))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.entries.length,
            itemBuilder: (context, index) {
              final entry = vm.entries[index];
              return JournalCard(entry: entry);
            },
          ),
        );
      },
    );
  }
}
