import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('OKLCHtoRGB', () {
    test('Converts OKLCH to RGB', () {
      // Test case 1
      List<int> result1 = OKLCHtoRGB.convert(70.0, 50.0, 45.0);
      expect(result1, equals([246, 144, 109]));

      // Test case 2
      List<int> result2 = OKLCHtoRGB.convert(50.0, 80.0, 120.0);
      expect(result2, equals([75, 134, 0]));

      // Add more test cases as needed
    });
  });
}
