import 'dart:math';

import 'package:oklch_dart/src/color_data.dart';
import 'package:oklch_dart/src/oklch_color.dart';

const _kHueEpsilon = 1e-7;

class LMSColor {
  final double l;
  final double m;
  final double s;
  final double alpha;

  LMSColor(this.l, this.m, this.s, [this.alpha = 1]);

  LMSColor.fromLinearRGB(
    double r,
    double g,
    double b, [
    this.alpha = 1,
  ])  : l = _cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b),
        m = _cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b),
        s = _cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);
}

/// The OKLABColor class represents colors in the OKLAB color space.
class OKLABColor {
  /// Main constructor
  const OKLABColor(
    this.lightness,
    this.greenRed,
    this.blueYellow, [
    this.alpha = 1,
  ]);

  /// Convert LMS to Oklab
  OKLABColor.fromLMS(LMSColor lms)
      : this(
          0.2104542553 * lms.l + 0.7936177850 * lms.m - 0.0040720468 * lms.s,
          1.9779984951 * lms.l - 2.4285922050 * lms.m + 0.4505937099 * lms.s,
          0.0259040371 * lms.l + 0.7827717662 * lms.m - 0.8086757660 * lms.s,
          lms.alpha,
        );

  OKLABColor._fromLinearRGBData(
    LinearColorData linear,
  ) : this._fromLinearRGB(
          linear.r,
          linear.g,
          linear.b,
          linear.a,
        );

  OKLABColor._fromLinearRGB(
    double r,
    double g,
    double b, [
    double alpha = 1,
  ]) : this.fromLMS(LMSColor.fromLinearRGB(r, g, b, alpha));

  /// Factory constructor to create an OKLABColor instance from given color.
  OKLABColor.fromColorData(
    ColorData color,
  ) : this._fromLinearRGBData(color.toLinearRGB());

  /// Factory constructor to create an OKLABColor instance from given OKLCHColor.
  OKLABColor.fromOKLCH(OKLCHColor color)
      : this(
          color.lightness,
          cos(color.hue * pi / 180) * color.chroma,
          sin(color.hue * pi / 180) * color.chroma,
          color.alpha,
        );

  /// Lightness component of the OKLAB color model.
  final double lightness;

  /// Green and Red component of the OKLAB color model.
  final double greenRed;

  /// Blue and Yellow component of the OKLAB color model.
  final double blueYellow;

  /// Alpha component of the color, representing its opacity.
  final double alpha;

  /// Alias for the Green and Red component of the OKLAB color model.
  double get a => greenRed;

  /// Alias for the Blue and Yellow component of the OKLAB color model.
  double get b => blueYellow;

  @override
  String toString() =>
      'OKLAB(lightness: $lightness, greenRed: $a, blueYellow: $b, alpha: $alpha)';

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

    return OKLCHColor(lightness, chroma, hue, alpha);
  }

  /// [OKLABColor] to [ColorData]
  ColorData toColorData() {
    final (r, g, b) = _oklabToLinearRgb();
    return ColorData(
      _gammaCorrect(r.clamp(0, 1)),
      _gammaCorrect(g.clamp(0, 1)),
      _gammaCorrect(b.clamp(0, 1)),
      alpha.clamp(0, 1),
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

  double _gammaCorrect(double c) {
    if (c <= 0.0031308) {
      return 12.92 * c;
    } else {
      return 1.055 * pow(c, 1 / 2.4).toDouble() - 0.055;
    }
  }
}

/// Computes the cubic root of a given number [x].
double _cbrt(double x) => pow(x, 1 / 3).toDouble();
