import 'dart:math';
import 'dart:ui';

class RGBtoOKLCH {

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
    // Step 1: Convert RGB to XYZ
    List<double> xyz = _rgbToXyz(r, g, b);

    // Step 2: Convert XYZ to Lab
    List<double> lab = _xyzToLab(xyz[0], xyz[1], xyz[2]);

    // Step 3: Convert Lab to OKLCH
    return _labToOklch(lab[0], lab[1], lab[2]);
  }

  // RGB to XYZ conversion (assuming sRGB color space)
  static List<double> _rgbToXyz(int r, int g, int b) {
    // Normalize RGB values to the range 0-1
    double rNorm = r / 255.0;
    double gNorm = g / 255.0;
    double bNorm = b / 255.0;

    // Apply reverse gamma correction
    rNorm = _inverseGammaCorrection(rNorm);
    gNorm = _inverseGammaCorrection(gNorm);
    bNorm = _inverseGammaCorrection(bNorm);

    // Convert to XYZ using the sRGB color space
    double x = (0.4124 * rNorm + 0.3576 * gNorm + 0.1805 * bNorm) / 0.95047;
    double y = (0.2126 * rNorm + 0.7152 * gNorm + 0.0722 * bNorm);
    double z = (0.0193 * rNorm + 0.1192 * gNorm + 0.9505 * bNorm) / 1.08883;

    return [x, y, z];
  }

  // Inverse gamma correction for sRGB
  static double _inverseGammaCorrection(double c) {
    if (c <= 0.04045) {
      return c / 12.92;
    } else {
      return pow((c + 0.055) / 1.055, 2.4).toDouble();
    }
  }

  // XYZ to Lab conversion (assuming D65 illuminant)
  static List<double> _xyzToLab(double x, double y, double z) {
    x *= 0.95047; // Scale for D65 illuminant
    y *= 1.00000;
    z *= 1.08883; // Scale for D65 illuminant

    x = _labFunc(x);
    y = _labFunc(y);
    z = _labFunc(z);

    double l = (116 * y) - 16;
    double a = 500 * (x - y);
    double b = 200 * (y - z);

    return [l, a, b];
  }

  // Function for Lab conversion
  static double _labFunc(double t) {
    double delta = 6.0 / 29.0;
    if (t > pow(delta, 3)) {
      return pow(t, 1 / 3).toDouble();
    } else {
      return t / (3 * pow(delta, 2)) + 4.0 / 29.0;
    }
  }

  // Lab to OKLCH conversion
  static List<double> _labToOklch(double l, double a, double b) {
    double c = sqrt(a * a + b * b);
    double h = atan2(b, a) * 180 / pi;
    if (h < 0) {
      h = 360 + h;
    }
    return [l, c, h];
  }
}
