import 'package:flutter/material.dart';

class RangeSelector extends StatelessWidget {
  final String selectedRange;
  final Function(String) onRangeSelected;

  const RangeSelector({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  final List<String> ranges = const ['7D', '30D', '90D'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ranges.map((range) {
        final isSelected = range == selectedRange;
        return GestureDetector(
          onTap: () => onRangeSelected(range),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
                  : [],
            ),
            child: Text(
              range,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
