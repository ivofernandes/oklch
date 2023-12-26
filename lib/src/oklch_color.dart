import 'package:flutter/material.dart';
import 'package:oklch/src/rgb_to_oklch.dart';

import 'oklch_to_rgb.dart'; // Assuming you have the OKLCH to RGB conversion logic

class OKLCHColor {

  double lightness;
  double chroma;
  double hue;
  double alpha;

  OKLCHColor(this.lightness, this.chroma, this.hue, [this.alpha = 1.0]);

  factory OKLCHColor.fromOKLCH(double l, double c, double h, [double alpha = 1.0]) {
    List<int> rgb = OKLCHtoRGB.convert(l, c, h);
    return OKLCHColor(l, c, h, alpha);
  }

  factory OKLCHColor.fromColor(Color color) {
    List<double> oklch = RGBtoOKLCH.convertColorToOKLCH(color);
    return OKLCHColor(oklch[0], oklch[1], oklch[2]);
  }

  Color get color {
    List<int> rgb = OKLCHtoRGB.convert(lightness, chroma, hue);
    return Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1.0);
  }

  List<double> get array => [lightness, chroma, hue, alpha];

  String get rgbHex {
    final String rHex = color.red.toRadixString(16).padLeft(2, '0');
    final String gHex = color.green.toRadixString(16).padLeft(2, '0');
    final String bHex = color.blue.toRadixString(16).padLeft(2, '0');
    return '#$rHex$gHex$bHex';
  }

  String get textDescription => 'OKLCH(${lightness.toStringAsFixed(2)}, ${chroma.toStringAsFixed(2)}, ${hue.toStringAsFixed(2)})';

}
