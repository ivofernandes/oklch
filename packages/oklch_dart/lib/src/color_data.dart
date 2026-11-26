import 'dart:math';

class ColorData {
  final double r;
  final double g;
  final double b;
  final double a;

  const ColorData(this.r, this.g, this.b, this.a);

  const ColorData.fromARGB(int argb)
      : a = ((argb >> 24) & 0xFF) / 255.0,
        r = ((argb >> 16) & 0xFF) / 255.0,
        g = ((argb >> 8) & 0xFF) / 255.0,
        b = (argb & 0xFF) / 255.0;

  LinearColorData toLinearRGB() {
    final rLin = _gammaCorrect(r);
    final gLin = _gammaCorrect(g);
    final bLin = _gammaCorrect(b);
    return LinearColorData(rLin, gLin, bLin, a);
  }

  static double _gammaCorrect(double c) {
    if (c <= 0.04045) {
      return c / 12.92;
    } else {
      return pow((c + 0.055) / 1.055, 2.4).toDouble();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ColorData) return false;
    return r == other.r && g == other.g && b == other.b && a == other.a;
  }

  @override
  int get hashCode => Object.hash(r, g, b, a);

  @override
  String toString() {
    return 'ColorData(r: $r, g: $g, b: $b, a: $a)';
  }
}

class LinearColorData extends ColorData {
  const LinearColorData(double r, double g, double b, double a)
      : super(r, g, b, a);
}
