import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/src/oklch_color.dart';

void main() {
  group('OKLCH mix tests', () {
    test('Mix red with black at 90%', () {
      final red = OKLCHColor.fromOKLCH(
        0.6279553606145515,
        0.25768330773615683,
        29.2338851923426,
      );

      final mix = OKLCHColor.mix(red, OKLCHColor.black, 0.9);

      // Verify with the expected value
      expect(mix.lightness, closeTo(0.6279553606145515 * 0.9, 0.001));
      expect(mix.chroma, closeTo(0.25768330773615683 * 0.9, 0.001));
      expect(mix.hue, closeTo(29.2338851923426, 0.001));
    });
  });
}
