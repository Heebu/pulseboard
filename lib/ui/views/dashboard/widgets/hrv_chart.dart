import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/biometrics_model.dart';
import '../../../common/widgets/cart_sync_controller.dart';

class HRVChart extends StatelessWidget {
  final List<BiometricsModel> data;
  final ChartSyncController syncController;
  final Color color;

  const HRVChart({
    super.key,
    required this.data,
    required this.syncController,
    required this.color, required syncContricler,
  });

  @override
  Widget build(BuildContext context) {
    final spots = data
        .where((e) => e.hrv != null)
        .map((e) => FlSpot(
        e.date.millisecondsSinceEpoch.toDouble(),
        e.hrv!.toDouble()))
        .toList();

    return LineChart(
      LineChartData(
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchCallback: (event, response) {
            if (event.isInterestedForInteractions &&
                response != null &&
                response.lineBarSpots != null) {
              final date = DateTime.fromMillisecondsSinceEpoch(
                  response.lineBarSpots!.first.x.toInt());
              syncController.setHoverDate(date);
            }
          },
        ),
      ),
    );
  }
}
