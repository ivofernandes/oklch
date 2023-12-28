import 'dart:math';

class OKLCHtoRGB {
  // OKLCH to Lab conversion
  static List<double> _oklchToLab(double l, double c, double h) {
    double a = cos(h * pi / 180) * c;
    double b = sin(h * pi / 180) * c;
    return [l, a, b];
  }

  // Lab to XYZ conversion (D65 illuminant)
  static List<double> _labToXyz(double l, double a, double b) {
    double fy = (l + 16) / 116;
    double fx = a / 500 + fy;
    double fz = fy - b / 200;

    double x = _labFunc(fx) * 0.95047;
    double y = _labFunc(fy);
    double z = _labFunc(fz) * 1.08883;

    return [x, y, z];
  }

  static double _labFunc(double t) {
    double delta = 6.0 / 29.0;
    if (t > delta) {
      return pow(t, 3).toDouble();
    } else {
      return (t - 16.0 / 116) / 7.787;
    }
  }

  // XYZ to RGB conversion (sRGB color space)
  static List<int> _xyzToRgb(double x, double y, double z) {
    // Applying the inverse of the sRGB companding
    double rLin = x * 3.2406 + y * -1.5372 + z * -0.4986;
    double gLin = x * -0.9689 + y * 1.8758 + z * 0.0415;
    double bLin = x * 0.0557 + y * -0.2040 + z * 1.0570;

    return [_gammaCorrect(rLin), _gammaCorrect(gLin), _gammaCorrect(bLin)];
  }

  static int _gammaCorrect(double c) {
    double corrected;
    if (c <= 0.0031308) {
      corrected = 12.92 * c;
    } else {
      corrected = 1.055 * pow(c, 1 / 2.4) - 0.055;
    }
    return max(0, min((corrected * 255).round(), 255));
  }

  // Convert OKLCH to RGB
  static List<int> convert(double l, double c, double h) {
    List<double> lab = _oklchToLab(l, c, h);
    List<double> xyz = _labToXyz(lab[0], lab[1], lab[2]);
    return _xyzToRgb(xyz[0], xyz[1], xyz[2]);
  }
}
