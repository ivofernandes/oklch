import 'dart:math';
import 'dart:ui';

import 'package:oklch/src/color_extensions.dart';
import 'package:oklch/src/oklch_color.dart';

const _kHueEpsilon = 1e-7;

/// The OKLABColor class represents colors in the OKLAB color space.
class OKLABColor {
  /// Main constructor
  const OKLABColor(
    this.lightness,
    this.greenRed,
    this.blueYellow,
  );

  factory OKLABColor._fromLinearRGB(double r, double g, double b) {
    // Convert linear RGB to LMS
    final l = _cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b);
    final m = _cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b);
    final s = _cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);

    // Convert LMS to Oklab
    final lCube = 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s;
    final aCube = 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s;
    final bCube = 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s;

    return OKLABColor(lCube, aCube, bCube);
  }

  /// Factory constructor to create an OKLABColor instance from given color.
  factory OKLABColor.fromColor(Color color) {
    final (r, g, b) = color.toLinearRGB();
    return OKLABColor._fromLinearRGB(r, g, b);
  }

  /// Factory constructor to create an OKLABColor instance from given OKLCHColor.
  factory OKLABColor.fromOKLCH(OKLCHColor color) {
    final a = cos(color.hue * pi / 180) * color.chroma;
    final b = sin(color.hue * pi / 180) * color.chroma;
    return OKLABColor(color.lightness, a, b);
  }

  /// Lightness component of the OKLAB color model.
  final double lightness;

  /// Green and Red component of the OKLAB color model.
  final double greenRed;

  /// Blue and Yellow component of the OKLAB color model.
  final double blueYellow;

  /// Alias for the Green and Red component of the OKLAB color model.
  double get a => greenRed;

  /// Alias for the Blue and Yellow component of the OKLAB color model.
  double get b => blueYellow;

  @override
  String toString() =>
      'OKLAB(lightness: $lightness, greenRed: $a, blueYellow: $b)';

  /// [OKLABColor] to [OKLCHColor]
  OKLCHColor toOKLCH() {
    final chroma = sqrt(a * a + b * b);

    var hue = 0.0;
    if (chroma > _kHueEpsilon) {
      hue = atan2(b, a);
      if (hue < 0) {
        hue += 2 * pi;
      }
      hue = hue * 180 / pi;
    }

    return OKLCHColor(lightness, chroma, hue);
  }

  /// [OKLABColor] to [Color]
  Color toColor() {
    final (r, g, b) = _oklabToLinearRgb();
    return Color.fromRGBO(
      _gammaCorrect(r.clamp(0, 1)),
      _gammaCorrect(g.clamp(0, 1)),
      _gammaCorrect(b.clamp(0, 1)),
      1,
    );
  }

  (double, double, double) _oklabToLinearRgb() {
    const m2 = [
      [4.0767416621, -3.3077115913, 0.2309699292],
      [-1.2684380046, 2.6097574011, -0.3413193965],
      [-0.0041960863, -0.7034186147, 1.7076147010],
    ];

    final l = lightness;

    // Convert OKLab to LMS
    var l_ = l + 0.3963377774 * a + 0.2158037573 * b;
    var m_ = l - 0.1055613458 * a - 0.0638541728 * b;
    var s_ = l - 0.0894841775 * a - 1.2914855480 * b;

    // Apply cubic root
    l_ = pow(l_, 3).toDouble();
    m_ = pow(m_, 3).toDouble();
    s_ = pow(s_, 3).toDouble();

    // Convert LMS to linear RGB using m2 matrix
    final r = m2[0][0] * l_ + m2[0][1] * m_ + m2[0][2] * s_;
    final g = m2[1][0] * l_ + m2[1][1] * m_ + m2[1][2] * s_;
    final b_ = m2[2][0] * l_ + m2[2][1] * m_ + m2[2][2] * s_;

    return (r, g, b_);
  }

  int _gammaCorrect(double c) {
    if (c <= 0.0031308) {
      return (12.92 * c * 255).round();
    } else {
      return ((1.055 * pow(c, 1 / 2.4).toDouble() - 0.055) * 255).round();
    }
  }

  static double _cbrt(double x) => pow(x, 1 / 3).toDouble();
}
