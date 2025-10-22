import 'dart:math';

class ChartService {
  final Random _random = Random();

  /// Mock method to simulate fetching chart data for a given type and range
  Future<List<Map<String, dynamic>>> getChartData(String type) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay

    switch (type) {
      case 'HRV':
        return List.generate(30, (i) => {
          'date': DateTime.now().subtract(Duration(days: i)),
          'value': (50 + i * 0.8) % 100,
        });
      case 'RHR':
        return List.generate(30, (i) => {
          'date': DateTime.now().subtract(Duration(days: i)),
          'value': (70 + i * 0.5) % 90,
        });
      case 'Steps':
        return List.generate(30, (i) => {
          'date': DateTime.now().subtract(Duration(days: i)),
          'value': (5000 + (i * 150)) % 12000,
        });
      default:
        return [];
    }
  }

  /// Mock value generation based on chart type
  double _generateMockValue(String chartType) {
    switch (chartType.toLowerCase()) {
      case 'hrv':
        return 40 + _random.nextDouble() * 60; // HRV range 40–100
      case 'rhr':
        return 55 + _random.nextDouble() * 15; // RHR range 55–70
      case 'steps':
        return 2000 + _random.nextDouble() * 8000; // Steps 2000–10000
      default:
        return _random.nextDouble() * 100;
    }
  }

  /// Optional: handle decimation (reduce large data for performance)
  List<Map<String, dynamic>> decimate(List<Map<String, dynamic>> data, int targetLength) {
    if (data.length <= targetLength) return data;
    final ratio = data.length ~/ targetLength;
    return [
      for (int i = 0; i < data.length; i += ratio)
        data[i],
    ];
  }
}

