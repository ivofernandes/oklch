import 'package:flutter/material.dart';
import 'package:oklch/src/rgb_to_oklch.dart';

import 'oklch_to_rgb.dart'; // Assuming you have the OKLCH to RGB conversion logic

class OKLCHColor {
  static Color fromOKLCH(double l, double c, double h, [double alpha = 1.0]) {
    List<int> rgb = OKLCHtoRGB.convert(l, c, h);
    return Color.fromRGBO(rgb[0], rgb[1], rgb[2], alpha);
  }

  static List<double> convertColorToOKLCH(Color color) {
    // Extract RGB values
    int r = color.red;
    int g = color.green;
    int b = color.blue;

    // Convert RGB to OKLCH
    return RGBtoOKLCH.convert(r, g, b);
  }

}
