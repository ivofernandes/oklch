import 'dart:math';

class OKLCHtoRGB {
  // Function to convert OKLCH to RGB
  static List<int> convert(double l, double c, double h) {
    // Step 1: Convert OKLCH to Lab
    List<double> lab = _oklchToLab(l, c, h);

    // Step 2: Convert Lab to XYZ
    List<double> xyz = _labToXyz(lab[0], lab[1], lab[2]);

    // Step 3: Convert XYZ to RGB
    return _xyzToRgb(xyz[0], xyz[1], xyz[2]);
  }

  // OKLCH to Lab conversion
  static List<double> _oklchToLab(double l, double c, double h) {
    double a = cos(h * pi / 180) * c;
    double b = sin(h * pi / 180) * c;
    return [l, a, b];
  }

  // Lab to XYZ conversion (assuming D65 illuminant)
  static List<double> _labToXyz(double l, double a, double b) {
    double fy = (l + 16) / 116;
    double fx = a / 500 + fy;
    double fz = fy - b / 200;

    fx = _inverseLabFunc(fx) * 0.95047; // D65 illuminant
    fy = _inverseLabFunc(fy);
    fz = _inverseLabFunc(fz) * 1.08883; // D65 illuminant

    return [fx, fy, fz];
  }

  // Inverse function for Lab to XYZ conversion
  static double _inverseLabFunc(double t) {
    double delta = 6.0 / 29.0;
    if (t > delta) {
      return pow(t, 3).toDouble();
    } else {
      return 3 * pow(delta, 2) * (t - 4.0 / 29.0);
    }
  }

  // XYZ to RGB conversion (assuming sRGB color space)
  static List<int> _xyzToRgb(double x, double y, double z) {
    // Convert XYZ to linear RGB
    double rLin = 3.2406 * x - 1.5372 * y - 0.4986 * z;
    double gLin = -0.9689 * x + 1.8758 * y + 0.0415 * z;
    double bLin = 0.0557 * x - 0.2040 * y + 1.0570 * z;

    // Apply gamma correction
    int r = (255 * _gammaCorrection(rLin)).round().clamp(0, 255);
    int g = (255 * _gammaCorrection(gLin)).round().clamp(0, 255);
    int b = (255 * _gammaCorrection(bLin)).round().clamp(0, 255);

    return [r, g, b];
  }

  // Gamma correction for sRGB
  static double _gammaCorrection(double c) {
    if (c <= 0.0031308) {
      return 12.92 * c;
    } else {
      return 1.055 * pow(c, 1 / 2.4) - 0.055;
    }
  }
}
