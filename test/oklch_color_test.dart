import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/src/oklch_color.dart';

void main() {
  group('OKLCHColor.copyWith', () {
    test('returns a new instance with replaced values', () {
      const color = OKLCHColor(0.5, 0.1, 200, 0.6);

      final result = color.copyWith(
        lightness: 0.7,
        chroma: 0.2,
        hue: 120,
        alpha: 0.9,
      );

      expect(result.lightness, 0.7);
      expect(result.chroma, 0.2);
      expect(result.hue, 120);
      expect(result.alpha, 0.9);
    });

    test('keeps original values when fields are omitted', () {
      const color = OKLCHColor(0.5, 0.1, 200, 0.6);

      final result = color.copyWith();

      expect(result.lightness, color.lightness);
      expect(result.chroma, color.chroma);
      expect(result.hue, color.hue);
      expect(result.alpha, color.alpha);
    });
  });
}
