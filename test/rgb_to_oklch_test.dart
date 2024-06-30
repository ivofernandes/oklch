import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('RGB to OKLCH conversion tests', () {
    /// Red color
    test('Converts RGB to OKLCH for red', () {
      // Test case 1
      print('Test for RGB red color');
      final OKLCHColor result = OKLCHColor.fromColor(const Color(0xffff0000));

      // Verify with the expected value
      expect(result.lightness, closeTo(62.795536061455145, 0.001));
      expect(result.chroma, closeTo(0.25768330773615683, 0.001));
      expect(result.hue, closeTo(29.2338851923426, 0.001));
    });

    /// Green color
    test('Converts RGB to OKLCH for green', () {
      // Test case 2
      print('Test for RGB green color');
      final OKLCHColor result = OKLCHColor.fromColor(const Color(0xff00ff00));

      // Verify with the expected value
      expect(result.lightness, closeTo(86.64396115356693, 0.001));
      expect(result.chroma, closeTo(0.2948272403370167, 0.001));
      expect(result.hue, closeTo(142.49533888780996, 0.001));
    });

    /// Blue color
    test('Converts RGB to OKLCH for blue', () {
      // Test case 3
      print('Test for RGB blue color');
      final OKLCHColor result = OKLCHColor.fromColor(const Color(0xff0000ff));

      // Verify with the expected value
      expect(result.lightness, closeTo(45.201371838534286, 0.001));
      expect(result.chroma, closeTo(0.31321437166460125, 0.001));
      expect(result.hue, closeTo(264.052020638055, 0.001));
    });

    /// Light green color
    /// https://oklch.com/#70,0.1,160,100
    test('Converts RGB to OKLCH for light green', () {
      // Test case 4
      print('Test for RGB light green color');
      final OKLCHColor result = OKLCHColor.fromColor(const Color(0xff62b289));

      // Verify with the expected value
      //expect(result.lightness, closeTo(70, 0.001));
      //expect(result.chroma, closeTo(0.1, 0.001));
      //expect(result.hue, closeTo(160, 0.001));
    });

    /// White color
    /// https://oklch.com/#100,0,0,100
    test('Converts RGB to OKLCH for white', () {
      // Test case 5
      print('Test for RGB white color');
      final OKLCHColor result = OKLCHColor.fromColor(const Color(0xffffffff));

      // Verify with the expected value
      //expect(result.lightness, closeTo(100, 0.001));
      //expect(result.chroma, closeTo(0, 0.001));
      //expect(result.hue, closeTo(0, 0.001));
    });
  });
}
