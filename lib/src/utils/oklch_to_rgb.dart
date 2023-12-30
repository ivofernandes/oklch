import 'dart:math';

class OKLCHtoRGB {
  static List<double> oklchToOklab(double l, double c, double h) {
    double a = cos(h * pi / 180) * c;
    double b = sin(h * pi / 180) * c;
    return [l, a, b];
  }

  static List<double> oklabToLinearRgb(List<double> oklab) {
    double l = oklab[0], a = oklab[1], b = oklab[2];
    double l_ = l + 0.3963377774 * a + 0.2158037573 * b;
    double m_ = l - 0.1055613458 * a - 0.0638541728 * b;
    double s_ = l - 0.0894841775 * a - 1.2914855480 * b;

    double lCube = l_ * l_ * l_;
    double mCube = m_ * m_ * m_;
    double sCube = s_ * s_ * s_;

    return [
      4.0767416621 * lCube - 3.3077115913 * mCube + 0.2309699292 * sCube,
      -1.2684380046 * lCube + 2.6097574011 * mCube - 0.3413193965 * sCube,
      -0.0041960863 * lCube - 0.7034186147 * mCube + 1.7076147010 * sCube
    ];
  }

  static int gammaCorrect(double c) {
    if (c <= 0.0031308) {
      return (12.92 * c * 255).round();
    } else {
      return ((1.055 * pow(c, 1 / 2.4) - 0.055) * 255).round();
    }
  }

  static List<int> convert(double l, double c, double h) {
    List<double> oklab = oklchToOklab(l, c, h);
    List<double> linearRgb = oklabToLinearRgb(oklab);
    return [
      gammaCorrect(linearRgb[0]),
      gammaCorrect(linearRgb[1]),
      gammaCorrect(linearRgb[2])
    ];
  }
}
