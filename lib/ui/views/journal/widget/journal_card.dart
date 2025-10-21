import 'package:flutter/material.dart';
import '../../../../core/models/journal_model.dart';
import '../../../common/styles/colors.dart';

class JournalCard extends StatelessWidget {
  final JournalEntry entry;

  const JournalCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final moodColor = {
      'happy': AppColors.success,
      'sad': AppColors.error,
      'neutral': Colors.grey,
    }[entry.mood.toLowerCase()] ?? Colors.blueGrey;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: moodColor, radius: 6),
                const SizedBox(width: 8),
                Text(
                  entry.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  "${entry.date.day}/${entry.date.month}/${entry.date.year}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.content),
            if (entry.relatedMetric != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Linked Metric: ${entry.relatedMetric}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
