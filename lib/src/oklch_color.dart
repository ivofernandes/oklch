import 'package:flutter/material.dart';
import 'package:oklch/src/oklab_color.dart';

/// The OKLCHColor class represents colors in the OKLCH color space.
/// OKLCH is a perceptually uniform color space, which can be useful for
/// various color processing tasks in Flutter applications.
class OKLCHColor {
  /// Main constructor for creating an OKLCHColor object.
  const OKLCHColor(
    this.lightness,
    this.chroma,
    this.hue, [
    this.alpha = 1.0,
  ]);

  /// Factory constructor that creates an OKLCHColor instance from a Flutter Color object.
  /// Converts RGB values to OKLCH.
  factory OKLCHColor.fromColor(Color color) =>
      OKLABColor.fromColor(color).toOKLCH();

  /// Factory constructor to create an OKLCHColor instance from given OKLCH values.
  /// Optionally, an alpha value can be specified.
  factory OKLCHColor.fromOKLCH(
    double l,
    double c,
    double h, [
    double alpha = 1.0,
  ]) =>
      OKLCHColor(l, c, h, alpha);

  /// Lightness component of the OKLCH color model.
  final double lightness;

  /// Chroma component, indicating the color intensity or purity.
  final double chroma;

  /// Hue component, defining the type of color (like blue, green, etc.).
  /// In Radians by default
  final double hue;

  /// Alpha (opacity) value of the color. Defaults to 1.0 (fully opaque).
  final double alpha;

  @override
  String toString() =>
      'OKLCH(${lightness.toStringAsFixed(2)}, ${chroma.toStringAsFixed(2)}, ${hue.toStringAsFixed(2)})';

  /// OKLCH Black
  static const OKLCHColor black = OKLCHColor(0, 0, 0);

  /// OKLCH Black
  static const OKLCHColor white = OKLCHColor(100, 0, 0);

  /// [OKLCHColor] to [Color]
  Color toColor() => OKLABColor.fromOKLCH(this).toColor();

  /// Provides a hexadecimal representation of the OKLCH color in the RGB color space.
  String get rgbHex {
    final c = toColor();
    final rHex = _channelToInt(c.r).toRadixString(16).padLeft(2, '0');
    final gHex = _channelToInt(c.g).toRadixString(16).padLeft(2, '0');
    final bHex = _channelToInt(c.b).toRadixString(16).padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  /// Gives a textual representation of the OKLCH color,
  /// displaying lightness, chroma, and hue values.

  static OKLCHColor mix(
    OKLCHColor color1,
    OKLCHColor color2,

    /// Percetange of color 1 in the mix
    /// Should be a number from 0 to 1
    double color1Percentage,
  ) {
    assert(
      color1Percentage >= 0 && color1Percentage <= 1,
      'Color 1 percentage needs to be inside [0, 1]',
    );
    final c1 = OKLABColor.fromOKLCH(color1);
    final c2 = OKLABColor.fromOKLCH(color2);
    final mixL = c1.lightness * color1Percentage +
        (c2.lightness * (1 - color1Percentage));
    final mixA = c1.a * color1Percentage + (c2.a * (1 - color1Percentage));
    final mixB = c1.b * color1Percentage + (c2.b * (1 - color1Percentage));
    return OKLABColor(mixL, mixA, mixB).toOKLCH();
  }

  /// Returns a new [OKLCHColor] that matches this color with the alpha channel
  /// replaced with the given `opacity` (which ranges from 0.0 to 1.0).
  OKLCHColor withOpacity(double a) => OKLCHColor(
        lightness,
        chroma,
        hue,
        a,
      );

  int _channelToInt(double channel) {
    final scaled = (channel.clamp(0, 1) * 255).round();
    return scaled.clamp(0, 255) & 0xff;
  }
}
