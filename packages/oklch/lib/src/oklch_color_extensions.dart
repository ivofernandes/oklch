import 'dart:ui';

import 'package:oklch/src/oklch_color.dart';

/// Various OKLCHColor extensions
extension OKLCHColorExtensions on Color {
  /// Converts [Color] to [OKLCHColor]
  OKLCHColor toOKLCH() => OKLCHColor.fromColor(this);

  /// Mixes the color with black using the OKLCH color model.
  Color mixWithOKLCHBlack(double percentageOfBlack) => OKLCHColor.mix(
        OKLCHColor.black,
        toOKLCH(),
        percentageOfBlack,
      ).toColor();

  /// Mixes the color with white using the OKLCH color model.
  Color mixWithOKLCHWhite(double percentageOfWhite) => OKLCHColor.mix(
        OKLCHColor.white,
        toOKLCH(),
        percentageOfWhite,
      ).toColor();
}
