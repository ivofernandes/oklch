import 'package:flutter/material.dart';

import 'oklch_color.dart'; // Replace with your actual OKLCHColor class

class OKLCHColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const OKLCHColorPicker({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  @override
  _OKLCHColorPickerState createState() => _OKLCHColorPickerState();
}

class _OKLCHColorPickerState extends State<OKLCHColorPicker> {
  late double lightness;
  late double chroma;
  late double hue;

  @override
  void initState() {
    super.initState();
    var oklch = OKLCHColor.convertColorToOKLCH(widget.color); // Convert initial color to OKLCH
    lightness = oklch[0];
    chroma = oklch[1];
    hue = oklch[2];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSlider("Lightness", lightness, 0, 100, (newValue) {
          setState(() => lightness = newValue);
          _updateColor();
        }, isHue: false),
        _buildSlider("Chroma", chroma, 0, 128, (newValue) {
          setState(() => chroma = newValue);
          _updateColor();
        }, isHue: false),
        _buildSlider("Hue", hue, 0, 360, (newValue) {
          setState(() => hue = newValue);
          _updateColor();
        }, isHue: true),
        Container(
          height: 50,
          color: OKLCHColor.fromOKLCH(lightness, chroma, hue),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged,
      {required bool isHue}) {
    return Row(
      children: <Widget>[
        Text(label),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: isHue ? GradientRectSliderTrackShape() : null,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
              divisions: isHue ? null : 10, // Optional: add divisions for non-hue sliders
            ),
          ),
        ),
      ],
    );
  }

  void _updateColor() {
    Color newColor = OKLCHColor.fromOKLCH(lightness, chroma, hue);
    widget.onColorChanged(newColor);
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    Offset? secondaryOffset, // Add this parameter
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Gradient gradient = LinearGradient(
      colors: <Color>[
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
        Colors.red,
      ],
    );

    final Paint paint = Paint()..shader = gradient.createShader(trackRect);
    context.canvas.drawRect(trackRect, paint);
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // Define the shape and size of the slider track
    // Adjust these values as per your design needs
    final double trackHeight = sliderTheme.trackHeight ?? 4;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
