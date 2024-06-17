import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {

    group('OKLCHColor tests based on website', () {
      /// Red color
      /// https://oklch.com/#62.795536061455145,0.25768330773615683,29.2338851923426,100
      test('Converts OKLCH to RGB red', () {
        // Test case 1
        print('Test for red color');
        OKLCHColor result1 = OKLCHColor.fromOKLCH(
            62.795536061455145, 0.25768330773615683, 29.2338851923426, 100);
        final String hex = result1.rgbHex;

        // Verify with the expected value
        expect(hex, equals('#ff0000'));
      });

      /// https://oklch.com/#86.64396115356693,0.2948272403370167,142.49533888780996,100
      /// Green color
      test('Converts OKLCH to RGB blue', () {
        // Test case 2
        print('Test for green color');
        OKLCHColor result1 = OKLCHColor.fromOKLCH(
            86.64396115356693,0.2948272403370167,142.49533888780996, 100);
        final String hex = result1.rgbHex;

        // Verify with the expected value
        expect(hex, equals('#00ff00'));
      });

      /// https://oklch.com/#45.201371838534286,0.31321437166460125,264.052020638055,100
      /// Blue color
      test('Converts OKLCH to RGB blue', () {
        // Test case 3
        print('Test for blue color');
        OKLCHColor result1 = OKLCHColor.fromOKLCH(
            45.201371838534286, 0.31321437166460125, 264.052020638055, 100);
        final String hex = result1.rgbHex;

        // Verify with the expected value
        expect(hex, equals('#0000ff'));
      });
    });
  }
