import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('OKLCHColor tests based on website', () {
    /// Red color
    /// https://oklch.com/#62.795536061455145,0.25768330773615683,29.2338851923426,100
    test('Converts OKLCH to RGB red', () {
      // Test case 1
      final result1 = OKLCHColor.fromOKLCH(
        62.795536061455145,
        0.25768330773615683,
        29.2338851923426,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#ff0000'));
    });

    /// https://oklch.com/#86.64396115356693,0.2948272403370167,142.49533888780996,100
    /// Green color
    test('Converts OKLCH to RGB blue', () {
      // Test case 2
      final result1 = OKLCHColor.fromOKLCH(
        86.64396115356693,
        0.2948272403370167,
        142.49533888780996,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#00ff00'));
    });

    /// https://oklch.com/#45.201371838534286,0.31321437166460125,264.052020638055,100
    /// Blue color
    test('Converts OKLCH to RGB blue', () {
      // Test case 3
      final result1 = OKLCHColor.fromOKLCH(
        45.201371838534286,
        0.31321437166460125,
        264.052020638055,
        100,
      );
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#0000ff'));
    });

    /// https://oklch.com/#70,0.1,160,100
    /// Light green color
    test('Converts OKLCH to RGB light green', () {
      // Test case 4
      final result1 = OKLCHColor.fromOKLCH(70, 0.1, 160, 100);
      final hex = result1.rgbHex;

      // Verify with the expected value
      expect(hex, equals('#62b289'));
    });
  });

  /// https://oklch.com/#100,0,0,100
  /// White color
  test('Converts OKLCH to RGB white', () {
    // Test case 5
    final result1 = OKLCHColor.fromOKLCH(100, 0, 0, 100);
    final hex = result1.rgbHex;

    // Verify with the expected value
    expect(hex, equals('#ffffff'));
  });

  /// https://oklch.com/#48.98,0,0,100
  /// Grey color
  test('Converts OKLCH to RGB grey', () {
    // Test case 6
    final result1 = OKLCHColor.fromOKLCH(48.98, 0, 0, 100);
    final hex = result1.rgbHex;

    // Verify with the expected value
    expect(hex, equals('#606060'));
  });
}
