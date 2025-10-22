import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../../core/services/chart_service.dart';


class ChartDetailViewModel extends BaseViewModel {
  final String chartType;
  final _chartService = ChartService();

  List<Map<String, dynamic>> chartData = [];
  int currentRange = 7;

  ChartDetailViewModel(this.chartType);

  @override
  void onFutureError(error, Object? key) {
    setError(error);
  }

  @override
  Future<void> onReady() async {
    await loadChartData();
  }

  Future<void> loadChartData() async {
    setBusy(true);
    try {
      chartData = await _chartService.getChartData(chartType);
    } finally {
      setBusy(false);
    }
  }

  void setRange(int days) {
    currentRange = days;
    loadChartData();
  }

  Widget buildChart() {
    // Placeholder for chart widget
    return Center(child: Text("Chart for $chartType ($currentRange days)"));
  }
}
