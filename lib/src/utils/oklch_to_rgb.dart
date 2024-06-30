import 'dart:math';

class OKLCHtoRGB {
  static List<double> oklchToOklab(double l, double c, double h) {
    final double a = cos(h * pi / 180) * c;
    final double b = sin(h * pi / 180) * c;
    return [l / 100, a, b]; // Normalizing l
  }

  static List<double> oklabToLinearRgb(List<double> oklab) {
    const m2 = [
      [4.0767416621, -3.3077115913, 0.2309699292],
      [-1.2684380046, 2.6097574011, -0.3413193965],
      [-0.0041960863, -0.7034186147, 1.7076147010]
    ];

    final double l = oklab[0];
    final double a = oklab[1];
    final double b = oklab[2];

    // Convert OKLab to LMS
    double l_ = l + 0.3963377774 * a + 0.2158037573 * b;
    double m_ = l - 0.1055613458 * a - 0.0638541728 * b;
    double s_ = l - 0.0894841775 * a - 1.2914855480 * b;

    // Apply cubic root
    l_ = pow(l_, 3).toDouble();
    m_ = pow(m_, 3).toDouble();
    s_ = pow(s_, 3).toDouble();

    // Convert LMS to linear RGB using m2 matrix
    final double r = m2[0][0] * l_ + m2[0][1] * m_ + m2[0][2] * s_;
    final double g = m2[1][0] * l_ + m2[1][1] * m_ + m2[1][2] * s_;
    final double b_ = m2[2][0] * l_ + m2[2][1] * m_ + m2[2][2] * s_;

    return [r, g, b_];
  }

  static int gammaCorrect(double c) {
    if (c <= 0.0031308) {
      return (12.92 * c * 255).round();
    } else {
      return ((1.055 * pow(c, 1 / 2.4).toDouble() - 0.055) * 255).round();
    }
  }

  static List<int> convert(double l, double c, double h) {
    final List<double> oklab = oklchToOklab(l, c, h);
    List<double> linearRgb = oklabToLinearRgb(oklab);

    // Normalize and clamp linear RGB values to [0, 1] before applying gamma correction
    linearRgb = linearRgb.map((v) => v.clamp(0.0, 1.0)).toList();

    return [
      gammaCorrect(linearRgb[0]),
      gammaCorrect(linearRgb[1]),
      gammaCorrect(linearRgb[2])
    ];
  }
}
