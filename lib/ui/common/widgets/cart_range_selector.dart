import 'package:flutter/material.dart';

class ChartRangeSelector extends StatelessWidget {
  final String selectedRange;
  final ValueChanged<String> onRangeChanged;

  const ChartRangeSelector({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ranges = ['7d', '30d', '90d'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ranges.map((r) {
        final isSelected = r == selectedRange;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text(r),
            selected: isSelected,
            onSelected: (_) => onRangeChanged(r),
          ),
        );
      }).toList(),
    );
  }
}
