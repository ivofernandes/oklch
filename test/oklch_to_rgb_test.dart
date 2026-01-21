import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('OKLCHColor tests based on website', () {
    /// Red color
    /// https://oklch.com/#0.6279553606145515,0.25768330773615683,29.2338851923426,100
    test('Converts OKLCH to RGB red', () {
      // Test case 1
      final result1 = OKLCHColor.fromOKLCH(
        0.6279553606145515,
        0.25768330773615683,
        29.2338851923426,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#ff0000'));
    });

    /// https://oklch.com/#0.8664396115356694,0.2948272403370167,142.49533888780996,100
    /// Green color
    test('Converts OKLCH to RGB blue', () {
      // Test case 2
      final result1 = OKLCHColor.fromOKLCH(
        0.8664396115356694,
        0.2948272403370167,
        142.49533888780996,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#00ff00'));
    });

    /// https://oklch.com/#0.45201371838534285,0.31321437166460125,264.052020638055,100
    /// Blue color
    test('Converts OKLCH to RGB blue', () {
      // Test case 3
      final result1 = OKLCHColor.fromOKLCH(
        0.45201371838534285,
        0.31321437166460125,
        264.052020638055,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#0000ff'));
    });

    /// https://oklch.com/#0.7,0.1,160,100
    /// Light green color
    test('Converts OKLCH to RGB light green', () {
      // Test case 4
      final result1 = OKLCHColor.fromOKLCH(0.7, 0.1, 160, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#62b289'));
    });

    /// https://oklch.com/#0.7,0.1,263,100
    /// Light blue color
    test('Converts OKLCH to RGB light blue', () {
      final result1 = OKLCHColor.fromOKLCH(0.7, 0.1, 263, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#7d9edd'));
    });

    /// https://oklch.com/#0.6893,0.37,328.64,100
    /// Magenta color
    test('Converts OKLCH to RGB magenta', () {
      final result1 = OKLCHColor.fromOKLCH(0.6893, 0.37, 328.64, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#ff00ff'));
    });

    /// https://oklch.com/#0.4701,0.2998,265.9,100
    /// Vivid blue color
    test('Converts OKLCH to RGB vivid blue', () {
      final result1 = OKLCHColor.fromOKLCH(0.4701, 0.2998, 265.9, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#1720ff'));
    });

    /// https://oklch.com/#0.9592,0.2296,112.37,100
    /// Yellow color
    test('Converts OKLCH to RGB yellow', () {
      final result1 = OKLCHColor.fromOKLCH(0.9592, 0.2296, 112.37, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#f6ff00'));
    });

    /// https://oklch.com/#0.4631,0.1547,279.94,100
    /// https://oklch.com/#0.4631,0.0949,346.64,100
    /// https://oklch.com/#0.4631,0.0974,57.58,100
    /// https://oklch.com/#0.3831,0.0708,17.35,100
    /// https://oklch.com/#0.3831,0.1344,266.17,100
    /// https://oklch.com/#0.3831,0.0974,340.29,100
    /// https://oklch.com/#0.3831,0.085,141.23,100
    /// https://oklch.com/#0.6831,0.147,194.17,100
    /// https://oklch.com/#0.6831,0.2503,310.64,100
    /// https://oklch.com/#0.6831,0.1714,35.35,100
    /// https://oklch.com/#0.6831,0.2306,0,100
    /// https://oklch.com/#0.6964,0.2306,139.11,100
    test('Converts OKLCH to RGB for additional colors', () {
      final cases = <({double l, double c, double h, String hex})>[
        (l: 0.4631, c: 0.1547, h: 279.94, hex: '#4c48ac'),
        (l: 0.4631, c: 0.0949, h: 346.64, hex: '#7e4163'),
        (l: 0.4631, c: 0.0974, h: 57.58, hex: '#814918'),
        (l: 0.3831, c: 0.0708, h: 17.35, hex: '#643235'),
        (l: 0.3831, c: 0.1344, h: 266.17, hex: '#213b8a'),
        (l: 0.3831, c: 0.0974, h: 340.29, hex: '#642b53'),
        (l: 0.3831, c: 0.085, h: 141.23, hex: '#274e21'),
        (l: 0.6831, c: 0.1714, h: 35.35, hex: '#ef6b49'),
        (l: 0.6831, c: 0.2306, h: 0, hex: '#ff4493'),
        (l: 0.6964, c: 0.2306, h: 139.11, hex: '#3bbc00'),
      ];

      for (final colorCase in cases) {
        final result = OKLCHColor.fromOKLCH(
          colorCase.l,
          colorCase.c,
          colorCase.h,
          100,
        );

        expect(result.rgbHex, equals(colorCase.hex));
      }
    });
  });

  /// https://oklch.com/#1,0,0,100
  /// White color
  test('Converts OKLCH to RGB white', () {
    // Test case 5
    final result1 = OKLCHColor.fromOKLCH(1, 0, 0, 100);
    final hex = result1.rgbHex;

    // Verify with the expected value
    expect(hex, equals('#ffffff'));
  });

  /// https://oklch.com/#0.4898,0,0,100
  /// Grey color
  test('Converts OKLCH to RGB grey', () {
    // Test case 6
    final result1 = OKLCHColor.fromOKLCH(0.4898, 0, 0, 100);
    final hex = result1.rgbHex;

    // Verify with the expected value
    expect(hex, equals('#606060'));
  });
}
