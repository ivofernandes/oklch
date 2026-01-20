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
