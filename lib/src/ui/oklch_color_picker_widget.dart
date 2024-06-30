import 'package:flutter/material.dart';
import 'package:oklch/src/oklch_color.dart';
import 'package:oklch/src/ui/gradient_rect_slider_track_shape.dart';

/// OKLCHColorPickerWidget provides a widget for selecting colors in the OKLCH color space.
/// It allows the user to adjust lightness, chroma, and hue to choose a color.
class OKLCHColorPickerWidget extends StatefulWidget {
  /// The initial color for the picker
  final Color color;

  /// Callback for when the color changes
  final ValueChanged<Color> onColorChanged;

  /// List of colors to use for the hue slider
  final List<Color> hueColors;

  const OKLCHColorPickerWidget({
    required this.color,
    required this.onColorChanged,
    this.hueColors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.red,
    ],
    super.key,
  });

  @override
  _OKLCHColorPickerWidgetState createState() => _OKLCHColorPickerWidgetState();
}

class _OKLCHColorPickerWidgetState extends State<OKLCHColorPickerWidget> {
  /// Lightness component of the OKLCH color model
  late double lightness;

  /// Chroma component, indicating the color intensity or purity
  late double chroma;

  /// Hue component, defining the type of color (like blue, green, etc.)
  late double hue;

  @override
  void initState() {
    super.initState();
    final oklch = OKLCHColor.fromColor(widget.color)
        .array; // Convert initial color to OKLCH
    lightness = oklch[0];
    chroma = oklch[1];
    hue = oklch[2];
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          _buildSlider('Lightness', lightness, 0, 100, (newValue) {
            setState(() => lightness = newValue);
            _updateColor();
          }, isHue: false),
          _buildSlider('Chroma', chroma, 0, 128, (newValue) {
            setState(() => chroma = newValue);
            _updateColor();
          }, isHue: false),
          _buildSlider('Hue', hue, 0, 360, (newValue) {
            setState(() => hue = newValue);
            _updateColor();
          }, isHue: true),
          Container(
            height: 50,
            color: OKLCHColor.fromOKLCH(lightness, chroma, hue).color,
          ),
        ],
      );

  Widget _buildSlider(String label, double value, double min, double max,
          ValueChanged<double> onChanged,
          {required bool isHue}) =>
      Row(
        children: <Widget>[
          Text(label),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackShape: isHue
                    ? GradientRectSliderTrackShape(widget.hueColors)
                    : null,
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: onChanged,
                divisions: isHue
                    ? null
                    : 10, // Optional: add divisions for non-hue sliders
              ),
            ),
          ),
        ],
      );

  void _updateColor() {
    final Color newColor = OKLCHColor.fromOKLCH(lightness, chroma, hue).color;
    widget.onColorChanged(newColor);
  }
}
