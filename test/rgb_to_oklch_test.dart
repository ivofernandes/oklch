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
      expect(result.lightness, closeTo(0.6279553606145515, 0.001));
      expect(result.chroma, closeTo(0.25768330773615683, 0.001));
      expect(result.hue, closeTo(29.2338851923426, 0.001));
    });

    /// Green color
    test('Converts RGB to OKLCH for green', () {
      // Test case 2
      final result = OKLCHColor.fromColor(const Color(0xff00ff00));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.8664396115356694, 0.001));
      expect(result.chroma, closeTo(0.2948272403370167, 0.001));
      expect(result.hue, closeTo(142.49533888780996, 0.001));
    });

    /// Blue color
    test('Converts RGB to OKLCH for blue', () {
      // Test case 3
      final result = OKLCHColor.fromColor(const Color(0xff0000ff));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.45201371838534285, 0.001));
      expect(result.chroma, closeTo(0.31321437166460125, 0.001));
      expect(result.hue, closeTo(264.052020638055, 0.001));
    });

    /// Light green color
    /// https://oklch.com/#0.7,0.1,160,100
    test('Converts RGB to OKLCH for light green', () {
      // Test case 4
      final result = OKLCHColor.fromColor(const Color(0xff62b289));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.7008459661776736, 0.001));
      expect(result.chroma, closeTo(0.1, 0.001));
      expect(result.hue, closeTo(159.9277544974, 0.001));
    });

    /// White color
    /// https://oklch.com/#1,0,0,100
    test('Converts RGB to OKLCH for white', () {
      // Test case 5
      final result = OKLCHColor.fromColor(const Color(0xffffffff));

      // Verify with the expected value
      expect(result.lightness, closeTo(1, 0.001));
      expect(result.chroma, closeTo(0, 0.001));
      expect(result.hue, closeTo(0, 0.001));
    });

    /// Light blue color
    /// https://oklch.com/#0.7,0.1,263,100
    test('Converts RGB to OKLCH for light blue', () {
      final result = OKLCHColor.fromColor(const Color(0xff7d9edd));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.6996, 0.001));
      expect(result.chroma, closeTo(0.1001, 0.001));
      expect(result.hue, closeTo(262.805, 0.01));
    });

    /// Magenta color
    /// https://oklch.com/#0.6893,0.37,328.64,100
    test('Converts RGB to OKLCH for magenta', () {
      final result = OKLCHColor.fromColor(const Color(0xffff00ff));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.7016738559, 0.001));
      expect(result.chroma, closeTo(0.3224909648, 0.001));
      expect(result.hue, closeTo(328.3634179, 0.01));
    });

    /// Vivid blue color
    /// https://oklch.com/#0.4701,0.2998,265.9,100
    test('Converts RGB to OKLCH for vivid blue', () {
      final result = OKLCHColor.fromColor(const Color(0xff1720ff));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.4705233263, 0.001));
      expect(result.chroma, closeTo(0.3004162614, 0.001));
      expect(result.hue, closeTo(265.8898843, 0.01));
    });

    /// Yellow color
    /// https://oklch.com/#0.9592,0.2296,112.37,100
    test('Converts RGB to OKLCH for yellow', () {
      final result = OKLCHColor.fromColor(const Color(0xfff6ff00));

      // Verify with the expected value
      expect(result.lightness, closeTo(0.9608534218, 0.001));
      expect(result.chroma, closeTo(0.2132513665, 0.001));
      expect(result.hue, closeTo(112.361437, 0.01));
    });
  });
}
