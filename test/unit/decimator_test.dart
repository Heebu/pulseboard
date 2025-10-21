import 'package:flutter_test/flutter_test.dart';
import 'package:pulseboard/core/models/biometrics_model.dart';
import 'package:pulseboard/core/services/decimation_service.dart';

void main() {
  test('Decimation preserves min/max and reduces dataset size', () {
    final service = DecimationService();
    final data = List.generate(
      1000,
          (i) => BiometricsModel(
        date: DateTime(2025, 1, 1).add(Duration(days: i)),
        hrv: (i % 100).toDouble(),
        rhr: (60 + i % 10),
        steps: 1000 + i * 10,
        sleepScore: 70 + (i % 5),
      ),
    );

    final reduced = service.decimate(data, threshold: 200);

    expect(reduced.length <= 200, true);
    expect(reduced.first.hrv, equals(data.first.hrv));
    expect(reduced.last.hrv, equals(data.last.hrv));
  });
}
