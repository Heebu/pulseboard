import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'chart_detail_viewmodel.dart';

class ChartDetailView extends StatelessWidget {
  final String chartType;
  const ChartDetailView({super.key, required this.chartType});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChartDetailViewModel>.reactive(
      viewModelBuilder: () => ChartDetailViewModel(chartType),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("$chartType Details"),
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.chartData.isEmpty
              ? const Center(child: Text("No data available"))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(child: model.buildChart()),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => model.setRange(7),
                      child: const Text("7d"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => model.setRange(30),
                      child: const Text("30d"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => model.setRange(90),
                      child: const Text("90d"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
