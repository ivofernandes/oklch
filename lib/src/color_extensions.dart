import 'dart:math';
import 'dart:ui';

//ignore_for_file: public_member_api_docs

extension ColorExtensions on Color {
  (double, double, double) toLinearRGB() {
    final rLin = _gammaCorrect(red / 255);
    final gLin = _gammaCorrect(green / 255);
    final bLin = _gammaCorrect(blue / 255);
    return (rLin, gLin, bLin);
  }

  static double _gammaCorrect(double c) {
    if (c <= 0.04045) {
      return c / 12.92;
    } else {
      return pow((c + 0.055) / 1.055, 2.4).toDouble();
    }
  }
}
