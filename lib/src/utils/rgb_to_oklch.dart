import 'dart:math';
import 'dart:ui';

class RGBtoOKLCH {
  // Convert Color to OKLCH
  static List<double> convertColorToOKLCH(Color color) {
    // Extract RGB values
    int r = color.red;
    int g = color.green;
    int b = color.blue;

    // Convert RGB to OKLCH
    return convert(r, g, b);
  }

  // Function to convert RGB to OKLCH
  static List<double> convert(int r, int g, int b) {
    // Step 1: Convert sRGB to linear RGB
    List<double> linearRgb = _sRgbToLinearRgb(r, g, b);

    // Step 2: Convert linear RGB to Oklab
    List<double> oklab =
        _linearRgbToOklab(linearRgb[0], linearRgb[1], linearRgb[2]);

    // Step 3: Convert Oklab to OKLCH
    return _oklabToOklch(oklab[0], oklab[1], oklab[2]);
  }

  // sRGB to linear RGB conversion
  static List<double> _sRgbToLinearRgb(int r, int g, int b) {
    double rLin = _gammaCorrect(r / 255.0);
    double gLin = _gammaCorrect(g / 255.0);
    double bLin = _gammaCorrect(b / 255.0);
    return [rLin, gLin, bLin];
  }

  // Gamma correction for sRGB
  static double _gammaCorrect(double c) {
    if (c <= 0.04045) {
      return c / 12.92;
    } else {
      return pow((c + 0.055) / 1.055, 2.4).toDouble();
    }
  }

  // Linear RGB to Oklab conversion
  static List<double> _linearRgbToOklab(double r, double g, double b) {
    // Apply the matrix multiplication using the coefficients from the blog post
    double l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b;
    double m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b;
    double s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b;

    // Apply cubic root
    double l_ = cbrt(l);
    double m_ = cbrt(m);
    double s_ = cbrt(s);

    // Final calculation
    double lCube = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_;
    double aCube = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_;
    double bCube = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_;
    return [lCube, aCube, bCube];
  }

  // Oklab to OKLCH conversion
  static List<double> _oklabToOklch(double l, double a, double b) {
    double c = sqrt(a * a + b * b);
    double h = atan2(b, a);
    if (h < 0) h += 2 * pi;
    return [l, c, h * 180 / pi];
  }

  static double cbrt(double x) {
    return pow(x, 1 / 3).toDouble();
  }
}
