import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('RGB to OKLCH conversion tests', () {
    /// Red color
    test('Converts RGB to OKLCH for red', () {
      // Test case 1
      const red = Color(0xffff0000);
      final result = OKLCHColor.fromColor(red);

      // Verify with the expected value
      expect(result.lightness, closeTo(62.795536061455145, 0.001));
      expect(result.chroma, closeTo(0.25768330773615683, 0.001));
      expect(result.hue, closeTo(29.2338851923426, 0.001));
    });

    /// Green color
    test('Converts RGB to OKLCH for green', () {
      // Test case 2
      final result = OKLCHColor.fromColor(const Color(0xff00ff00));

      // Verify with the expected value
      expect(result.lightness, closeTo(86.64396115356693, 0.001));
      expect(result.chroma, closeTo(0.2948272403370167, 0.001));
      expect(result.hue, closeTo(142.49533888780996, 0.001));
    });

    /// Blue color
    test('Converts RGB to OKLCH for blue', () {
      // Test case 3
      final result = OKLCHColor.fromColor(const Color(0xff0000ff));

      // Verify with the expected value
      expect(result.lightness, closeTo(45.201371838534286, 0.001));
      expect(result.chroma, closeTo(0.31321437166460125, 0.001));
      expect(result.hue, closeTo(264.052020638055, 0.001));
    });

    /// Light green color
    /// https://oklch.com/#70,0.1,160,100
    test('Converts RGB to OKLCH for light green', () {
      // Test case 4
      final result = OKLCHColor.fromColor(const Color(0xff62b289));

      // Verify with the expected value
      expect(result.lightness, closeTo(70.08459661776736, 0.001));
      expect(result.chroma, closeTo(0.1, 0.001));
      expect(result.hue, closeTo(159.9277544974, 0.001));
    });

    /// White color
    /// https://oklch.com/#100,0,0,100
    test('Converts RGB to OKLCH for white', () {
      // Test case 5
      final result = OKLCHColor.fromColor(const Color(0xffffffff));

      // Verify with the expected value
      expect(result.lightness, closeTo(100, 0.001));
      expect(result.chroma, closeTo(0, 0.001));
      expect(result.hue, closeTo(0, 0.001));
    });

    test('Matches additional OKLCH.com samples', () {
      final samples = <({
        String name,
        Color color,
        double lightness,
        double chroma,
        double hue,
        String url,
      })>[
        (
          name: 'deep pink',
          color: const Color(0xffff1493),
          lightness: 65.49349935138736,
          chroma: 0.26133649638412065,
          hue: 356.9447697294126,
          url:
              'https://oklch.com/#65.49349935138736,0.26133649638412065,356.9447697294126,100',
        ),
        (
          name: 'steel blue',
          color: const Color(0xff4682b4),
          lightness: 58.80009077665625,
          chroma: 0.09933884428113002,
          hue: 245.73941223940804,
          url:
              'https://oklch.com/#58.80009077665625,0.09933884428113002,245.73941223940804,100',
        ),
        (
          name: 'gold',
          color: const Color(0xffffd700),
          lightness: 88.67710734392976,
          chroma: 0.1821860427566396,
          hue: 95.3304934870249,
          url:
              'https://oklch.com/#88.67710734392976,0.1821860427566396,95.3304934870249,100',
        ),
        (
          name: 'blue violet',
          color: const Color(0xff8a2be2),
          lightness: 53.37649508522606,
          chroma: 0.2503052644516238,
          hue: 301.3749618367515,
          url:
              'https://oklch.com/#53.37649508522606,0.2503052644516238,301.3749618367515,100',
        ),
      ];

      for (final sample in samples) {
        final result = OKLCHColor.fromColor(sample.color);

        expect(
          result.lightness,
          closeTo(sample.lightness, 0.001),
          reason: sample.url,
        );
        expect(
          result.chroma,
          closeTo(sample.chroma, 0.001),
          reason: sample.url,
        );
        expect(
          result.hue,
          closeTo(sample.hue, 0.001),
          reason: sample.url,
        );
      }
    });
  });
}
