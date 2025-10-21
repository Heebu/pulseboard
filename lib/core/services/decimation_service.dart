import '../models/biometrics_model.dart';

/// Data decimation / downsampling service.
/// Ensures charts remain performant even with 10k+ data points.
class DecimationService {
  /// Applies downsampling to keep datasets lightweight.
  /// [threshold] defines the maximum number of points to retain.
  List<double> decimate(List<double> data, int maxPoints) {
    if (data.length <= maxPoints) return data;

    final ratio = data.length / maxPoints;
    final List<double> result = [];

    for (int i = 0; i < maxPoints; i++) {
      final start = (i * ratio).floor();
      final end = ((i + 1) * ratio).floor();
      if (start >= data.length) break;

      final segment = data.sublist(start, end.clamp(start + 1, data.length));
      final avg = segment.reduce((a, b) => a + b) / segment.length;
      result.add(avg);
    }

    return result;
  }

  /// Implements the LTTB (Largest-Triangle-Three-Buckets) algorithm.
  /// Preserves visual trends while reducing dataset size.
  List<BiometricsModel> _largestTriangleThreeBuckets(
      List<BiometricsModel> data,
      int threshold,
      ) {
    final int dataLength = data.length;
    if (threshold >= dataLength || threshold == 0) return data;

    final List<BiometricsModel> sampled = [];

    final double bucketSize = (dataLength - 2) / (threshold - 2);
    int a = 0;
    sampled.add(data[a]);

    for (int i = 0; i < threshold - 2; i++) {
      int rangeStart = (1 + i * bucketSize).floor();
      int rangeEnd = (1 + (i + 1) * bucketSize).floor();
      rangeEnd = rangeEnd < dataLength ? rangeEnd : dataLength;

      double avgX = 0, avgY = 0;
      final rangeLength = rangeEnd - rangeStart;

      for (int j = rangeStart; j < rangeEnd; j++) {
        avgX += j;
        avgY += data[j].hrv!;
      }

      avgX /= rangeLength;
      avgY /= rangeLength;

      double maxArea = -1;
      int nextA = rangeStart;

      for (int j = rangeStart; j < rangeEnd; j++) {
        double area = (a - avgX) * (data[a].hrv! - avgY) -
            (a - j) * (data[a].hrv! - data[j].hrv!);
        if (area.abs() > maxArea) {
          maxArea = area.abs();
          nextA = j;
        }
      }

      sampled.add(data[nextA]);
      a = nextA;
    }

    sampled.add(data[dataLength - 1]);
    return sampled;
  }

  /// Alternative: Simple bucket mean method (faster but less accurate)
  List<BiometricsModel> bucketMean(
      List<BiometricsModel> data, {
        int bucketSize = 20,
      }) {
    final List<BiometricsModel> reduced = [];
    for (int i = 0; i < data.length; i += bucketSize) {
      final slice = data.skip(i).take(bucketSize).toList();
      final avgHrv = slice.map((e) => e.hrv).reduce((a, b) => a! + b!)! / slice.length;
      final avgRhr = slice.map((e) => e.rhr).reduce((a, b) => a! + b!)! / slice.length;
      final avgSteps = slice.map((e) => e.steps).reduce((a, b) => a! + b!)! / slice.length;
      reduced.add(BiometricsModel(
        date: slice.first.date,
        hrv: avgHrv,
        rhr: avgRhr.round(),
        steps: avgSteps.toInt(),
        sleepScore: slice.first.sleepScore,
      ));
    }
    return reduced;
  }
}
