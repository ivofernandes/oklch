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
    test('Converts OKLCH to RGB for #4c48ac', () {
      final result =
          OKLCHColor.fromOKLCH(0.4631, 0.1547, 279.94, 100).rgbHex;

      expect(result, equals('#4c48ac'));
    });

    /// https://oklch.com/#0.4631,0.0949,346.64,100
    test('Converts OKLCH to RGB for #7e4163', () {
      final result =
          OKLCHColor.fromOKLCH(0.4631, 0.0949, 346.64, 100).rgbHex;

      expect(result, equals('#7e4163'));
    });

    /// https://oklch.com/#0.4631,0.0974,57.58,100
    test('Converts OKLCH to RGB for #814918', () {
      final result =
          OKLCHColor.fromOKLCH(0.4631, 0.0974, 57.58, 100).rgbHex;

      expect(result, equals('#814918'));
    });

    /// https://oklch.com/#0.3831,0.0708,17.35,100
    test('Converts OKLCH to RGB for #643235', () {
      final result =
          OKLCHColor.fromOKLCH(0.3831, 0.0708, 17.35, 100).rgbHex;

      expect(result, equals('#643235'));
    });

    /// https://oklch.com/#0.3831,0.1344,266.17,100
    test('Converts OKLCH to RGB for #213b8a', () {
      final result =
          OKLCHColor.fromOKLCH(0.3831, 0.1344, 266.17, 100).rgbHex;

      expect(result, equals('#213b8a'));
    });

    /// https://oklch.com/#0.3831,0.0974,340.29,100
    test('Converts OKLCH to RGB for #642b53', () {
      final result =
          OKLCHColor.fromOKLCH(0.3831, 0.0974, 340.29, 100).rgbHex;

      expect(result, equals('#642b53'));
    });

    /// https://oklch.com/#0.3831,0.085,141.23,100
    test('Converts OKLCH to RGB for #274e21', () {
      final result = OKLCHColor.fromOKLCH(0.3831, 0.085, 141.23, 100).rgbHex;

      expect(result, equals('#274e21'));
    });

    /// https://oklch.com/#0.6831,0.1714,35.35,100
    test('Converts OKLCH to RGB for #ef6b49', () {
      final result = OKLCHColor.fromOKLCH(0.6831, 0.1714, 35.35, 100).rgbHex;

      expect(result, equals('#ef6b49'));
    });

    /// https://oklch.com/#0.6831,0.2306,0,100
    test('Converts OKLCH to RGB for #ff4493', () {
      final result = OKLCHColor.fromOKLCH(0.6831, 0.2306, 0, 100).rgbHex;

      expect(result, equals('#ff4493'));
    });

    /// https://oklch.com/#0.6964,0.2306,139.11,100
    test('Converts OKLCH to RGB for #3bbc00', () {
      final result =
          OKLCHColor.fromOKLCH(0.6964, 0.2306, 139.11, 100).rgbHex;

      expect(result, equals('#3bbc00'));
    });

    /// https://oklch.com/#0.4768,0.236,285.78,100
    test('Converts OKLCH to RGB for #5c2dd7', () {
      final result = OKLCHColor.fromOKLCH(0.4768, 0.236, 285.78, 100).rgbHex;

      expect(result, equals('#5c2dd7'));
    });

    /// https://oklch.com/#0.7501,0.236,144.96,100
    test('Converts OKLCH to RGB for #01d23a', () {
      final result = OKLCHColor.fromOKLCH(0.7501, 0.236, 144.96, 100).rgbHex;

      expect(result, equals('#01d23a'));
    });

    /// https://oklch.com/#0.5701,0.236,348.25,100
    test('Converts OKLCH to RGB for #d0098f', () {
      final result = OKLCHColor.fromOKLCH(0.5701, 0.236, 348.25, 100).rgbHex;

      expect(result, equals('#d0098f'));
    });

    /// https://oklch.com/#0.6101,0.236,17.9,100
    test('Converts OKLCH to RGB for #ef184a', () {
      final result = OKLCHColor.fromOKLCH(0.6101, 0.236, 17.9, 100).rgbHex;

      expect(result, equals('#ef184a'));
    });

    /// https://oklch.com/#0.6101,0,17.9,100
    test('Converts OKLCH to RGB for #838383', () {
      final result = OKLCHColor.fromOKLCH(0.6101, 0, 17.9, 100).rgbHex;

      expect(result, equals('#838383'));
    });

    /// https://oklch.com/#0.2244,0,17.9,100
    test('Converts OKLCH to RGB for #1c1c1c', () {
      final result = OKLCHColor.fromOKLCH(0.2244, 0, 17.9, 100).rgbHex;

      expect(result, equals('#1c1c1c'));
    });

    /// https://oklch.com/#0,0,17.9,100
    test('Converts OKLCH to RGB for #000000', () {
      final result = OKLCHColor.fromOKLCH(0, 0, 17.9, 100).rgbHex;

      expect(result, equals('#000000'));
    });

    /// https://oklch.com/#1,0,17.9,100
    test('Converts OKLCH to RGB for #ffffff at hue 17.9', () {
      final result = OKLCHColor.fromOKLCH(1, 0, 17.9, 100).rgbHex;

      expect(result, equals('#ffffff'));
    });

    /// https://oklch.com/#0.7234,0.1529,57.07,100
    test('Converts OKLCH to RGB for #ec8934', () {
      final result = OKLCHColor.fromOKLCH(0.7234, 0.1529, 57.07, 100).rgbHex;

      expect(result, equals('#ec8934'));
    });

    /// https://oklch.com/#0.8034,0.1529,115.31,100
    test('Converts OKLCH to RGB for #bcca48', () {
      final result =
          OKLCHColor.fromOKLCH(0.8034, 0.1529, 115.31, 100).rgbHex;

      expect(result, equals('#bcca48'));
    });

    /// https://oklch.com/#0.6234,0.1529,259.31,100
    test('Converts OKLCH to RGB for #4b85e2', () {
      final result =
          OKLCHColor.fromOKLCH(0.6234, 0.1529, 259.31, 100).rgbHex;

      expect(result, equals('#4b85e2'));
    });

    /// https://oklch.com/#0.5101,0.1529,328.13,100
    test('Converts OKLCH to RGB for #933f91', () {
      final result =
          OKLCHColor.fromOKLCH(0.5101, 0.1529, 328.13, 100).rgbHex;

      expect(result, equals('#933f91'));
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
