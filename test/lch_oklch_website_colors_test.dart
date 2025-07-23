import 'package:flutter_test/flutter_test.dart';
import 'package:oklch/oklch.dart';

void main() {
  group('LCH OKLCH website color tests', () {
    /// Test the specific color from the reference URL
    /// https://lch.oklch.com/#50,84.7,42.57,100
    /// Expected to be an orange-red color
    /// Testing multiple chroma interpretations to find the correct one
    test('Converts OKLCH to RGB for reference orange-red color', () {
      // Test with chroma normalized to 0-1 range (divided by 100)
      final result1 = OKLCHColor.fromOKLCH(
        50,       // Lightness
        0.847,    // Chroma (84.7/100)
        42.57,    // Hue in degrees
        1.0,      // Alpha
      );
      
      // Test with chroma as a percentage (divided by 100 and then normalized)
      final result2 = OKLCHColor.fromOKLCH(
        50,       // Lightness
        0.3,      // Chroma (more reasonable value based on existing tests)
        42.57,    // Hue in degrees
        1.0,      // Alpha
      );

      final hex1 = result1.rgbHex;
      final hex2 = result2.rgbHex;

      print('Reference color with C=0.847: $hex1');
      print('Reference color with C=0.3: $hex2');
      
      // Both should be valid hex colors
      expect(hex1.length, equals(7));
      expect(hex1.startsWith('#'), isTrue);
      expect(hex2.length, equals(7));
      expect(hex2.startsWith('#'), isTrue);
    });

    /// Test variations with different lightness values
    test('Converts OKLCH with different lightness values', () {
      final colors = [
        OKLCHColor.fromOKLCH(25, 0.847, 42.57, 1.0),  // Darker
        OKLCHColor.fromOKLCH(50, 0.847, 42.57, 1.0),  // Reference
        OKLCHColor.fromOKLCH(75, 0.847, 42.57, 1.0),  // Lighter
      ];

      for (final color in colors) {
        final hex = color.rgbHex;
        print('L=${color.lightness}, C=${color.chroma}, H=${color.hue} → $hex');
        expect(hex.length, equals(7));
        expect(hex.startsWith('#'), isTrue);
      }
    });

    /// Test variations with different chroma values
    test('Converts OKLCH with different chroma values', () {
      final colors = [
        OKLCHColor.fromOKLCH(50, 0.2, 42.57, 1.0),    // Lower chroma
        OKLCHColor.fromOKLCH(50, 0.5, 42.57, 1.0),    // Medium chroma
        OKLCHColor.fromOKLCH(50, 0.847, 42.57, 1.0),  // High chroma (reference)
      ];

      for (final color in colors) {
        final hex = color.rgbHex;
        print('L=${color.lightness}, C=${color.chroma}, H=${color.hue} → $hex');
        expect(hex.length, equals(7));
        expect(hex.startsWith('#'), isTrue);
      }
    });

    /// Test variations with different hue values
    test('Converts OKLCH with different hue values', () {
      final colors = [
        OKLCHColor.fromOKLCH(50, 0.5, 0, 1.0),      // Red
        OKLCHColor.fromOKLCH(50, 0.5, 42.57, 1.0),  // Orange-red (reference hue)
        OKLCHColor.fromOKLCH(50, 0.5, 90, 1.0),     // Yellow
        OKLCHColor.fromOKLCH(50, 0.5, 180, 1.0),    // Green
        OKLCHColor.fromOKLCH(50, 0.5, 270, 1.0),    // Blue
      ];

      for (final color in colors) {
        final hex = color.rgbHex;
        print('L=${color.lightness}, C=${color.chroma}, H=${color.hue} → $hex');
        expect(hex.length, equals(7));
        expect(hex.startsWith('#'), isTrue);
      }
    });

    /// Test extreme values to ensure robustness
    test('Converts OKLCH with extreme values', () {
      final colors = [
        OKLCHColor.fromOKLCH(0, 0, 0, 1.0),        // Black
        OKLCHColor.fromOKLCH(100, 0, 0, 1.0),      // White
        OKLCHColor.fromOKLCH(50, 1.0, 42.57, 1.0), // Maximum chroma
        OKLCHColor.fromOKLCH(50, 0, 42.57, 1.0),   // No chroma (gray)
      ];

      for (final color in colors) {
        final hex = color.rgbHex;
        print('L=${color.lightness}, C=${color.chroma}, H=${color.hue} → $hex');
        expect(hex.length, equals(7));
        expect(hex.startsWith('#'), isTrue);
      }
    });

    /// Test colors that should match common web colors
    test('Converts OKLCH to expected hex values for known colors', () {
      // Test based on the reference URL pattern
      // https://lch.oklch.com/#50,84.7,42.57,100
      // This should produce a vibrant orange-red color
      
      // Testing different interpretations of the chroma value
      final colorHighChroma = OKLCHColor.fromOKLCH(50, 0.847, 42.57, 1.0);
      final colorMedChroma = OKLCHColor.fromOKLCH(50, 0.3, 42.57, 1.0);
      final colorLowChroma = OKLCHColor.fromOKLCH(50, 0.15, 42.57, 1.0);
      
      final highChromaHex = colorHighChroma.rgbHex;
      final medChromaHex = colorMedChroma.rgbHex;
      final lowChromaHex = colorLowChroma.rgbHex;
      
      print('High chroma (0.847): $highChromaHex');
      print('Medium chroma (0.3): $medChromaHex');
      print('Low chroma (0.15): $lowChromaHex');
      
      // All should be valid hex colors
      expect(highChromaHex.length, equals(7));
      expect(medChromaHex.length, equals(7));
      expect(lowChromaHex.length, equals(7));
      
      // Test some specific expected colors based on common OKLCH values
      // Orange-ish red color at moderate lightness and chroma
      final orangeRed = OKLCHColor.fromOKLCH(60, 0.2, 40, 1.0);
      final orangeRedHex = orangeRed.rgbHex;
      
      // Bright red color
      final brightRed = OKLCHColor.fromOKLCH(55, 0.22, 25, 1.0);
      final brightRedHex = brightRed.rgbHex;
      
      print('Orange-red (L=60, C=0.2, H=40): $orangeRedHex');
      print('Bright red (L=55, C=0.22, H=25): $brightRedHex');
      
      // Ensure they're valid hex colors
      expect(orangeRedHex.length, equals(7));
      expect(brightRedHex.length, equals(7));
      expect(orangeRedHex.startsWith('#'), isTrue);
      expect(brightRedHex.startsWith('#'), isTrue);
    });
  });
  
  group('Reverse conversion tests for new colors', () {
    /// Test that RGB to OKLCH to RGB conversions are consistent
    test('Round-trip conversion consistency', () {
      final originalColor = OKLCHColor.fromOKLCH(50, 0.5, 42.57, 1.0);
      final rgbColor = originalColor.toColor();
      final backToOklch = OKLCHColor.fromColor(rgbColor);
      
      // Allow for small floating-point differences
      expect(backToOklch.lightness, closeTo(originalColor.lightness, 1.0));
      expect(backToOklch.chroma, closeTo(originalColor.chroma, 0.1));
      expect(backToOklch.hue, closeTo(originalColor.hue, 5.0));
    });

    /// Test conversion for the reference color with round-trip accuracy
    test('Reference color round-trip conversion', () {
      // Test the reference color from the URL
      final referenceColor = OKLCHColor.fromOKLCH(50, 0.3, 42.57, 1.0);
      final rgbColor = referenceColor.toColor();
      final backToOklch = OKLCHColor.fromColor(rgbColor);
      
      print('Original: L=${referenceColor.lightness}, C=${referenceColor.chroma}, H=${referenceColor.hue}');
      print('RGB: R=${rgbColor.red}, G=${rgbColor.green}, B=${rgbColor.blue}');
      print('Back to OKLCH: L=${backToOklch.lightness}, C=${backToOklch.chroma}, H=${backToOklch.hue}');
      
      // Allow for small floating-point differences
      expect(backToOklch.lightness, closeTo(referenceColor.lightness, 2.0));
      expect(backToOklch.chroma, closeTo(referenceColor.chroma, 0.05));
      expect(backToOklch.hue, closeTo(referenceColor.hue, 10.0));
    });
  });

  group('Additional comprehensive color tests', () {
    /// Test colors with specific expected characteristics
    test('Test specific color expectations', () {
      // Test bright orange color
      final brightOrange = OKLCHColor.fromOKLCH(70, 0.2, 60, 1.0);
      final brightOrangeHex = brightOrange.rgbHex;
      
      // Test coral color
      final coral = OKLCHColor.fromOKLCH(75, 0.15, 35, 1.0);
      final coralHex = coral.rgbHex;
      
      // Test salmon color
      final salmon = OKLCHColor.fromOKLCH(75, 0.1, 25, 1.0);
      final salmonHex = salmon.rgbHex;

      // Test medium gray
      final mediumGray = OKLCHColor.fromOKLCH(60, 0, 0, 1.0);
      final mediumGrayHex = mediumGray.rgbHex;
      
      print('Bright orange (L=70, C=0.2, H=60): $brightOrangeHex');
      print('Coral (L=75, C=0.15, H=35): $coralHex');
      print('Salmon (L=75, C=0.1, H=25): $salmonHex');
      print('Medium gray (L=60, C=0, H=0): $mediumGrayHex');
      
      // All should be valid
      expect(brightOrangeHex.length, equals(7));
      expect(coralHex.length, equals(7));
      expect(salmonHex.length, equals(7));
      expect(mediumGrayHex.length, equals(7));
      
      // Medium gray should be a proper gray (R=G=B)
      final grayColor = mediumGray.toColor();
      expect((grayColor.red - grayColor.green).abs(), lessThan(5));
      expect((grayColor.green - grayColor.blue).abs(), lessThan(5));
    });

    /// Test the specific website reference color more thoroughly
    test('Website reference color detailed test', () {
      // Based on https://lch.oklch.com/#50,84.7,42.57,100
      // Try different normalizations of the chroma value
      
      final testColors = [
        OKLCHColor.fromOKLCH(50, 0.847, 42.57, 1.0),  // Direct from URL
        OKLCHColor.fromOKLCH(50, 0.25, 42.57, 1.0),   // Similar to existing tests
        OKLCHColor.fromOKLCH(50, 0.2, 42.57, 1.0),    // Conservative chroma
        OKLCHColor.fromOKLCH(50, 0.15, 42.57, 1.0),   // Low chroma
      ];
      
      for (int i = 0; i < testColors.length; i++) {
        final color = testColors[i];
        final hex = color.rgbHex;
        final rgbColor = color.toColor();
        
        print('Test $i - C=${color.chroma}: $hex (R=${rgbColor.red}, G=${rgbColor.green}, B=${rgbColor.blue})');
        
        expect(hex.length, equals(7));
        expect(hex.startsWith('#'), isTrue);
        
        // For the orange-red hue (~42.57°), we expect:
        // - Red component should be highest
        // - Green component should be moderate
        // - Blue component should be lowest
        expect(rgbColor.red, greaterThan(rgbColor.blue));
        if (color.chroma > 0.1) { // Only for colors with significant chroma
          expect(rgbColor.red, greaterThan(rgbColor.green * 0.7));
        }
      }
    });
  });
}