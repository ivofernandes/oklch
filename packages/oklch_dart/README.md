# oklch_dart

Pure Dart implementation of the OKLCH and OKLab color spaces, with no Flutter
SDK dependency. Use it in Dart CLI tools, servers and other Dart applications.
For Flutter color extensions and the color picker widget, use the
[`oklch`](https://pub.dev/packages/oklch) package instead.

## Installation

```sh
dart pub add oklch_dart
```

## Usage

```dart
import 'package:oklch_dart/oklch_dart.dart';

void main() {
  const red = ColorData.fromARGB(0xFFFF0000);
  final color = OKLCHColor.fromColorData(red);
  print(color.rgbHex); // #ff0000

  final mixed = OKLCHColor.mix(color, OKLCHColor.white, 0.5);
  print(mixed.rgbHex);
  final rgb = mixed.toColorData();
  print(rgb);
}
```

`ColorData` stores normalized RGBA channels. `OKLCHColor` supports conversion,
mixing and opacity changes; `OKLABColor` provides OKLab conversion. Hue is in
degrees.

## License

Apache License 2.0; see [LICENSE](LICENSE).
