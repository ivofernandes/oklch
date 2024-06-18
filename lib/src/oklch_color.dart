import 'package:flutter/material.dart';
import 'package:oklch/src/utils/rgb_to_oklch.dart'; // Import RGB to OKLCH conversion utility
import 'utils/oklch_to_rgb.dart'; // Import OKLCH to RGB conversion utility

/// The OKLCHColor class represents colors in the OKLCH color space.
/// OKLCH is a perceptually uniform color space, which can be useful for
/// various color processing tasks in Flutter applications.
class OKLCHColor {
  /// Lightness component of the OKLCH color model.
  double lightness;

  /// Chroma component, indicating the color intensity or purity.
  double chroma;

  /// Hue component, defining the type of color (like blue, green, etc.).
  double hue;

  /// Alpha (opacity) value of the color. Defaults to 1.0 (fully opaque).
  double alpha;

  /// Main constructor for creating an OKLCHColor object.
  OKLCHColor(this.lightness, this.chroma, this.hue, [this.alpha = 1.0]);

  /// Factory constructor to create an OKLCHColor instance from given OKLCH values.
  /// Optionally, an alpha value can be specified.
  factory OKLCHColor.fromOKLCH(double l, double c, double h, [double alpha = 1.0]) {
    return OKLCHColor(l, c, h, alpha);
  }

  /// Factory constructor that creates an OKLCHColor instance from a Flutter Color object.
  /// Converts RGB values to OKLCH.
  factory OKLCHColor.fromColor(Color color) {
    List<double> oklch = RGBtoOKLCH.convertColorToOKLCH(color);
    return OKLCHColor(oklch[0], oklch[1], oklch[2]);
  }

  /// Converts the OKLCH color to a Flutter Color object using RGB values.
  Color get color {
    List<int> rgb = OKLCHtoRGB.convert(lightness, chroma, hue);
    final red = rgb[0];
    final green = rgb[1];
    final blue = rgb[2];
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  /// Returns the OKLCH color components (including alpha) as a list of doubles.
  List<double> get array => [lightness, chroma, hue, alpha];

  /// Provides a hexadecimal representation of the OKLCH color in the RGB color space.
  String get rgbHex {
    final String rHex = color.red.toRadixString(16).padLeft(2, '0');
    final String gHex = color.green.toRadixString(16).padLeft(2, '0');
    final String bHex = color.blue.toRadixString(16).padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  /// Gives a textual representation of the OKLCH color,
  /// displaying lightness, chroma, and hue values.
  String get textDescription =>
      'OKLCH(${lightness.toStringAsFixed(2)}, ${chroma.toStringAsFixed(2)}, ${hue.toStringAsFixed(2)})';
}
