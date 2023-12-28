import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  /// https://oklch.com/#62.795536061455145,0.25768330773615683,29.2338851923426,100
  group('OKLCHColor tests based on website', () {
    test('Converts OKLCH to RGB', () {
      // Test case 1
      OKLCHColor result1 = OKLCHColor.fromOKLCH(
          62.795536061455145, 0.25768330773615683, 29.2338851923426, 100);
      final String hex = result1.rgbHex;
      expect(hex, equals('#ff0000'));
    });
  });
}
