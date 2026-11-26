import 'dart:ui';

import 'package:oklch_dart/oklch_dart.dart' as base;

extension UIColorDataBridge on base.ColorData {
  Color toUIColor() => Color.from(alpha: a, red: r, green: g, blue: b);
}

extension UIColorBridge on Color {
  base.ColorData toColorData() => base.ColorData(r, g, b, a);
}

class OKLABColor extends base.OKLABColor {
  OKLABColor(
    double lightness,
    double greenRed,
    double blueYellow, [
    double alpha = 1,
  ]) : super(lightness, greenRed, blueYellow, alpha);

  OKLABColor.fromColor(Color color) : super.fromColorData(color.toColorData());

  OKLABColor.fromOKLCH(OKLCHColor color) : super.fromOKLCH(color);

  Color toColor() => super.toColorData().toUIColor();
}

class OKLCHColor extends base.OKLCHColor {
  const OKLCHColor(
    double lightness,
    double chroma,
    double hue, [
    double alpha = 1,
  ]) : super(lightness, chroma, hue, alpha);

  OKLCHColor.fromColor(Color color) : super.fromColorData(color.toColorData());

  OKLCHColor.fromOKLCH(
    double l,
    double c,
    double h, [
    double alpha = 1,
  ]) : super.fromOKLCH(l, c, h, alpha);

  OKLCHColor._fromOKLCH(base.OKLCHColor color)
      : this(
          color.lightness,
          color.chroma,
          color.hue,
          color.alpha,
        );

  Color toColor() => super.toColorData().toUIColor();

  static const OKLCHColor black = OKLCHColor(0, 0, 0);
  static const OKLCHColor white = OKLCHColor(1, 0, 0);

  static OKLCHColor mix(
    OKLCHColor color1,
    OKLCHColor color2,
    double percentage,
  ) =>
      OKLCHColor._fromOKLCH(base.OKLCHColor.mix(color1, color2, percentage));
}
