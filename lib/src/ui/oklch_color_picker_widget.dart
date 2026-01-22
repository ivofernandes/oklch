import 'package:flutter/material.dart';
import 'package:oklch/src/oklch_color.dart';
import 'package:oklch/src/ui/gradient_rect_slider_track_shape.dart';

/// OKLCHColorPickerWidget provides a widget for
/// selecting colors in the OKLCH color space.
/// It allows the user to adjust lightness, chroma, and hue to choose a color.
class OKLCHColorPickerWidget extends StatefulWidget {
  /// OKLCHColorPickerWidget constructor
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

  /// The initial color for the picker
  final Color color;

  /// Callback for when the color changes
  final ValueChanged<Color> onColorChanged;

  /// List of colors to use for the hue slider
  final List<Color> hueColors;

  @override
  State<OKLCHColorPickerWidget> createState() =>
      _OKLCHColorPickerWidgetState();
}

class _OKLCHColorPickerWidgetState extends State<OKLCHColorPickerWidget> {
  static const double _minLightness = 0;
  static const double _maxLightness = 1;
  static const double _minChroma = 0;
  static const double _maxChroma = 0.6;
  static const double _minHue = 0;
  static const double _maxHue = 360;

  /// Lightness component of the OKLCH color model
  late double lightness;

  /// Chroma component, indicating the color intensity or purity
  late double chroma;

  /// Hue component, defining the type of color (like blue, green, etc.)
  late double hue;

  @override
  void initState() {
    super.initState();
    _syncFromColor(widget.color);
  }

  @override
  void didUpdateWidget(covariant OKLCHColorPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _syncFromColor(widget.color);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final previewColor = OKLCHColor.fromOKLCH(lightness, chroma, hue).toColor();
    final helperStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: previewColor,
            boxShadow: [
              BoxShadow(
                color: previewColor.withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Selected Color',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildSlider(
          label: 'Lightness',
          description: 'Shift from deep shadow to bright highlight.',
          value: lightness,
          min: _minLightness,
          max: _maxLightness,
          gradientColors: _gradientSamples(
            start: 0.05,
            end: 0.95,
            builder: (value) => OKLCHColor(value, chroma, hue).toColor(),
          ),
          onChanged: (newValue) => _updateChannel(
            value: newValue,
            channel: _OKLCHChannel.lightness,
          ),
        ),
        const SizedBox(height: 16),
        _buildSlider(
          label: 'Chroma',
          description: 'Control how vivid the color feels.',
          value: chroma,
          min: _minChroma,
          max: _maxChroma,
          gradientColors: _gradientSamples(
            start: _minChroma,
            end: _maxChroma,
            builder: (value) => OKLCHColor(lightness, value, hue).toColor(),
          ),
          onChanged: (newValue) => _updateChannel(
            value: newValue,
            channel: _OKLCHChannel.chroma,
          ),
        ),
        const SizedBox(height: 16),
        _buildSlider(
          label: 'Hue',
          description: 'Rotate through the color spectrum.',
          value: hue,
          min: _minHue,
          max: _maxHue,
          gradientColors: widget.hueColors,
          onChanged: (newValue) => _updateChannel(
            value: newValue,
            channel: _OKLCHChannel.hue,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ValueChip(
              label: 'OKLCH',
              value:
                  '(${lightness.toStringAsFixed(2)}, ${chroma.toStringAsFixed(2)}, ${hue.toStringAsFixed(2)})',
            ),
            _ValueChip(
              label: 'Hex',
              value: OKLCHColor.fromOKLCH(lightness, chroma, hue).rgbHex,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Drag the sliders or tap the gradient to dial in a color.',
          style: helperStyle,
        ),
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required String description,
    required double value,
    required double min,
    required double max,
    required List<Color> gradientColors,
    required ValueChanged<double> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value.toStringAsFixed(2),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 10),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 12,
            trackShape: GradientRectSliderTrackShape(gradientColors),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _updateColor() {
    final newColor = OKLCHColor.fromOKLCH(lightness, chroma, hue).toColor();
    widget.onColorChanged(newColor);
  }

  void _syncFromColor(Color color) {
    final oklch = OKLCHColor.fromColor(color);
    lightness = oklch.lightness;
    chroma = oklch.chroma;
    hue = oklch.hue;
  }

  void _updateChannel({
    required double value,
    required _OKLCHChannel channel,
  }) {
    setState(() {
      switch (channel) {
        case _OKLCHChannel.lightness:
          lightness = value;
          break;
        case _OKLCHChannel.chroma:
          chroma = value;
          break;
        case _OKLCHChannel.hue:
          hue = value;
          break;
      }
    });
    _updateColor();
  }

  List<Color> _gradientSamples({
    required double start,
    required double end,
    required Color Function(double value) builder,
    int steps = 8,
  }) {
    final samples = <Color>[];
    for (var i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      final value = start + (end - start) * t;
      samples.add(builder(value));
    }
    return samples;
  }
}

enum _OKLCHChannel { lightness, chroma, hue }

class _ValueChip extends StatelessWidget {
  const _ValueChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
        border: Border.all(
          color: theme.colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
