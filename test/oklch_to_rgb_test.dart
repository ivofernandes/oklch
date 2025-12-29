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

  test('Converts OKLCH to RGB for additional OKLCH.com samples', () {
    final samples = <({
      String name,
      double lightness,
      double chroma,
      double hue,
      String expectedHex,
      String url,
    })>[
      (
        name: 'deep pink',
        lightness: 65.49349935138736,
        chroma: 0.26133649638412065,
        hue: 356.9447697294126,
        expectedHex: '#ff1493',
        url:
            'https://oklch.com/#65.49349935138736,0.26133649638412065,356.9447697294126,100',
      ),
      (
        name: 'steel blue',
        lightness: 58.80009077665625,
        chroma: 0.09933884428113002,
        hue: 245.73941223940804,
        expectedHex: '#4682b4',
        url:
            'https://oklch.com/#58.80009077665625,0.09933884428113002,245.73941223940804,100',
      ),
      (
        name: 'gold',
        lightness: 88.67710734392976,
        chroma: 0.1821860427566396,
        hue: 95.3304934870249,
        expectedHex: '#ffd700',
        url:
            'https://oklch.com/#88.67710734392976,0.1821860427566396,95.3304934870249,100',
      ),
      (
        name: 'blue violet',
        lightness: 53.37649508522606,
        chroma: 0.2503052644516238,
        hue: 301.3749618367515,
        expectedHex: '#8a2be2',
        url:
            'https://oklch.com/#53.37649508522606,0.2503052644516238,301.3749618367515,100',
      ),
    ];

    for (final sample in samples) {
      final result = OKLCHColor.fromOKLCH(
        sample.lightness,
        sample.chroma,
        sample.hue,
      );

      expect(
        result.rgbHex,
        equals(sample.expectedHex),
        reason: sample.url,
      );
    }
  });
}
